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
      tags: tags.map(&:title)
    }
  end

  class << self
    def facets_search(params)
      query = params[:q].presence || "*"
      page = params[:page].presence || 1
      per_page = params[:per_page].presence || 10

      conditions = {}
      updated_params = {}
      options.each do |option|
        if params[option].present?
          conditions[option] = cast_boolean(params[option])
        end
      end

      activities = Activity.search(query,
        where: conditions,
        aggs: options,
        suggest: true,
        page: page,
        per_page: per_page
      )
      activities
    end

    private

    def cast_boolean(str)
      ActiveRecord::Type::Boolean.new.cast(str.to_s.upcase)
    end

    def options
      [:camp ,:drop_in, :date_night, :indoor, :outdoor]
    end
  end


end
