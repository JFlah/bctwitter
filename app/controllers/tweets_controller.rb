class TweetsController < ApplicationController

	# Protect against non-logged in users tweeting
	before_action :authenticate_user! # ! means raise error if not working


	# Relates to new.html.erb file
	# This controller relates to that view
	# new creates instance of Tweet.rb (model)
	def new
		@tweet = Tweet.new
	end

	# Creates a "tweet"
	# Renders 'new'.html.erb page
	def create

		@tweet = Tweet.new(tweet_params) # creates new instance of Tweet
		@tweet.user = current_user
		@tweet.save # saves it to the database

		flash.now[:success] = "Tweet Created"
		render 'new'
	end

	private

	# Must sanitize what's incoming in tweets
	# Tweet must be part of params hash,
	# Then only permit content (avoids bad inputs)
	def tweet_params
		params.require(:tweet).permit(:content)
	end
end
