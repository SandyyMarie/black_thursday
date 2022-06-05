require 'helper'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :analyst

  def initialize(data)
    @items = check_items(data)
    @merchants = check_merchants(data)
    @invoices = check_invoices(data)
    @invoice_items = check_invoice_items(data)
  end

  def self.from_csv(data)
    SalesEngine.new(data)
  end

  def check_items(data)
    return ItemRepository.new(data[:items]) if data.keys.include?(:items) == true
  end

  def check_merchants(data)
    return MerchantRepository.new(data[:merchants]) if data.keys.include?(:merchants) == true
  end

  def check_invoices(data)
    return InvoiceRepository.new(data[:invoices]) if data.keys.include?(:invoices) == true
  end

  def check_invoice_items(data)
    return InvoiceItemRepository.new(data[:invoice_items]) if data.keys.include?(:invoice_items) == true
  end

  def analyst
    SalesAnalyst.new(@items, @merchants)
  end
end
