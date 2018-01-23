Rails.application.routes.draw do
  resources :screen_captures do
    collection do
      get 'download_file'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
