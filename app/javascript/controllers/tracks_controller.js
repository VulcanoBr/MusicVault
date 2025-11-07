import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="tracks"
export default class extends Controller {
  static targets = ['container', 'template', 'item', 'emptyMessage']

  connect() {
    console.log('Tracks Controller connected')
    this.updateTrackNumbers()
    this.checkEmpty()
    // Aplica campos dinâmicos nas faixas existentes
    this.applyDynamicFields()
  }

  disconnect() {
    // Limpa o listener quando o controller é desconectado
    this.element.removeEventListener(
      'media-type-changed',
      this.handleMediaTypeChange.bind(this)
    )
  }

  handleMediaTypeChange(event) {
    console.log('Media type changed, updating track fields')
    this.applyDynamicFields()
  }

  addTrack(event) {
    event.preventDefault()

    console.log('Adding new track...')

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

    console.log('Track added successfully')
  }

  removeTrack(event) {
    event.preventDefault()

    const trackItem = event.target.closest('[data-tracks-target="item"]')
    if (!trackItem) return

    console.log('Removing track...')

    // Verifica se é um registro existente (tem ID) ou novo
    const idInput = trackItem.querySelector('input[name*="[id]"]')
    const destroyInput = trackItem.querySelector('input[name*="_destroy"]')

    if (idInput && idInput.value && destroyInput) {
      // É um registro salvo - marca para destruição
      console.log('Marking existing track for destruction')
      destroyInput.value = '1'
      trackItem.style.display = 'none'
    } else {
      // É um registro novo - remove do DOM
      console.log('Removing new track from DOM')
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

    console.log(
      `Updating track numbers for ${visibleTracks.length} visible tracks`
    )

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
      console.log('No tracks visible, showing empty message')

      const emptyMessage = `
        <div class="text-center py-4 text-muted" data-tracks-target="emptyMessage">
          <i class="bi bi-music-note" style="font-size: 2rem;"></i>
          <p class="mt-2">Nenhuma faixa adicionada. Clique em "Adicionar Faixa" para começar.</p>
        </div>
      `
      this.containerTarget.insertAdjacentHTML('beforeend', emptyMessage)
    } else if (visibleTracks.length > 0 && this.hasEmptyMessageTarget) {
      console.log('Tracks exist, removing empty message')
      this.emptyMessageTarget.remove()
    }
  }

  applyDynamicFields() {
    // Pega o tipo de mídia selecionado
    const mediaTypeSelect = document.querySelector(
      'select[name="media_physical[media_type_id]"]'
    )
    if (!mediaTypeSelect) return

    const selectedOption =
      mediaTypeSelect.options[mediaTypeSelect.selectedIndex]
    const selectedText = selectedOption ? selectedOption.text : ''

    console.log('Applying dynamic fields for media type:', selectedText)

    // Determina o tipo de mídia
    let mediaType = null
    if (selectedText.includes('Vinyl')) {
      mediaType = 'vinyl'
    } else if (selectedText === 'CD') {
      mediaType = 'cd'
    } else if (selectedText === 'DVD') {
      mediaType = 'dvd'
    } else if (selectedText === 'BLURAY') {
      mediaType = 'bluray'
    } else if (selectedText.includes('Cassette Tape')) {
      mediaType = 'cassette'
    }

    if (!mediaType) return

    // Aplica regras para campos dinâmicos
    const vinylCassetteFields = document.querySelectorAll(
      '[data-vinyl-cassette-field]'
    )
    const multiDiscFields = document.querySelectorAll('[data-multi-disc-field]')

    // Reseta todos
    vinylCassetteFields.forEach(field => {
      field.style.display = 'none'
    })

    multiDiscFields.forEach(field => {
      field.style.display = 'none'
    })

    // Mostra campos de Lado para Vinil e Cassete
    if (mediaType === 'vinyl' || mediaType === 'cassette') {
      vinylCassetteFields.forEach(field => {
        field.style.display = 'block'
      })
    }

    // Verifica quantidade de discos
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

    //if (quantityInput && parseInt(quantityInput.value) > 1) {
    //  multiDiscFields.forEach(field => {
    //    field.style.display = 'block'
    //})
    //}

    if (quantityInput) {
      const quantity = parseInt(quantityInput.value)
      console.log(`Disc quantity: ${quantity}`)

      if (quantity > 1) {
        console.log('Showing disc number fields')
        multiDiscFields.forEach(field => {
          field.style.display = 'block'
        })
      }
    }
  }
}
