class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title

  validates :name, :presence => true
  validates :name, :numericality => true
end
