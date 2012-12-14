# -*- encoding : utf-8 -*-
class EticketsController < ApplicationController
  skip_filter :authenticate_user!

  # 检票
  def checkin

  end

  # 退票
  def refund

  end

end