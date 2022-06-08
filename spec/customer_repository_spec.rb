require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe CustomerRepository do
  let!(:sales_engine) {SalesEngine.from_csv({:customers => "./data/customers.csv"})}
  let!(:customer_repo) {sales_engine.customers}
  let(:new_customer) {customer_repo.create_customer({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
  })}

  it "exists" do
    expect(customer_repo).to be_instance_of CustomerRepository
  end

  it "can return all customer instances in an array" do
    expect(customer_repo.all).to be_a Array
  end

  it "can find customers by their id" do
    new_customer
    expect(customer_repo.find_by_id(1001)).to be_instance_of Customer
    expect(customer_repo.find_by_id(1001).last_name).to eq("Clarke")
  end

  it "can find customers by their first name" do
    new_customer
    expect(customer_repo.find_by_first_name("Joan")).to be_instance_of Customer
    expect(customer_repo.find_by_first_name("Joan").id).to eq(1001)
    expect(customer_repo.find_by_first_name("Joan").last_name).to eq("Clarke")
  end

  it "can find customers by their last_name" do
    new_customer
    expect(customer_repo.find_by_last_name("Clarke")).to be_instance_of Customer
    expect(customer_repo.find_by_last_name("Clarke").id).to eq(1001)
    expect(customer_repo.find_by_last_name("Clarke").first_name).to eq("Joan")
  end

  it "can find customers by their invoice id" do
    expect(customer_repo.find_all_by_invoice_id(6).first).to be_instance_of Customer
    expect(customer_repo.find_all_by_invoice_id(6).first.id).to eq(38)
  end

  it "can update an customer" do
    time = Time.now
    new_customer
    expect(customer_repo.find_by_id(6)).to be_instance_of Customer
    expect(customer_repo.find_by_id(6).first_name).to eq("Joan")
    expect(customer_repo.find_by_id(6).last_name).to eq("Clarke")
    expect(customer_repo.find_by_id(6).updated_at).to eq(customer_repo.find_by_id(6).created_at)

    customer_repo.update(6, {:first_name => "Mary", :last_name => "Sue"})
    expect(customer_repo.find_by_id(21831).item_id).to eq(7)
    expect(customer_repo.find_by_id(21831).quantity).to eq(2)
    expect(customer_repo.find_by_id(21831).unit_price).to eq("14.99")
    expect(customer_repo.find_by_id(21831).updated_at).to eq(time.strftime("%Y-%m-%d %H:%M"))
    expect(customer_repo.find_by_id(1).updated_at).not_to eq(customer_repo.find_by_id(21831).created_at)
  end

  it "can delete an invoice" do
    new_customer
    expect(customer_repo.find_by_id(21831)).to be_instance_of Customer
    expect(customer_repo.find_by_id(21831).quantity).to eq(1)
    # expect(customer_repo.find_by_id(1).updated_at).to eq("2014-03-15")
    customerrepository = double()
    allow(customerrepository).to receive(:delete).and_return("Deletion complete!")
  end
end
