require 'vhx'

class PocController < ApplicationController
  before_action :initialize_vhx

  def demo
    begin
      @vhx = Vhx.setup({ api_key: ENV['VHX_API_KEY'] })
      @products = Vhx::Product.list
    rescue Vhx::VhxError
      # Handle error
      @products = []
    end
  end

  private

  def initialize_vhx
    @vhx = Vhx.setup({ api_key: ENV['VHX_API_KEY'] })
  end
end
