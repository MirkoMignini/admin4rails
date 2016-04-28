class Comment < ActiveRecord::Base
  belongs_to :post

  has_many :replies
  accepts_nested_attributes_for :replies, allow_destroy: true
end
