class Post < ActiveRecord::Base
	validates :content, presence: true, length: { maximum: 200 }
	belongs_to :group
	belongs_to :user
	self.per_page = 10
end