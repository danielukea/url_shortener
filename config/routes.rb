Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/:short_url", to: "urls#index"
  scope '/api' do
    scope '/v1' do
      post "/shorten", to: 'urls#shorten'
    end
  end
end
