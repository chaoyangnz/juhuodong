class Ticket < ActiveRecord::Base
  #abstract_class = true

  set_inheritance_column :ruby_type

  # 在售、售罄、停售
  STATUS = ['on-sale', 'stop']
  # 收费票， 免费票， 入场券（免费）
  TYPES = ['ChargeTicket', 'FreeTicket', 'AdmissionCategory']

  def charge?
    type == 'ChargeTicket'
  end

  def free?
    type == 'FreeTicket'
  end

  #------------------------------------------------------
  # Relations assiacation
  #------------------------------------------------------
  belongs_to :event
  has_many :order_items
  has_many :etickets

  #-----------------------------------------------------
  # Mass assignments
  #-----------------------------------------------------
  attr_accessible :name, :type, :package, :capacity, :online_price, :offline_price, :sale_start_time, :sale_end_time, :order_min, :order_max, :notice

                  #-----------------------------------------------------
  # Validations
  #-----------------------------------------------------
  validates :name, :presence => true
  validates :type, :presence => true


  #-----------------------------------------------------
  # Lifecycle callbacks
  #-----------------------------------------------------
  before_create :make_available_as_capacity
  before_create :make_online_price_as_zero_if_free

  def make_available_as_capacity
    self.available = self.capacity
  end

  def make_online_price_as_zero_if_free
    self.online_price = 0 if self.type == 'FreeTicket'
  end

end
