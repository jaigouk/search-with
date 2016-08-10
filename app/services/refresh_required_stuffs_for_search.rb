# frozen_string_literal: true
class RefreshRequiredStuffsForSearch < BaseService
  def initialize
  end

  def call
    # elastic search searchkick reindex
    Activity.searchkick_reindex()

    # material view reindex
    MaterializedSearchResult.refresh

    # solr sunspot
    Activity.solr_reindex

    # algolia
    Activity.algolia_reindex!
  end
end
