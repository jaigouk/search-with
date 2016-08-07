# frozen_string_literal: true
# require 'textacular/searchable'
class MaterializedSearchResult < ApplicationRecord
  extend Textacular
  # extend Searchable(:title, :about)

  # We want to reference various models
  belongs_to :searchable, :polymorphic => true

  scope :camp, -> { self.search(searchable_camp: true) }
  scope :indoor, -> { self.search(searchable_indoor: true) }
  scope :outdoor, -> { self.search(searchable_outdoor: true) }
  scope :drop_in, -> { self.search(searchable_drop_in: true) }
  scope :date_night, -> { self.search(searchable_date_night: true) }

  # Search.new('query') to search for 'query'
  # across searchable models
  def self.new(query, options = {})
    query = query.to_s
    return [] if query.empty? && options.empty?
    return self.search(prefix_searchable(options)).map(&:searchable) if query.empty? && !options.empty?
    return self.search(query).map(&:searchable) if !query.empty? && options.empty?

    self.search(query).search(prefix_searchable(options)).map(&:searchable)
  end

  # Search records are never modified
  def readonly?; true; end

  # Our view doesn't have primary keys, so we need
  # to be explicit about how to tell different search
  # results apart; without this, we can't use :include
  # to avoid n + 1 query problems
  def hash; [searchable_id, searchable_type].hash; end
  def eql?(result)
    searchable_id == result.searchable_id and
      searchable_type == result.searchable_type
  end

  def self.refresh
    Scenic.database.refresh_materialized_view(table_name, concurrently: false)
  end

  private

  def self.prefix_searchable(options)
    options.transform_keys{|k| "searchable_#{k.to_s}".to_sym }
  end
end
