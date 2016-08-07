class HomeController < ApplicationController

	def index
		## filtering goes here
	end

  def elastic
    elastic_search = GetFacetsSearchResults.new(:elastic)
    @activities = elastic_search.call(params)
    render_results(@activities)
  end

  def elastic_autocomplete
    render json: Activity.search(params[:term], fields: [{title: :text_start}], limit: 5).map(&:title)
  end

  def solr
    @activities = Activity.search do
      with :date_night, true if params.has_key?(:date_night)
      with :drop_in, true if params.has_key?(:drop_in)
      with :camp, true if params.has_key?(:camp)
      with :outdoor, true if params.has_key?(:outdoor)
      with :indoor, true if params.has_key?(:indoor)
      fulltext params[:term]
    end.results
      
    render_results(@activities)
    # @activities = Kaminari.paginate_array([Activity.first]).page(1).per(20)
    # render_results(@activities)
  end

  def algolia
    @activities = Kaminari.paginate_array([Activity.first]).page(1).per(20)
    render_results(@activities)
  end

  def materialized
    materialized_search = GetFacetsSearchResults.new(:materialized)
    @activities = materialized_search.call(params)
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
