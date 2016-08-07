# frozen_string_literal: true
class SaveBenchMarkData < BaseService
  def initialize
  end

  def call(params)
    BenchMarkData.create(entries: params[:entries],
      result: params[:result], data: params[:data].as_json)
  end
end
