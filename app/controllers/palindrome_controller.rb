# frozen_string_literal: true

class PalindromeController < ApplicationController
  def input; end

  def view
    val = check_input
    if val
      if elem = PalindromeData.find_by(num: val)
        res = { count: elem.count, num: elem.num, nums: elem.nums, sq: elem.squared }
      else
        count = 1
        res = [[count, 1, 1]]
        2.upto(val) do |num|
          res.push [count += 1, num, num**2] if palindrome?(num**2)
        end

        data = PalindromeData.new
        data.count = count
        data.num = val
        data.nums = res.map { |x| x[1] }.join(' ')
        data.squared = res.map { |x| x[2] }.join(' ')
        data.save
        res = { count: data.count, num: data.num, nums: data.nums, sq: data.squared }
      end
    else
      res = if numeric? params[:val]
              'Error. Input is negavite number or 0.'
            else
              'Error. Input is not a number.'
            end
    end
    @result = res
  end

  def show_db
    elems = []
    PalindromeData.all.each { |x| elems << { num: x.num, count: x.count, nums: x.nums, squared: x.squared } }
    render xml: elems.to_xml
  end

  private

  def palindrome?(num)
    num.then { |num| num.to_s }.then { |num| num == num.reverse }
  end

  def numeric?(obj)
    obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/)
  end

  def check_input
    if numeric?(params[:val]) && params[:val].to_i.positive?
      params[:val].to_i
    else
      false
    end
  end
end
