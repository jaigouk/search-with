# frozen_string_literal: true
class CompareSearchMethods < BaseService
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def with(query)
    self.class.new(query)
  end

  def call
    "benchmark_result"
  end
end
