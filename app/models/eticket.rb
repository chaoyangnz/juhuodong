class Eticket < ActiveRecord::Base
  STATUS = ['issued', 'refunded', 'used']
  # available -----> reserved ------------> issued------o-----> used
  #       <------------|                             |
  #       <----------------------------------------refund
  # 此表只会存在sold/refund/used三种出票状态
  # available和reserved只是逻辑状态



end