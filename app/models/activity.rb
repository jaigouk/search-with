class Activity < ApplicationRecord
	has_many :activity_tags
  has_many :tags, through: :activity_tags
  has_one :activity_location
  has_one :location, through: :activity_location

  ## for Materilized View
  after_commit :refresh_view

  ## for ElasticSearch - searchkick
  searchkick text_start: [:title],
             suggest: [:title],
             settings: {index: {max_result_window: 10000}}

  ## for ElasticSearch - searchkick
  def search_data
    {
      title: title,
      about: about,
      start_months_old: start_months_old,
      end_months_old: end_months_old,
      camp: camp,
      drop_in: drop_in,
      date_night: date_night,
      indoor: indoor,
      outdoor: outdoor,
      tags: tags.map(&:title)
    }
  end

  def self.facets_search(params, type = :elastic)
    query = params[:q].presence || "*"
    page = params[:page].presence || 1
    per_page = params[:per_page].presence || 10
    con = conditions(params)

    activities = case type
      when :elastic
        self.elastic_search(query, con, page, per_page)
      when :materialized
        self.materialized_search(query, con, page, per_page)
      end
    activities
  end

  def self.elastic_search(query, conditions, page, per_page)
    Activity.search(query,
      where: conditions,
      aggs: activity_options,
      suggest: true,
      page: page,
      per_page: per_page,
      include: [:tags, :location]
    )
  end

  def self.materialized_search(query, conditions, page, per_page)
    keyword = (query == "*") ? "" : query
    result = MaterializedSearchResult.new(keyword, conditions)
    Kaminari.paginate_array(result).page(page).per(per_page)
  end

  def self.activity_options
    [:camp ,:drop_in, :date_night, :indoor, :outdoor]
  end

  def options
    options = []
    [:camp ,:drop_in, :date_night, :indoor, :outdoor].each{|x| options << x.to_s if send(x) }
    options
  end

  private

  def refresh_view
     MaterializedSearchResult.refresh
  end

  def self.conditions(params)
    result = {}

    self.activity_options.each do |option|
      if params[option].present?
        result[option] = cast_boolean(params[option])
      end
    end
    result
  end

  def self.cast_boolean(str)
    return true if str.is_a?(String) && str.downcase == "true"
    return false if str.is_a?(String) && str.downcase == "false"
  end
end
