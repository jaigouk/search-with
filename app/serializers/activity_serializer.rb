# frozen_string_literal: true
class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :about,
             :price, :tags, :location,
             :start_months_old, :end_months_old,
             :camp, :drop_in, :date_night, :indoor,
             :outdoor,:created_at

  attribute :tags do
    object.tags.map(&:title)
  end

  attribute :location do
    {
      name: object.location.name,
      addr: object.location.line1,
      city: object.location.city
    }
  end
end
