# -*- encoding : utf-8 -*-
class OrderItem < ActiveRecord::Base

  #------------------------------------------------------
  # Relations assiacation
  #------------------------------------------------------
  belongs_to :ticket
  belongs_to :order


  #-----------------------------------------------------
  # Mass assignments
  #-----------------------------------------------------
  attr_accessible :ticket_id, :quantity, :price

  serialize :tickets, Array #出票时写入


end