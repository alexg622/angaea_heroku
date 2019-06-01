Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3000', 'www.angaea.com', 'https://master.d3nlg5vhjsw41.amplifyapp.com', 'https://d3ubz66m6sod7m.cloudfront.net'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end

Rails.application.config.action_controller.forgery_protection_origin_check = false
