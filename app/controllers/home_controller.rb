class HomeController < ApplicationController

	def index
		## filtering goes here
	end

  def elastic
    @activities = Activity.facets_search(params)
    respond_to do |format|
      format.json do
       render(
         json: @activities,
         serializer: ActiveModel::Serializer::CollectionSerializer,
         each_serializer: ActivitySerializer
       )
      end
      format.html
    end
  end

  def elastic_autocomplete
    render json: Activity.search(q: params[:term], fields: [{title: :text_start}], limit: 5).map(&:title)
  end
end
