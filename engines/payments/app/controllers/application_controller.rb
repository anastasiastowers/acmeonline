class ApplicationController < Payments::ApplicationController
  protect_from_forgery with: :exception
end
