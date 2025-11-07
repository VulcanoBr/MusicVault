# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @total_media = MediaPhysical.count
    @total_vinyl = MediaPhysical.by_media_type(MediaType::VINYL).count
    @total_cd = MediaPhysical.by_media_type(MediaType::CD).count
    @total_dvd = MediaPhysical.by_media_type(MediaType::DVD).count
    @total_bluray = MediaPhysical.by_media_type(MediaType::BLURAY).count
    @total_cassette = MediaPhysical.by_media_type(MediaType::CASSETTE).count

    @recent_media = MediaPhysical.includes(:media_type, :genre)
                          .order(created_at: :desc)
                          .limit(10)

    @genres_stats = Genre.joins(:media_physicals)
                         .select('genres.*, COUNT(media_physicals.id) as media_count')
                         .group('genres.id')
                         .order('media_count DESC')
                         .limit(10)

    @countries_stats = Country.joins(:media_physicals)
                              .select('countries.*, COUNT(media_physicals.id) as media_count')
                              .group('countries.id')
                              .order('media_count DESC')
                              .limit(10)

    @media_by_year = MediaPhysical.where.not(release_year: nil)
                           .group(:release_year)
                           .count
                           .sort_by { |year, _| year }
                           .reverse
                           .first(10)
  end

  def all_genres
    @genres = Genre.joins(:media_physicals)
                   .select('genres.*, COUNT(media_physicals.id) as media_count')
                   .group('genres.id')
                   .order('genres.name ASC').page(params[:page]).per(10)
  end

  def all_years
    # Pega todos os anos com contagem
    all_years_hash = MediaPhysical.where.not(release_year: nil)
                                  .group(:release_year)
                                  .count
                                  .sort_by { |year, _| year }
                                  .reverse

    # Converte hash para array de objetos paginável
    @years = Kaminari.paginate_array(all_years_hash).page(params[:page]).per(10)

    # Calcula o máximo para a barra de progresso (de todos os anos, não só da página)
    @max_count = all_years_hash.values_at.max || 1
  end

  def by_genre
    @genre = Genre.find(params[:id])
    @media = @genre.media_physicals
                   .includes(:media_type, :record_label, :country)
                   .order(album_title: :asc)
                   .page(params[:page]).per(10)
  end

  def by_year
    @year = params[:year].to_i
    @media = MediaPhysical.where(release_year: @year)
                          .includes(:media_type, :genre, :record_label)
                          .order(album_title: :asc)
                          .page(params[:page]).per(10)
  end

  def all_countries
    @countries = Country.joins(:media_physicals)
                        .select('countries.*, COUNT(media_physicals.id) as media_count')
                        .group('countries.id')
                        .order('countries.name ASC')
                        .page(params[:page])
                        .per(10)
  end

  def by_country
    @country = Country.find(params[:id])
    @media = @country.media_physicals
                   .includes(:media_type, :genre, :record_label)
                   .order(album_title: :asc)
                   .page(params[:page])
                   .per(10)
  end
end
