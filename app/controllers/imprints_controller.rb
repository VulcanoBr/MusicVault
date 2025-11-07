class ImprintsController < ApplicationController
  before_action :set_imprint, only: [:show, :edit, :update, :destroy]

  # GET /imprints
  def index
    @imprints = Imprint.order(:name).page(params[:page]).per(10)
  end

  # GET /imprints/1
  def show
    @media_physicals = @imprint.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /imprints/new
  def new
    @imprint = Imprint.new
  end

  # GET /imprints/1/edit
  def edit
  end

  # POST /imprints
  def create
    @imprint = Imprint.new(imprint_params)

    if @imprint.save
      redirect_to @imprint, notice: 'Selo criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /imprints/1
  def update
    if @imprint.update(imprint_params)
      redirect_to @imprint, notice: 'Selo atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /imprints/1
  def destroy
    if @imprint.destroy
      redirect_to imprints_url, notice: 'Selo excluído com sucesso.'
    else
      redirect_to imprints_url, alert: 'Não é possível excluir este selo pois existem mídias associadas.'
    end
  end

  private

  def set_imprint
    @imprint = Imprint.find(params[:id])
  end

  def imprint_params
    params.require(:imprint).permit(:name)
  end
end
