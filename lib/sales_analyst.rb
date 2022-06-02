class SalesAnalyst

  attr_accessor :item_repository, :merchant_repository

  def initialize(item_repository,merchant_repository)
    @item_repository = item_repository
    @merchant_repository = merchant_repository
  end

  def average_items_per_merchant
    (@item_repository.all.count.to_f / @merchant_repository.all.count.to_f).round(2)
  end

  def difference_between_merchant_items_and_mean(merchant_id)
    (@item_repository.find_all_by_merchant_id(merchant_id).count.to_f - average_items_per_merchant.to_f).abs
  end

  def sum_of_differences_squared
    return_num = 0
    @item_repository.all.each do |item|
      return_num += (difference_between_merchant_items_and_mean(item.id) ** 2)
    end
    return_num.round(2)
  end

end
