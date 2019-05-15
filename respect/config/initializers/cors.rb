# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://111.107.49.106:8080', 'http://localhost:8080',
            /\Ahttps:\/\/respects-3b626\.firebaseapp\.com(:\d+)?\z/

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      expose: ['Authorization', 'Access-Control-Allow-Origin', 'access-token', 'uid']
  end
end
