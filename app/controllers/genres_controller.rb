class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]

  # GET /genres
  def index
    @genres = Genre.order(:name).page(params[:page]).per(10)
  end

  # GET /genres/1
  def show
    @media_physicals = @genre.media_physicals.includes(:media_type).order(album_title: :asc).page(params[:page]).per(10)
  end

  # GET /genres/new
  def new
    @genre = Genre.new
  end

  # GET /genres/1/edit
  def edit
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to @genre, notice: 'Gênero criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/1
  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: 'Gênero atualizado com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1
  def destroy
    if @genre.destroy
      redirect_to genres_url, notice: 'Gênero excluído com sucesso.'
    else
      redirect_to genres_url, alert: 'Não é possível excluir este gênero pois existem mídias associadas.'
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
