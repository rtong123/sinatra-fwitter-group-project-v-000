require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
  end

  get '/' do
    erb :index
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do

    if params[:username] != "" && params[:email] != ""  && params[:password] != ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end


  get '/login' do
    if logged_in?
      redirect '/tweets'
  else
    erb :'users/login'
  end
end

  post '/login' do
    redirect '/tweets'
  end

  get '/logout' do
    if !logged_in
    erb :'/login'
  else
    erb :'/tweets'
  end
end

  post '/logout' do

  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end
