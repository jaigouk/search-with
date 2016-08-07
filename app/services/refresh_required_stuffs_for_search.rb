# frozen_string_literal: true
class RefreshRequiredStuffsForSearch < BaseService
  def initialize
  end

  def call
    Activity.reindex
    MaterializedSearchResult.refresh
  end
end
