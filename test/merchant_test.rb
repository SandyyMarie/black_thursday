require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe Merchant do

  it 'exists' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School",
      :created_at => "2010-07-12"
      })

    expect(merchant).to be_instance_of(Merchant)
  end

  it 'returns id' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School",
      :created_at => "2010-07-12"
      })

    expect(merchant.id).to eq(5)
  end

  it 'returns name' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School",
      :created_at => "2010-07-12"
      })

    expect(merchant.name).to eq("Turing School")
  end

  it 'returns creation date' do
    merchant = Merchant.new({
      :id => 5,
      :name => "Turing School",
      :created_at => "2010-07-12"
      })

    expect(merchant.created_at).to eq("2010-07-12")
  end

end
