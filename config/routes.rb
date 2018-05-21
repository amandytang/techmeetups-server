Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'pages#join_meetup'
  post '/join_meetup' => 'pages#join_meetup'
  post '/join_group' => 'pages#join_group'

end


  # you need another route which points to a different action in the pages controller, for the join group call, and the self/events call
