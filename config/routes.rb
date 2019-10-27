# List routes:
#   rake routes
#   rake grape:routes
#
Rails.application.routes.draw do

  # Frontend's environment, see also: `config/frontend_environment.js.erb`
  get '/_environment.js', to: 'public#environment'

  # Grape API in app/api/
  mount API => '/'

  get 'auth/consume', to:'haka/auth#consume'
    post 'auth/consume', to:'haka/auth#consume'

  # SAML Authentication from the Haka federation
  namespace :haka do
    get 'auth/new'
  end

end
