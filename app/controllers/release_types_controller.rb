class ReleaseTypesController < ApplicationController
  before_action :set_release_type, only: [:show, :edit, :update, :destroy]

  # GET /release_types
  def index
    @release_types = ReleaseType.order(:name).page(params[:page]).per(10)
  end

  # GET /release_types/1
  def show
    @media_physicals = @release_type.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /release_types/new
  def new
    @release_type = ReleaseType.new
  end

  # GET /release_types/1/edit
  def edit
  end

  # POST /release_types
  def create
    @release_type = ReleaseType.new(release_type_params)

    if @release_type.save
      redirect_to @release_type, notice: 'Tipo de Lançamento criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /release_types/1
  def update
    if @release_type.update(release_type_params)
      redirect_to @release_type, notice: 'Tipo de Lançamento atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /release_types/1
  def destroy
    if @release_type.destroy
      redirect_to release_types_url, notice: 'Tipo de Lançamento excluído com sucesso.'
    else
      redirect_to release_types_url, alert: 'Não é possível excluir este tipo de lançamento pois existem mídias associadas.'
    end
  end

  private

  def set_release_type
    @release_type = ReleaseType.find(params[:id])
  end

  def release_type_params
    params.require(:release_type).permit(:name)
  end
end
