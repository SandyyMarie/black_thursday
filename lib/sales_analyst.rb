class SalesAnalyst
  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository,merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant #2.88
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation #3.26
    counts = []
    @merchant_repository.all.each do |merchant|
      counts <<  @item_repository.find_all_by_merchant_id(merchant.id).count
    end
    total = counts.sum {|difference| (difference - average_items_per_merchant) ** 2}
    Math.sqrt(total / (counts.length - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_array = []
    @merchant_repository.all.each do |merchant|
      if (@item_repository.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant > average_items_per_merchant_standard_deviation) #avg items per merchant
        merch_array << merchant
      end
    end
    merch_array
  end

  def average_item_price_for_merchant(merch_id)
    price_sum_helper(merch_id) / @item_repository.find_all_by_merchant_id(merch_id).count
  end

  def price_sum_helper(merch_id) #31500
    holder_array = @item_repository.find_all_by_merchant_id(merch_id)
    total_sum = holder_array.sum{|item| item.unit_price_to_dollars}
    total_sum
  end

  def average_average_price_per_merchant
    total_sum = 0
    @merchant_repository.all.each do |merchant|
      total_sum += average_item_price_for_merchant(merchant.id)
    end
    (total_sum / @merchant_repository.all.count).round(2)
  end

  def golden_items
    golden_item_array = []
    @merchant_repository.all.each do |merchant|

      if (@item_repository.find_all_by_merchant_id(merchant.id).count - average_items_per_merchant >= average_items_per_merchant_standard_deviation * 2) #checking to see what values are higher than 2 standard deviations - would that be *2 or +2?
        golden_item_array << @item_repository.find_all_by_merchant_id(merchant.id)
      end
    end
    golden_item_array
    # require 'pry' ; binding.pry
  end

end
