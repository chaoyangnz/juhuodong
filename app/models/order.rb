# -*- encoding : utf-8 -*-
class Order < ActiveRecord::Base

  # '创建未付款', '超时未付款自动取消', '手工取消', '付款完成', '免付（免费票）'
  STATUS = ['unpaid', 'auto-cancelled', 'cancelled', 'paid', 'paid-free']
  # -------> paid-free
  # -------> unpaid ------------------------------> paid
  #                      |---------> auto-cancelled
  #                    |---------> cancelled

  # 合计费用
  def sum_up
    self.total_fee = self.order_items.sum { |item| item.ticket.online_price.to_f * item.quantity.to_i }
  end

  def need_pay?
    self.total_fee != 0
  end

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
  after_create :issue_or_reserve_tickets

  private
  # 生成订单号
  def generate_order_no
    self.order_no = 'U' + Time.new.strftime("%Y%m%d-%H%M%S")
  end

  # 出票或临时预留
  def issue_or_reserve_tickets
    self.order_items.each do |order_item|
      if order_item.ticket.charge?
        # 将这些票暂时冻结
        order_item.ticket.available -= order_item.quantity
        order_item.ticket.reserved += order_item.quantity
        order_item.ticket.save!
      else
        order_item.ticket.available -= order_item.quantity
        order_item.ticket.save!
        # 出票
        order_item.quantity.times do
          eticket = order_item.ticket.etickets.build
          eticket.status = 'issued'
          eticket.save!
        end
      end
    end
  end

end