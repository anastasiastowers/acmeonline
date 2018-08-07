module Storefront
  class HomeController < ApplicationController
    before_action :authenticate_customer!, except: [:index]

    def checkout
      @selected_product = params[:selected_product]
    end

    def index
    end
  end
end
