# frozen_string_literal: true
class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :title, :about, :options,
             :price, :tags, :location,
             :start_months_old, :end_months_old

  attribute :options do
    object.options.join(', ')
  end

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
