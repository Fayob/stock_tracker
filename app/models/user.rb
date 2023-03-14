class User < ApplicationRecord
  has_many :user_stocks, dependent: :delete_all
  has_many :stocks, through: :user_stocks, dependent: :delete_all
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def can_track_stock?(ticker_symbol)
    !stock_already_tracked?(ticker_symbol)
  end
end
