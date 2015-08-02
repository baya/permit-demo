class User < ActiveRecord::Base

  has_and_belongs_to_many :permissions
  has_many :posts

  validates :name, uniqueness: true
  
end
