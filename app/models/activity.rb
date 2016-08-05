class Activity < ApplicationRecord
	has_many :activity_tags
  has_many :tags, through: :activity_tags
  has_one :activity_location
  has_one :location, through: :activity_location

  ## ElasticSearch - searchkick
  #
  #
  searchkick text_start: [:title],
             suggest: [:title],
             settings: {index: {max_result_window: 10000}}

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

  class << self
    def facets_search(params)
      query = params[:q].presence || "*"
      page = params[:page].presence || 1
      per_page = params[:per_page].presence || 10

      activities = Activity.search(query,
        where: conditions(params),
        aggs: options,
        suggest: true,
        page: page,
        per_page: per_page
      )
      # binding.pry
      activities
    end

    private
    #####
    # Searchkik
    # https://github.com/ankane/searchkick
    #
    # where: {
    #   expires_at: {gt: Time.now}, # lt, gte, lte also available
    #   orders_count: 1..10,        # equivalent to {gte: 1, lte: 10}
    #   aisle_id: [25, 30],         # in
    #   store_id: {not: 2},         # not
    #   aisle_id: {not: [25, 30]},  # not in
    #   user_ids: {all: [1, 3]},    # all elements in array
    #   category: /frozen .+/,      # regexp
    #   or: [
    #     [{in_stock: true}, {backordered: true}]
    #   ]
    # }
    def conditions(params)
      result = {}

      options.each do |option|
        if params[option].present?
          result[option] = [cast_boolean(params[option])]
        end
      end
      result
    end

    def cast_boolean(str)
      str.is_a?(String) && str.downcase == "true"
      # ActiveRecord::Type::Boolean.new.cast(str.to_s.upcase)
    end

    def options
      [:camp ,:drop_in, :date_night, :indoor, :outdoor]
    end
  end


end
