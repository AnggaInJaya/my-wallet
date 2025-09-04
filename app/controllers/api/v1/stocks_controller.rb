class Api::V1::StocksController < ApplicationController

  def price_all
    response = RapidApi::LatestStockPrice.price_all

    render_raw_response({
                          status: '200',
                          meta: { messages: Rack::Utils::HTTP_STATUS_CODES[200] },
                          data: JSON.parse(response.body)
                        }, status: :ok)
  end

  def price
    raise ActionController::ParameterMissing, 'Symbol is required' if params[:symbol].blank?

    response = RapidApi::LatestStockPrice.price_all
    data = JSON.parse(response.body)
    filtered_data = data.find { |hash| hash["identifier"] == params[:symbol] }

    render_raw_response({
                          status: '200',
                          meta: { messages: Rack::Utils::HTTP_STATUS_CODES[200] },
                          data: filtered_data
                        }, status: :ok)
  end

  def prices
    raise ActionController::ParameterMissing, 'Symbol is required' if params[:symbol].blank?

    response = RapidApi::LatestStockPrice.price_all
    data = JSON.parse(response.body)
    filtered_data = data.select { |hash| params[:symbol].include?(hash["symbol"]) }


    render_raw_response({
                          status: '200',
                          meta: { messages: Rack::Utils::HTTP_STATUS_CODES[200] },
                          data: filtered_data
                        }, status: :ok)
  end
end
