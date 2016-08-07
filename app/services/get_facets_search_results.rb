# frozen_string_literal: true
class GetFacetsSearchResults < BaseService
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def with(params, type)
    self.class.new(params, type)
  end

  def call(params)
    case @type
    when :elastic
      elastic_search(params)
    when :materialized
      materialized_search(params)
    end
  end

private

  def elastic_search(params)
    Activity.search(query(params), where: options(params), aggs: activity_options(),
      suggest: true, page: page(params), per_page: per_page(params),
      include: [:tags, :location]
    )
  end

  def materialized_search(params)
    Kaminari.paginate_array(
      MaterializedSearchResult.new(query_for_materialized(params), options(params))
    ).page(page(params)).per(per_page(params))
  end

  def query_for_materialized(params)
    (params[:q] == "*") ? "" : params[:q]
  end

  def activity_options
    [:camp ,:drop_in, :date_night, :indoor, :outdoor]
  end

  def query(params)
    params[:q].presence || "*"
  end

  def options(params)
    result = {}

    activity_options.each do |option|
      if params[option].present?
        result[option] = cast_boolean(params[option])
      end
    end
    result
  end

  def page(params)
    params[:page].presence || 1
  end

  def per_page(params)
    params[:per_page].presence || 10
  end

  def cast_boolean(str)
    return true if str.is_a?(String) && str.downcase == "true"
    return false if str.is_a?(String) && str.downcase == "false"
  end
end
