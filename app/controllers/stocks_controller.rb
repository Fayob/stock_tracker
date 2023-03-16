class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @user = current_user
      @tracked_stocks = current_user.stocks
      @stock = Stock.new_lookup(params[:stock])
      if @stock.name && @stock.last_price
        render 'users/my_portfolio'
      else
        flash[:alert] = "Please enter a valid symbol"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = "Please enter a symbol"
      redirect_to my_portfolio_path
    end
  end

  # def refresh
  #   stocks = current_user.stocks
  #   stocks.each do |stock|
  #     new_stock = Stock.new_lookup(stock.ticker)
  #     stock.last_price = new_stock.last_price
  #   end
  #   redirect_to my_portfolio_path
  # end
end