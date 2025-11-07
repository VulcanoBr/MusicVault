class TracksController < ApplicationController
  before_action :set_media_physical
  before_action :set_track, only: [:show, :edit, :update, :destroy]

  # GET /media/:media_id/tracks
  def index
    @tracks = @media_physical.tracks.ordered
  end

  def show; end

  # GET /media/:media_id/tracks/new
  def new
    @track = @media_physical.tracks.build
    set_default_track_number
  end

  # GET /media/:media_id/tracks/1/edit
  def edit
  end

  # POST /media/:media_id/tracks
  def create
    @track = @media_physical.tracks.build(track_params)

    if @track.save
      redirect_to media_physical_path(@media_physical), notice: 'Faixa adicionada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media/:media_id/tracks/1
  def update
    if @track.update(track_params)
      redirect_to media_physical_path(@media_physical), notice: 'Faixa atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /media/:media_id/tracks/1
  def destroy
    @track.destroy
    redirect_to media_physical_path(@media_physical), notice: 'Faixa excluída com sucesso.'
  end

  # POST /media/:media_id/tracks/bulk_create
  def bulk_create
    track_count = params[:track_count].to_i
    disc_number = params[:disc_number].to_i
    side = params[:side]

    track_count.times do |i|
      @media_physical.tracks.create(
        track_number: i + 1,
        disc_number: disc_number > 0 ? disc_number : 1,
        side: side,
        track_title: "Faixa #{i + 1}"
      )
    end

    redirect_to media_physical_path(@media), notice: "#{track_count} faixas criadas com sucesso."
  end

  private

  def set_media_physical
    @media_physical = MediaPhysical.find(params[:media_physical_id])
  end

  def set_track
    @track = @media_physical.tracks.find(params[:id])
  end

  def set_default_track_number
    last_track = @media_physical.tracks.order(:track_number).last
    @track.track_number = last_track ? last_track.track_number + 1 : 1
    @track.disc_number = params[:disc_number].to_i if params[:disc_number].present?
    @track.side = params[:side] if params[:side].present?
  end

  def track_params
    params.require(:track).permit(
      :track_number,
      :disc_number,
      :side,
      :track_title,
      :track_artist_name,
      :composer,
      :featured_artist,
      :duration,
      :isrc,
      :track_notes
    )
  end
end
