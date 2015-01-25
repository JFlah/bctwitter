class StaticPagesController < ApplicationController
	def index
		if user_signed_in?
			if current_user.profile
				redirect_to tweets_path # redir to controller vs render (shows view
			else
				# vs flash.now in tweet controller (does not survive)
				flash[:success] = "Create a profile below!" #survives redir
				redirect_to new_profile_path
			end
		end
	end
end
