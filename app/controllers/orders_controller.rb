# -*- encoding : utf-8 -*-
require 'payment/alipay'
class OrdersController < ApplicationController
  skip_filter :authenticate_user!

  # 核对订单
  def check
    @event = Event.find(params[:event_id])

    @order = Order.new
    params[:order_items].each do |item|
        @order.order_items.build(item) #<< Ticket.find(item[:ticket_id]).order_items.build(item)
    end
    @order.subject = @event.name
    @order.body = "[#{@event.name}]" + @order.order_items.map { |item| "#{item.ticket.name} #{item.quantity}张 × #{item.price}元" }.join(',')
    @order.show_url = event_path(@event)
    @order.total_fee = @order.order_items.sum { |item| item.ticket.online_price.to_f * item.quantity.to_i }
  end

  # 订单支付
  def pay
    @order = Order.new(params[:order])
    @order.status = 'unpaid'

    if(@order.save)
      @order.order_items.each do |order_item|
        # 将这些票暂时冻结
        order_item.ticket.available -= order_item.quantity
        order_item.ticket.reserved += order_item.quantity
        order_item.ticket.save

        # 保存订单项
        order_item.save
      end

      render :inline => ::Payment::Alipay.direct_pay({
                                                         'out_trade_no'	      => @order[:order_no],
                                                         'subject'	          => @order[:subject],
                                                         'total_fee'	        => @order[:total_fee],
                                                         'body'	              => @order[:body],
                                                         'show_url'	          => @order[:show_url],
                                                         #   'anti_phishing_key'	  => anti_phishing_key, # 防钓鱼时间戳
                                                         'exter_invoke_ip'	  => request.remote_ip
                                                         #   'extra_common_param'  =>   #选填
                                                     })

    else
      render 'edit'
    end
  end

  # 支付返回,准备出票
  def pay_return
    #计算得出通知验证结果
    verify_result = verify(params)

    if (verify_result) #验证成功
                       ##################################################################
                       #请在这里加上商户的业务逻辑程序代码

                       #——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                       #获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                       #商户订单号
      out_trade_no = params['out_trade_no'];

      #支付宝交易号
      trade_no = params['trade_no'];

      #交易状态
      trade_status = params['trade_status'];

      if (trade_status == 'TRADE_FINISHED' || trade_status == 'TRADE_SUCCESS')
        #判断该笔订单是否在商户网站中已经做过处理
        #如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        #如果有做过处理，不执行商户的业务程序
      else
        render :inline => '返回状态错误' and return
      end

      render :inline => '成功支付' and return

      #——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

      ##################################################################/

    else
      #验证失败
      #如要调试，请看alipay_notify.php页面的verifyReturn函数
      render :inline => '验证不成功' and return
    end
  end

  # 支付通知
  def pay_notify
    #计算得出通知验证结果
    verify_result = verify(params)

    if (verify_result) #验证成功
                       ##################################################################
                       #请在这里加上商户的业务逻辑程序代码

                       #——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                       #获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                       #商户订单号
      out_trade_no = params['out_trade_no'];

      #支付宝交易号
      trade_no = params['trade_no'];

      #交易状态
      trade_status = params['trade_status'];

      if(trade_status == "TRADE_FINISHED")
        #判断该笔订单是否在商户网站中已经做过处理
        #如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        #如果有做过处理，不执行商户的业务程序

        #注意：
        #该种交易状态只在两种情况下出现
        #1、开通了普通即时到账，买家付款成功后。
        #2、开通了高级即时到账，从该笔交易成功时间算起，过了签约时的可退款时限（如：三个月以内可退款、一年以内可退款等）后。
      elsif (trade_status == "TRADE_SUCCESS")
        #判断该笔订单是否在商户网站中已经做过处理
        #如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
        #如果有做过处理，不执行商户的业务程序

        #注意：
        #该种交易状态只在一种情况下出现——开通了高级即时到账，买家付款成功后。
      end


      #——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

      render :inline => "success" and return # 请不要修改或删除

      #——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

      ##################################################################/

    else
      render :inline => "fail" and return # 请不要修改或删除
    end
  end
end