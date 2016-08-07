# frozen_string_literal: true
class Activity < ApplicationRecord
	has_many :activity_tags
  has_many :tags, through: :activity_tags
  has_one :activity_location
  has_one :location, through: :activity_location

  ## for Materilized View
  after_commit :refresh_view

  ## for ElasticSearch - searchkick
  searchkick text_start: [:title],
             suggest: [:title],
             settings: {index: {max_result_window: 10000}}

  ## for ElasticSearch - searchkick
  def search_data
    {
      title: title,
      about: about,
      start_months_old: start_months_old,
      end_months_old: end_months_old,
      camp: camp,
      drop_in: drop_in,
      date_night: date_night,
      indoor: indoor,
      outdoor: outdoor,
      tags: tags.map(&:title)
    }
  end

  def options
    options = []
    [:camp ,:drop_in, :date_night, :indoor, :outdoor].each{|x| options << x.to_s if send(x) }
    options
  end

private

  def refresh_view
     MaterializedSearchResult.refresh
  end
end
