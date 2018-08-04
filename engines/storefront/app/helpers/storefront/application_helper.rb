module Storefront
  module ApplicationHelper
    def product_options(selected)
      products = %i[bronze_box silver_box gold_box]
      options = products.each_with_object({}) { |product, map| map[product.to_s.titleize] = product }
      options_for_select(options, selected)
    end

    def state_options
      products = %i[AL AK AZ AR CA CO CT DC DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA PR RI SC SD TN TX UT VT VA WA WV WI WY]
      options = products.each_with_object({}) { |product, map| map[product.to_s] = product }
      options_for_select(options)
    end
  end
end
