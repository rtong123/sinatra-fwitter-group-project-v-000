class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end


  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/create_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] != ""
        @tweet = current_user.tweets.build(content: params[:content])
        @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
    erb :'/tweets/show_tweet'
  else
    redirect '/login'
  end
end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_slug(params[:slug])
    @tweet.save
  end

  get '/tweets/:id/delete' do
    if current_user
      binding.pry
      @tweet = Tweet.find_by(id: params[:id])
    end
  end

  post '/tweets/:id/delete' do

  end

  get '/tweets/:id' do
    redirect '/tweets'
  end
end
