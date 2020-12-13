# frozen_string_literal: true

class PalindromeController < ApplicationController
  before_action :check_input, only: :view
  
  def input; end

  def view
    @res = PalindromeData.find_by num: @val
    return if @res
  
    @res = PalindromeData.compute_and_create_from @val
  end

  def show_db
    render xml: PalindromeData.all.to_xml
  end

  private
  def check_input
    @val = Integer(params[:val], exception: false)
    @res = if @val.nil?
                   'Not a number'
                 elsif @val <= 0
                   'Number should be positive'
                 end
    render :view if @res
  end
end
