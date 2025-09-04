class Api::V1::TransactionsController < ApplicationController
  before_action :set_wallet
  before_action :validate_params, only: [:deposit, :withdraw, :transfer]

  def index
    transactions = @wallet.transactions.order(id: :desc)
    render_raw_response({
                          status: "200",
                          meta: { status: Rack::Utils::HTTP_STATUS_CODES[200] },
                          data: transactions.map { |t| t.to_builder.attributes! }
                        }, status: :ok)
  end

  def deposit
    if TransactionServices::Deposit.new(wallet_id: @wallet.id, amount: params[:amount].to_i).call
      render_result
    end
  rescue ActiveRecord::RecordInvalid => e
    render_bad_request(e)
  end

  def withdraw
    if TransactionServices::Withdraw.new(wallet_id: @wallet.id, amount: params[:amount].to_i).call
      render_result
    end
  rescue ActiveRecord::RecordInvalid => e
    render_bad_request(e)
  end

  def transfer
    if TransactionServices::Transfer.new(
      source_wallet_id: @wallet.id,
      destination_wallet_id: params[:destination_wallet_id],
      amount: params[:amount].to_i
    ).call
      render_result
    end
  rescue ActiveRecord::RecordInvalid => e
    render_bad_request(e)
  end

  private

  def set_wallet
    @wallet = @current_user.wallet
    @previous_amount = @wallet.balance.to_i
  end

  def validate_params
    raise ActionController::ParameterMissing, "amount is required" if params[:amount].blank?
  end

  def validate_transfer_params
    if params[:amount].blank? || params[:destination_wallet_id].blank? || params[:destination_wallet_id] == @wallet.id
      raise ActionController::ParameterMissing, "destination_wallet_id and amount is required"
    end
  end

  def detail_wallet
    {
      previous_amount: @previous_amount,
      deposito_amount: params[:amount],
      current_amount: @wallet.reload.balance
    }
  end

  def render_result
    render_raw_response({
                            meta: { status: Rack::Utils::HTTP_STATUS_CODES[200], message: "#{action_name.titleize} succeed" },
                            detail: detail_wallet
                          }, status: :ok)
  end
end
