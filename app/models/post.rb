class Post < ActiveRecord::Base
  validates :url, presence: true
  validates :title, presence: true

  has_many :comments
  belongs_to :user
end
