class TweetsController < ApplicationController

	# controllers are plural rails g controller

	# Protect against non-logged in users tweeting
	before_action :authenticate_user! # ! means raise error if not working


	# Relates to new.html.erb file
	# This controller relates to that view
	# new creates instance of Tweet.rb (model)
	def new
		@tweet = Tweet.new
		@tweets = current_user.tweets
	end

	# Creates a "tweet"
	# Renders 'new'.html.erb page
	def create

		@tweet = Tweet.new(tweet_params) # creates new instance of Tweet
		@tweet.user = current_user
		@tweets = current_user.tweets

		if @tweet.save # saves it to the database
			flash.now[:success] = "Tweet Created"
		end
		render 'new'
	end

	def index
		 # {} is like do and end in 1 line
		@tweets = Tweet.all.reject{ |tweet| tweet.user == current_user }
		@relationship = Relationship.new
	end

	private

	# Must sanitize what's incoming in tweets
	# Tweet must be part of params hash,
	# Then only permit content (avoids bad inputs)
	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
