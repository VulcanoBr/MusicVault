class MediaTypesController < ApplicationController
  before_action :set_media_type, only: [:show, :edit, :update, :destroy]

  # GET /media_types
  def index
    @media_types = MediaType.order(:name).page(params[:page]).per(10)
  end

  # GET /media_types/1
  def show
    @media_physicals = @media_type.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /media_types/new
  def new
    @media_type = MediaType.new
  end

  # GET /media_types/1/edit
  def edit
  end

  # POST /media_types
  def create
    @media_type = MediaType.new(media_type_params)

    if @media_type.save
      redirect_to @media_type, notice: 'Tipo de Midia criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /media_types/1
  def update
    if @media_type.update(media_type_params)
      redirect_to @media_type, notice: 'Tipo de Midia atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /media_types/1
  def destroy
    if @media_type.destroy
      redirect_to media_types_url, notice: 'Tipo de Midia excluído com sucesso.'
    else
      redirect_to media_types_url, alert: 'Não é possível excluir este tipo de midia pois existem mídias associadas.'
    end
  end

  private

  def set_media_type
    @media_type = MediaType.find(params[:id])
  end

  def media_type_params
    params.require(:media_type).permit(:name)
  end
end
