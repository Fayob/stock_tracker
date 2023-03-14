class Stock < ApplicationRecord
  has_many :user_stocks, dependent: :delete_all
  has_many :users, through: :user_stocks, dependent: :delete_all

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    # client = IEX::Api::Client.new(
    #   publishable_token: Rails.application.credentials.iex_client[:api_key],
    #   secret_token: Rails.application.credentials.iex_client[:secret_token],
    #   endpoint: 'https://cloud.iexapis.com/v1'
    # )
    # client.price(ticker_symbol)
    company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
    client = Alphavantage::TimeSeries.new(symbol: ticker_symbol).quote
    new( ticker: ticker_symbol, name: company.overview.name, last_price: client.price )
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
