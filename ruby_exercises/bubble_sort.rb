# frozen_string_literal: true

def bubble_sort(array)
  iterations = 1
  max_index = array.length
  did_swap_occur = true

  while did_swap_occur
    counter = 0
    did_swap_occur = false

    # After k iterations, checking the last k elements is redundant since already correct place
    while counter != (max_index - iterations)
      if array[counter] > array[counter + 1]
        array[counter], array[counter + 1] = array[counter + 1], array[counter]
        did_swap_occur = true
      end
      counter += 1
    end
    iterations += 1

    p array # puts current sorted array
  end

  array
end

p bubble_sort([4, 3, 78, 2, 0, 2])
p bubble_sort([10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
