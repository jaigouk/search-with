class HomeController < ApplicationController

	def index
		## filtering goes here
	end

  def elastic
    @activities = Activity.facets_search(params)
  end


  def elastic_autocomplete
    render json: Activity.search(params[:term], fields: [{title: :text_start}], limit: 5).map(&:title)
  end
end
