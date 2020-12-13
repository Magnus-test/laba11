class PalindromeData < ApplicationRecord
    validates_uniqueness_of :num

    class << self
        def compute_and_create_from (value)
            create num: value, count: compute(value).size, 
                   nums: decode_array(compute(value), 1), 
                   squared: decode_array(compute(value), 2)
        end
        private
        def compute(value)
            count = 1
            res = [[count, 1, 1]]
            2.upto(value) do |num|
              res.push [count += 1, num, num**2] if palindrome?(num**2)
            end
            res
        end

        def decode_array arr, ind 
            ActiveSupport::JSON.encode(arr.map {|el| el[ind] })
        end

        def palindrome?(num)
            num.then { |num| num.to_s }.then { |num| num == num.reverse }
        end
    end
end
