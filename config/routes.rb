Rails.application.routes.draw do
  get 'palindrome/input'
  get 'palindrome/view'
  get 'palindrome/show_db'
  root 'palindrome#input'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
