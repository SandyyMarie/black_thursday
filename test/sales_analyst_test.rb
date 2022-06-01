require 'simplecov'
SimpleCov.start
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
require 'rspec'

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end

  it "exists" do
    expect(@sales_analyst).to be_instance_of(SalesAnalyst)
  end


end
