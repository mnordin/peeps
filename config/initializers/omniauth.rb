Rails.configuration.middleware.use OmniAuth::Builder do
  provider :google_apps, nil, {:callback_path => "/auth/google_apps/callback", :domain => 'newsdesk.se'}
  provider :facebook, "194756060575091", "285cebd99fba497fe071ecb221733775"
end