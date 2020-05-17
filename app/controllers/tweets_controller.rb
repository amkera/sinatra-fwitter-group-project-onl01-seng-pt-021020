class TweetsController < ApplicationController
  
  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all 
      erb :'/tweets/tweets'
    else 
      redirect '/login'
    end 
  end 
  
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end
  
  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/new"
      else
        @tweet = current_user.tweets.build(content: params[:content])
        #creating a tweet and associating to the current_user
        
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}"
          #tweet has an id in the database 
        else
          redirect to "/tweets/new"
        end
      end
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end
  
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

end
