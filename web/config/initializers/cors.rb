# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'localhost:8080'
      resource '/api/*', headers: :any, methods: [:get, :post, :put, :options], credentials: true
    end
end