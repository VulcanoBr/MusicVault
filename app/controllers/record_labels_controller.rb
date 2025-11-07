class RecordLabelsController < ApplicationController
  before_action :set_record_label, only: [:show, :edit, :update, :destroy]

  # GET /record_labels
  def index
    @record_labels = RecordLabel.order(:name).page(params[:page]).per(10)
  end

  # GET /record_labels/1
  def show
    @media_physicals = @record_label.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /record_labels/new
  def new
    @record_label = RecordLabel.new
  end

  # GET /record_labels/1/edit
  def edit
  end

  # POST /record_labels
  def create
    @record_label = RecordLabel.new(record_label_params)

    if @record_label.save
      redirect_to @record_label, notice: 'GGravadora criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /record_labels/1
  def update
    if @record_label.update(record_label_params)
      redirect_to @record_label, notice: 'Gravadora atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /record_labels/1
  def destroy
    if @record_label.destroy
      redirect_to record_labels_url, notice: 'Gravadora excluído com sucesso.'
    else
      redirect_to record_labels_url, alert: 'Não é possível excluir esta gravadora pois existem mídias associadas.'
    end
  end

  private

  def set_record_label
    @record_label = RecordLabel.find(params[:id])
  end

  def record_label_params
    params.require(:record_label).permit(:name)
  end
end
