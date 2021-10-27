class OrderHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @order_history_purchase = OrderHistoryPurchase.new
    if @item.user_id == current_user.id || @item.order_history != nil
      redirect_to root_path
    end
  end

  def create
    @item = Item.find(params[:item_id])
    @order_history_purchase = OrderHistoryPurchase.new(order_params)
    if @order_history_purchase.valid?
      pay_item
      @order_history_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_history_purchase).permit(:address_number, :delivery_area_id, :address_middle, :address_bottom, :address_detail, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY_TEST"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
