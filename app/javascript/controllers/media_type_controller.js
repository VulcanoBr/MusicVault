import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="media-type"
export default class extends Controller {
  static targets = [
    'vinylDetails',
    'cdDetails',
    'dvdDetails',
    'blurayDetails',
    'cassetteDetails',
    'mediaTypeSelect'
  ]

  connect() {
    // Executa ao conectar para mostrar detalhes corretos se estiver editando
    console.log('Media Conectado!!')
    this.toggleDetails()
    this.setupDiscQuantityListeners()
  }

  toggleDetails() {
    console.log('Derails')
    //const select = this.element.querySelector(
    //   'select[name="media_physical[media_type_id]"]'
    //)
    const select = this.mediaTypeSelectTarget
    console.log('select ', select)
    // if (!select) return

    const selectedOption = select.options[select.selectedIndex]
    const selectedText = selectedOption ? selectedOption.text : ''
    console.log('selectOption ', selectedOption, 'selectText ', selectedText)
    const selectedValue = selectedOption ? selectedOption.value : ''

    // Esconde todos
    this.hideAllDetails()

    // Mostra o relevante
    if (selectedText === 'Vinyl') {
      console.log('Mostrando Vinyl Details')
      this.showTarget(this.vinylDetailsTarget)
      this.toggleTrackFields('vinyl')
    } else if (selectedText === 'CD') {
      console.log('Mostrando CD Details')
      this.showTarget(this.cdDetailsTarget)
      this.toggleTrackFields('cd')
    } else if (selectedText === 'DVD') {
      console.log('Mostrando DVD Details')
      this.showTarget(this.dvdDetailsTarget)
      this.toggleTrackFields('dvd')
    } else if (selectedText === 'Blu-Ray') {
      // CORRIGIDO
      console.log('Mostrando Blu-Ray Details')
      this.showTarget(this.blurayDetailsTarget)
      this.toggleTrackFields('bluray')
    } else if (selectedText === 'Cassette Tape') {
      console.log('Mostrando Cassette Details')
      this.showTarget(this.cassetteDetailsTarget)
      this.toggleTrackFields('cassette')
    }

    // Notifica o tracks controller
    this.notifyTracksController()
  }

  hideAllDetails() {
    if (this.hasVinylDetailsTarget)
      this.vinylDetailsTarget.style.display = 'none'
    if (this.hasCdDetailsTarget) this.cdDetailsTarget.style.display = 'none'
    if (this.hasDvdDetailsTarget) this.dvdDetailsTarget.style.display = 'none'
    if (this.hasBlurayDetailsTarget)
      this.blurayDetailsTarget.style.display = 'none'
    if (this.hasCassetteDetailsTarget)
      this.cassetteDetailsTarget.style.display = 'none'
  }

  showTarget(target) {
    if (target) {
      target.style.display = 'block'
      // Adiciona animação suave
      target.style.animation = 'fadeIn 0.3s ease-in'
    }
  }

  toggleTrackFields(mediaType) {
    console.log('Toggling track fields for:', mediaType)

    // Mostra/esconde campos específicos nas faixas baseado no tipo de mídia
    const vinylCassetteFields = document.querySelectorAll(
      '[data-vinyl-cassette-field]'
    )
    const multiDiscFields = document.querySelectorAll('[data-multi-disc-field]')

    // Reseta todos
    vinylCassetteFields.forEach(field => {
      field.style.display = 'none'
      // Limpa o valor se está escondendo
      const input = field.querySelector('select, input')
      if (input) input.value = ''
    })

    multiDiscFields.forEach(field => {
      field.style.display = 'none'
    })

    // Mostra campos relevantes
    if (mediaType === 'vinyl' || mediaType === 'cassette') {
      vinylCassetteFields.forEach(field => {
        field.style.display = 'block'
      })
    }

    // Verifica quantidade de discos para mostrar campo disco_number
    this.checkMultiDisc(mediaType)
  }

  checkMultiDisc(mediaType) {
    let quantityInput
    console.log('CheckMultiDisc:', mediaType)

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
    } else if (mediaType === 'blu-ray') {
      quantityInput = document.querySelector(
        '[name="media_physical[blu_ray_detail_attributes][disc_quantity]"]'
      )
    }

    if (quantityInput) {
      this.updateMultiDiscFields(quantityInput.value)
    }
  }

  setupDiscQuantityListeners() {
    // Listeners para mudanças na quantidade de discos
    const vinylQuantity = document.querySelector(
      '[name="media_physical[vinyl_detail_attributes][disc_quantity]"]'
    )
    const cdQuantity = document.querySelector(
      '[name="media_physical[cd_detail_attributes][disc_quantity]"]'
    )
    const dvdQuantity = document.querySelector(
      '[name="media_physical[dvd_detail_attributes][disc_quantity]"]'
    )
    const blurayQuantity = document.querySelector(
      '[name="media_physical[blu_ray_detail_attributes][disc_quantity]"]'
    )

    if (vinylQuantity) {
      vinylQuantity.addEventListener('input', e => {
        this.updateMultiDiscFields(e.target.value)
      })
    }

    if (cdQuantity) {
      cdQuantity.addEventListener('input', e => {
        this.updateMultiDiscFields(e.target.value)
      })
    }

    if (dvdQuantity) {
      dvdQuantity.addEventListener('input', e => {
        this.updateMultiDiscFields(e.target.value)
      })
    }

    if (blurayQuantity) {
      blurayQuantity.addEventListener('input', e => {
        this.updateMultiDiscFields(e.target.value)
      })
    }
  }

  updateMultiDiscFields(quantity) {
    const showMultiDisc = parseInt(quantity) > 1
    const multiDiscFields = document.querySelectorAll('[data-multi-disc-field]')

    multiDiscFields.forEach(field => {
      field.style.display = showMultiDisc ? 'block' : 'none'

      // Se está escondendo, limpa os valores
      if (!showMultiDisc) {
        const input = field.querySelector('input')
        if (input) input.value = '1' // Reseta para disco 1
      }
    })
  }

  notifyTracksController() {
    // Dispara um evento customizado para o tracks controller reagir
    const event = new CustomEvent('media-type-changed', {
      bubbles: true,
      detail: { source: 'media-type-controller' }
    })
    this.element.dispatchEvent(event)
  }
}
