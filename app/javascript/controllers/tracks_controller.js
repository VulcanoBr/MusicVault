import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="tracks"
export default class extends Controller {
  static targets = ['container', 'template', 'item', 'emptyMessage']

  connect() {
    console.log('Tracks Controller connected')
    this.updateTrackNumbers()
    this.checkEmpty()

    // Adiciona o listener para mudanças no tipo de mídia
    this.setupMediaTypeListener()

    // Aplica campos dinâmicos nas faixas existentes
    this.applyDynamicFields()

    // Escuta mudanças no tipo de mídia
    this.element.addEventListener(
      'media-type-changed',
      this.handleMediaTypeChange.bind(this)
    )
  }

  setupMediaTypeListener() {
    // Encontra o select de tipo de mídia dentro do escopo do controller
    const mediaTypeSelect = this.element.querySelector(
      'select[name="media_physical[media_type_id]"]'
    )

    if (mediaTypeSelect) {
      // Usa um arrow function para manter `this` apontando para o controller
      mediaTypeSelect.addEventListener('change', () => {
        this.applyDynamicFields()
      })
    }
  }

  disconnect() {
    // Limpa o listener quando o controller é desconectado
    this.element.removeEventListener(
      'media-type-changed',
      this.handleMediaTypeChange.bind(this)
    )
  }

  handleMediaTypeChange(event) {
    this.applyDynamicFields()
  }

  addTrack(event) {
    event.preventDefault()

    // Remove mensagem de vazio se existir
    if (this.hasEmptyMessageTarget) {
      this.emptyMessageTarget.remove()
    }

    // Pega o conteúdo do template e substitui NEW_RECORD por timestamp único
    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    )

    // Insere no container
    this.containerTarget.insertAdjacentHTML('beforeend', content)

    // Atualiza numeração
    this.updateTrackNumbers()

    // Aplica campos dinâmicos na nova faixa
    this.applyDynamicFields()

    // Scroll suave para a nova faixa
    const newTrack = this.containerTarget.lastElementChild
    if (newTrack) {
      newTrack.scrollIntoView({ behavior: 'smooth', block: 'nearest' })

      // Foca no campo de título após um delay para animação
      const titleInput = newTrack.querySelector('input[id*="track_title"]')
      if (titleInput) {
        setTimeout(() => titleInput.focus(), 300)
      }
    }
  }

  removeTrack(event) {
    event.preventDefault()

    const trackItem = event.target.closest('[data-tracks-target="item"]')
    if (!trackItem) return

    // Verifica se é um registro existente (tem ID) ou novo
    const idInput = trackItem.querySelector('input[name*="[id]"]')
    const destroyInput = trackItem.querySelector('input[name*="_destroy"]')

    if (idInput && idInput.value && destroyInput) {
      // É um registro salvo - marca para destruição
      destroyInput.value = '1'
      trackItem.style.display = 'none'
    } else {
      // É um registro novo - remove do DOM
      trackItem.remove()
    }

    // Atualiza numeração das faixas visíveis
    this.updateTrackNumbers()
    this.checkEmpty()
  }

  updateTrackNumbers() {
    // Pega apenas as faixas visíveis
    const visibleTracks = Array.from(this.itemTargets).filter(item => {
      return item.style.display !== 'none'
    })

    visibleTracks.forEach((track, index) => {
      const numberInput = track.querySelector('input[id*="track_number"]')
      if (numberInput) {
        // Se o campo está vazio, preenche automaticamente
        if (!numberInput.value || numberInput.value === '0') {
          numberInput.value = index + 1
        }
      }
    })
  }

  checkEmpty() {
    const visibleTracks = Array.from(this.itemTargets).filter(item => {
      return item.style.display !== 'none'
    })

    if (visibleTracks.length === 0 && !this.hasEmptyMessageTarget) {
      const emptyMessage = `
        <div class="text-center py-4 text-muted" data-tracks-target="emptyMessage">
          <i class="bi bi-music-note" style="font-size: 2rem;"></i>
          <p class="mt-2">Nenhuma faixa adicionada. Clique em "Adicionar Faixa" para começar.</p>
        </div>
      `
      this.containerTarget.insertAdjacentHTML('beforeend', emptyMessage)
    } else if (visibleTracks.length > 0 && this.hasEmptyMessageTarget) {
      this.emptyMessageTarget.remove()
    }
  }

  applyDynamicFields() {
    // Pega o tipo de mídia selecionado
    const mediaTypeSelect = document.querySelector(
      'select[name="media_physical[media_type_id]"]'
    )

    if (!mediaTypeSelect) {
      return
    }

    const selectedOption =
      mediaTypeSelect.options[mediaTypeSelect.selectedIndex]
    const selectedText = selectedOption ? selectedOption.text : ''

    // Determina o tipo de mídia
    let mediaType = null
    if (selectedText.includes('Vinyl')) {
      mediaType = 'vinyl'
    } else if (selectedText === 'CD') {
      mediaType = 'cd'
    } else if (selectedText === 'DVD') {
      mediaType = 'dvd'
    } else if (selectedText === 'Blu-Ray' || selectedText.includes('Blu')) {
      mediaType = 'bluray'
    } else if (selectedText.includes('Cassette')) {
      mediaType = 'cassette'
    }

    if (!mediaType) {
      // Se não conseguiu determinar, esconde todos os campos dinâmicos
      this.hideAllDynamicFields()
      return
    }

    // Pega TODOS os campos dinâmicos
    const vinylCassetteFields = document.querySelectorAll(
      '[data-vinyl-cassette-field]'
    )
    const multiDiscFields = document.querySelectorAll('[data-multi-disc-field]')

    // PRIMEIRO: Esconde todos
    vinylCassetteFields.forEach(field => {
      field.style.display = 'none'
      // Limpa o valor do select APENAS se está escondendo e não tem valor persistido
      const select = field.querySelector('select')
      if (select && !select.value) {
        select.selectedIndex = 0 // Reset para "Selecione..."
      }
    })

    multiDiscFields.forEach(field => {
      field.style.display = 'none'
    })

    // SEGUNDO: Mostra campos de Lado para Vinil e Cassete
    if (mediaType === 'vinyl' || mediaType === 'cassette') {
      vinylCassetteFields.forEach(field => {
        field.style.display = 'block'
      })
    }

    // TERCEIRO: Verifica quantidade de discos
    let quantityInput = null

    if (mediaType === 'vinyl') {
      quantityInput = document.querySelector(
        '[name="media_physical[vinyl_detail_attributes][disc_quantity]"]'
      )
    } else if (mediaType === 'cd') {
      quantityInput = document.querySelector(
        '[name="media_physical[cd_detail_attributes][disc_quantity]"]'
      )
    } else if (mediaType === 'dvd') {
      quantityInput = document.querySelector(
        '[name="media_physical[dvd_detail_attributes][disc_quantity]"]'
      )
    } else if (mediaType === 'bluray') {
      quantityInput = document.querySelector(
        '[name="media_physical[blu_ray_detail_attributes][disc_quantity]"]'
      )
    }

    if (quantityInput) {
      const quantity = parseInt(quantityInput.value) || 1

      if (quantity > 1) {
        multiDiscFields.forEach(field => {
          field.style.display = 'block'
        })
      }
    } else {
      console.log('Quantity input not found')
    }
  }

  // MÉTODO AUXILIAR NOVO
  hideAllDynamicFields() {
    const vinylCassetteFields = document.querySelectorAll(
      '[data-vinyl-cassette-field]'
    )
    const multiDiscFields = document.querySelectorAll('[data-multi-disc-field]')

    vinylCassetteFields.forEach(field => {
      field.style.display = 'none'
    })

    multiDiscFields.forEach(field => {
      field.style.display = 'none'
    })
  }
}
