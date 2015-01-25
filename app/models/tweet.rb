class Tweet < ActiveRecord::Base
	include Twitter::Extractor

	belongs_to :user
	validates :content, length: { maximum: 140 }

	def extract_hash_tags
		extract_hashtags(self.content)
	end

	validate :hashtags_created

	def hashtags_created
		begin
			transaction do # makes all below one transcation, rolls back if any fail
				@hashtags = self.extract_hash_tags

				@hashtags.each do |the_hashtag|
					if Hashtag.where(tag: the_hashtag).any?
						#do nada
					else
						if Hashtag.create!(tag: the_hashtag) # ! bang --> error if doesnt work
							#do nada
						else
							self.errors.add(:tweet, "The hashtag is invalid")
						end
					end
				end
			end
		rescue # stops website from dying after transaction ends (with error)
			self.errors.add(:tweet, "the hashtag(s) are invalid")
		end
	end

end

# models are singular
# model methods allow an instance of that model