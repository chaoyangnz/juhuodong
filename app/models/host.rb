class Host < ActiveRecord::Base

  STATUS = ['uncertified', 'certified']

  # attr_accessible :title, :body
  belongs_to :user
  has_many :events

  attr_accessible :name, :detail, :telephone, :province, :city, :address, :website, :weibo, :email, :msn, :qq
  validates :name, :presence => true

  def certified?
    status == 'certified'
  end
end
