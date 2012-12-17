class Eticket < ActiveRecord::Base
  STATUS = ['issued', 'refunded', 'used']
  # available -----> reserved ------------> issued------o-----> used
  #       <------------|                             |
  #       <----------------------------------------refund
  # 此表只会存在sold/refund/used三种出票状态
  # available和reserved只是逻辑状态

  belongs_to :ticket

  before_create :generate_ticket_no

  private
  #生成电子票号
  def generate_ticket_no
    self.ticket_no = 'T' + Time.new.strftime("%Y%m%d-%H%M%S")
  end


end