module Payments
  class HomeController < ApplicationController

    def checkout
      @selected_product = params[:selected_product]
    end

    def index
    end
  end
end
