Rails.application.routes.draw do
  mount Templates::Engine => "/templates"
end
