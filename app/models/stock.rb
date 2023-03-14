class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    # client = IEX::Api::Client.new(
    #   publishable_token: Rails.application.credentials.iex_client[:api_key],
    #   secret_token: Rails.application.credentials.iex_client[:secret_token],
    #   endpoint: 'https://cloud.iexapis.com/v1'
    # )
    # client.price(ticker_symbol)
    company = Alphavantage::Fundamental.new(symbol: ticker_symbol)
    client = Alphavantage::TimeSeries.new(symbol: ticker_symbol)
    begin
      new( ticker: ticker_symbol, name: company.overview.name, last_price: client.quote.price )
    rescue => exception
      return nil
    end
  end
end
