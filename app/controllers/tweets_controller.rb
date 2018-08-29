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
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by(id: params[:id])
    if logged_in?
      redirect '/tweet/edit'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id/edit' do

  end

  get '/tweets/:id/delete' do
    erb :'/tweets/show_tweet'
  end

  post '/tweets/:id/delete' do

  end

  get '/tweets/:id' do
    redirect '/tweets'
  end
end
