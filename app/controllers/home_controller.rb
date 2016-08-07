class HomeController < ApplicationController

	def index
		## filtering goes here
	end

  def elastic
    @activities = Activity.facets_search(params, :elastic)
    render_results(@activities)
  end

  def elastic_autocomplete
    render json: Activity.search(params[:term], fields: [{title: :text_start}], limit: 5).map(&:title)
  end

  def solr
    @activities = Kaminari.paginate_array([Activity.first]).page(1).per(20)
    render_results(@activities)
  end

  def algolia
    @activities = Kaminari.paginate_array([Activity.first]).page(1).per(20)
    render_results(@activities)
  end

  def materialized
    @activities = Activity.facets_search(params, :materialized)
    render_results(@activities)
  end

  def materialized_autocomplete
    if params[:term]
      term = params[:term]
      result = MaterializedSearchSuggestion.terms_for(term)
    else
      result = []
    end
    render :json => result[0, 5]
  end

end
