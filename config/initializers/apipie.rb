Apipie.configure do |config|
  config.app_name                = "RenderTemplate"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/docs"
  config.layout = 'apipie_layout'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v1/*.rb"
end
