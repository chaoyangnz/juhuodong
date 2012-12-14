# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  # '创建未付款', '超时未付款自动取消', '手工取消', '付款完成', '免付（免费票）'
  STATUS = ['unpaid', 'auto-cancelled', 'cancelled', 'paid', 'paid-free']
  # -------> paid-free
  # -------> unpaid ------------------------------> paid
  #                      |---------> auto-cancelled
  #                    |---------> cancelled

  #------------------------------------------------------
  # Relations assiacation
  #------------------------------------------------------
  has_many :order_items
  accepts_nested_attributes_for :order_items


  #-----------------------------------------------------
  # Mass assignments
  #-----------------------------------------------------
  attr_accessible :mobile_phone, :realname, :email, :total_fee, :subject, :body, :show_url
  attr_accessible :order_items_attributes


  #-----------------------------------------------------
  # Lifecycle callbacks
  #-----------------------------------------------------
  before_create :generate_order_no

  def generate_order_no
    self.order_no = 'U' + Time.new.strftime("%Y%m%d-%H%M%S")
  end

end