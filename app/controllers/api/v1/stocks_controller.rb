class Api::V1::StocksController < ApplicationController

  def price_all
    response = RapidApi::LatestStockPrice.equities_all

    render_raw_response({
                          status: '200',
                          meta: { messages: Rack::Utils::HTTP_STATUS_CODES[200] },
                          data: JSON.parse(response.body)
                        }, status: :ok)
  end


  def price
    raise ActionController::ParameterMissing, 'Symbol is required' if params[:symbol].blank?

    response = RapidApi::LatestStockPrice.equities(params[:symbol])
    render_raw_response({
                          status: '200',
                          title: Rack::Utils::HTTP_STATUS_CODES[200],
                          data: JSON.parse(response.body)
                        }, status: :ok)
  end
end
