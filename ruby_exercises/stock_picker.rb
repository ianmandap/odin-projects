# frozen_string_literal: true

def stock_picker(days_array)
  # Takes in an array of stock prices, one for each hypothetical day.
  # Return a pair of days representing the best day to buy and the best day to sell.
  best_pair = []
  best_pair_profit = 0
  no_of_days = days_array.length - 1

  days_array.each_with_index do |buy_price, buy_index|
    (0..no_of_days).each do |sell_index|
      next if buy_index >= sell_index

      if (days_array[sell_index] - buy_price) > best_pair_profit
        best_pair = [buy_index, sell_index]
        best_pair_profit = days_array[sell_index] - buy_price
      end
    end
  end
  best_pair
end

p stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10]) # => [1,4]  # for a profit of $15 - $3 == $12
