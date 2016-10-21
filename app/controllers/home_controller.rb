class HomeController < ApplicationController

	def index
		@benchmark = BenchMarkData.last
	end

  def benchmark
    GenerateBenchmarkWorker.perform_async
    benchmark = BenchMarkData.last
    render json: {entries: benchmark.entries, result: benchmark.result.strip}.to_json
  end

  def elastic
    elastic_search = GetFacetsSearchResults.new(:elastic)
    @activities = elastic_search.call(params)
    render_results(@activities)
  end

  def elastic_autocomplete
    render json: Activity.search(params[:term], fields: [{title: :text_start}], limit: 5).map(&:title)
  end

  # def solr
  #   solr_search = GetFacetsSearchResults.new(:solr)
  #   @activities = solr_search.call(params)
  #   render_results(@activities)
  # end

  def algolia
    @activities = Kaminari.paginate_array(
      [Activity.last]
    ).page(1).per(2)
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
