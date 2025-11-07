class CassetteTypesController < ApplicationController
  before_action :set_cassette_type, only: [:show, :edit, :update, :destroy]

  # GET /cassette_types
  def index
    @cassette_types = CassetteType.order(:name).page(params[:page]).per(10)
  end

  # GET /cassette_types/1
  def show

  end

  # GET /cassette_types/new
  def new
    @cassette_type = CassetteType.new
  end

  # GET /cassette_types/1/edit
  def edit
  end

  # POST /cassette_types
  def create
    @cassette_type = CassetteType.new(cassette_type_params)

    if @cassette_type.save
      redirect_to @cassette_type, notice: 'Tipo de Cassete criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cassette_types/1
  def update
    if @cassette_type.update(cassette_type_params)
      redirect_to @cassette_type, notice: 'Tipo de Cassete atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cassette_types/1
  def destroy
    if @cassette_type.destroy
      redirect_to cassette_types_path, notice: 'Tipo de Cassete excluído com sucesso.'
    else
      redirect_to cassette_types_path, alert: 'Não é possível excluir este tipo de cassete pois existem mídias associadas.'
    end
  end

  private

  def set_cassette_type
    @cassette_type = CassetteType.find(params[:id])
  end

  def cassette_type_params
    params.require(:cassette_type).permit(:name)
  end
end
