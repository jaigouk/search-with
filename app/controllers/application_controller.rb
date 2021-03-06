class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    if Rails.env == 'development'
      Rack::MiniProfiler.authorize_request
    end
  end

  private

   def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.previous_page,
      total_pages: object.total_pages,
      total_count: object.total_entries
    }
  end

  def render_results(activities)
    respond_to do |format|
      format.json do
       render(
         json: activities,
         serializer: ActiveModel::Serializer::CollectionSerializer,
         each_serializer: ActivitySerializer
       )
      end
      format.html
    end
  end
end
