class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  # GET /Countries
  def index
    @countries = Country.order(:name).page(params[:page]).per(10)
  end

  # GET /Countries/1
  def show
    @media_physicals = @country.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /Countries/new
  def new
    @country = Country.new
  end

  # GET /Countries/1/edit
  def edit
  end

  # POST /Countries
  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to @country, notice: 'País criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /Countries/1
  def update
    if @country.update(country_params)
      redirect_to @country, notice: 'País atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /Countries/1
  def destroy
    if @country.destroy
      redirect_to countries_path, notice: 'País excluído com sucesso.'
    else
      redirect_to countries_path, alert: 'Não é possível excluir este país pois existem mídias associadas.'
    end
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:name, :code, :flag_code)
  end
end
