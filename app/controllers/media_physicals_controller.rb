class MediaPhysicalsController < ApplicationController
  # Usa um before_action para buscar o mídia nas ações show, edit, update, destroy
  before_action :set_media_physical, only: %i[ show edit update destroy ]
  before_action :load_form_collections, only: [:new, :edit, :create, :update]

  # GET /medias
  def index
    # Ordena por título do álbum para uma melhor visualização
    @media_physicals = MediaPhysical.includes(:media_type, :genre, :record_label, :country)
                  .order(album_title: :asc)

    @media_physicals = @media_physicals.by_media_type(params[:media_type]) if params[:media_type].present?
    @media_physicals = @media_physicals.by_artist(params[:artist]) if params[:artist].present?
    @media_physicals = @media_physicals.by_year(params[:year]) if params[:year].present?
    @media_physicals = @media_physicals.by_genre(params[:genre_id]) if params[:genre_id].present?

    @media_physicals = @media_physicals.page(params[:page]).per(10)

    # Para os filtros na view
    @media_types = MediaType.order(:name)
    @genres = Genre.order(:name)
  end

  # GET /medias/1
  def show
    @tracks = @media_physical.tracks.ordered
  end

  # GET /medias/new
  def new
    @media_physical = MediaPhysical.new
    # Constrói 3 faixas em branco para o formulário
    #3.times { @media.tracks.build }
    build_media_details
  end

  # GET /medias/1/edit
  def edit
    # Se não houver faixas, constrói algumas em branco para facilitar a adição
    #@media.tracks.build if @media.tracks.empty?
    build_media_details if @media_physical.media_detail.nil?
  end

  # POST /medias
  def create
    @media_physical = MediaPhysical.new(media_physical_params)

    if @media_physical.save
      redirect_to @media_physical, notice: "Álbum foi criado com sucesso."
    else
      # Se falhar, re-renderiza o formulário 'new' com os erros
      build_media_details
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /medias/1
  def update
    if @media_physical.update(media_physical_params)
      redirect_to @media_physical, notice: "Álbum foi atualizado com sucesso."
    else
      build_media_details
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /medias/1
  def destroy
    @media_physical.destroy!
    redirect_to media_physicals_path, notice: "Álbum foi excluído com sucesso."
  end

  # GET /media/search
  def search
    @media_types = MediaType.order(:name)
    @genres = Genre.order(:name)
    @query = params[:q]
    @media_physicals = MediaPhysical.includes(:media_type, :genre, :record_label)

    if @query.present?
      @media_physicals = @media_physicals.where(
        'album_title ILIKE ? OR artist_band ILIKE ?',
        "%#{@query}%",
        "%#{@query}%"
      )
    end

    @media_physicals = @media_physicals.order(:album_title).page(params[:page]).per(10)

    render :index
  end

  private

  # Método para buscar o mídia. Usado pelo before_action.
  def set_media_physical
    # Inclui as associações para evitar o problema N+1 queries na view 'show'
    @media_physical = MediaPhysical.includes(
      :media_type, :genre, :record_label, :imprint, :country, :release_type,
      :vinyl_detail, :cd_detail, :dvd_detail, :blu_ray_detail, :cassette_detail, :tracks
    ).find(params[:id])
  end

  def load_form_collections
    @media_types = MediaType.order(:name)
    @labels = RecordLabel.order(:name)
    @imprints = Imprint.order(:name)
    @genres = Genre.order(:name)
    @countries = Country.order(:name)
    @release_types = ReleaseType.order(:name)
    @cassette_types = CassetteType.order(:name)
    @cassette_durations = CassetteDuration.order(:name)
  end

  def build_media_details
    @media_physical.build_vinyl_detail unless @media_physical.vinyl_detail
    @media_physical.build_cd_detail unless @media_physical.cd_detail
    @media_physical.build_dvd_detail unless @media_physical.dvd_detail
    @media_physical.build_blu_ray_detail unless @media_physical.blu_ray_detail
    @media_physical.build_cassette_detail unless @media_physical.cassette_detail
  end

  # Método strong parameters para garantir a segurança.
  # Aqui permitimos os atributos da mídia e dos atributos aninhados.
  def media_physical_params
    params.require(:media_physical).permit(
      :media_type_id,
      :album_title,
      :artist_band,
      :record_label_id,
      :imprint_id,
      :genre_id,
      :country_id,
      :release_year,
      :release_type_id,
      :barcode,
      :label_code,
      :front_cover,
      :back_cover,
      :general_notes,

      # Permite os atributos dos detalhes de vinil aninhados
      vinyl_detail_attributes: [
        :id, :disc_quantity, :size, :speed, :color, :edition, :matrix_number, :_destroy
      ],

      # Permite os atributos dos detalhes de CD aninhados
      cd_detail_attributes: [
        :id, :disc_quantity, :_destroy
      ],

      # Permite os atributos dos detalhes de DVD aninhados
      dvd_detail_attributes: [
        :id, :disc_quantity, :_destroy
      ],

      # Permite os atributos dos detalhes de BLURAY aninhados
      blu_ray_detail_attributes: [
        :id, :disc_quantity, :_destroy
      ],

      # Permite os atributos dos detalhes de Cassete aninhados
      cassette_detail_attributes: [
        :id, :cassette_type_id, :cassette_duration_id, :_destroy
      ],

      # Permite os atributos das faixas aninhadas
      tracks_attributes: [
          :id, :track_number, :disc_number, :side, :track_title,  :track_artist_name,
          :composer, :featured_artist, :duration, :isrc, :track_notes, :_destroy
        ]
    )
  end
end
