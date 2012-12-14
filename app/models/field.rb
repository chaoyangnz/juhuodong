class Field < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :fieldable, :polymorphic => true
end
