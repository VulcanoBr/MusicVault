class CassetteDurationsController < ApplicationController
  before_action :set_cassette_duration, only: [:show, :edit, :update, :destroy]

  # GET /cassette_durations
  def index
    @cassette_durations = CassetteDuration.order(:name).page(params[:page]).per(10)
  end

  # GET /cassette_durations/1
  def show

  end

  # GET /cassette_durations/new
  def new
    @cassette_duration = CassetteDuration.new
  end

  # GET /cassette_durations/1/edit
  def edit
  end

  # POST /cassette_durations
  def create
    @cassette_duration = CassetteDuration.new(cassette_duration_params)

    if @cassette_duration.save
      redirect_to @cassette_duration, notice: 'Duração do Cassete criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cassette_durations/1
  def update
    if @cassette_duration.update(cassette_duration_params)
      redirect_to @cassette_duration, notice: 'Duração do Cassete atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cassette_durations/1
  def destroy
    if @cassette_duration.destroy
      redirect_to cassette_durations_path, notice: 'Duração do Cassete excluído com sucesso.'
    else
      redirect_to cassette_durations_path, alert: 'Não é possível excluir este tipo de duração do cassete pois existem mídias associadas.'
    end
  end

  private

  def set_cassette_duration
    @cassette_duration = CassetteDuration.find(params[:id])
  end

  def cassette_duration_params
    params.require(:cassette_duration).permit(:name)
  end
end
