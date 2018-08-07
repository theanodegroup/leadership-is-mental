require 'vhx'

class PocController < ApplicationController
  before_action :initialize_vhx

  def demo
    begin
      @collections = Vhx::Collection.list
      @products = Vhx::Product.list
      # Example Customer Create
    rescue Vhx::VhxError
      # Handle error
    end
  end

  private

  def initialize_vhx
    @vhx = Vhx.setup({ api_key: ENV['VHX_API_KEY'] })
  end
end
