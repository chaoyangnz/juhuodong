# -*- encoding : utf-8 -*-

#支付宝接口类。能生成支付宝接口链接。
require 'digest/md5'
require 'uri'

module Payment
  module Alipay

    PARTNER = ''
    KEY = ''
    SELLER_EMAIL = ''
    INPUT_CHARSET = 'utf-8' #小写

    RETURN_URL = 'orders/pay_return'
    NOTIFY_URL = 'orders/pay_notify'

    GATEWAY_URL = 'https://www.alipay.com/cooperate/gateway.do'

    VERIFY_URL = 'https://mapi.alipay.com/gateway.do?service=notify_verify'

    class << self

      # 即时到帐交易接口
      # 补充以下参数：
      # {
      #   'out_trade_no'	      => out_trade_no,
      #   'subject'	            => subject,
      #   'total_fee'	          => total_fee,
      #   'body'	              => body,
      #   'show_url'	          => show_url,
      #   'anti_phishing_key'	  => anti_phishing_key, # 防钓鱼时间戳
      #   'exter_invoke_ip'	    => exter_invoke_ip
      #   'extra_common_param'  =>   #选填
      # }

      # Controller中直接： render :inline => Payment::Alipay::direct_pay(...)
      def direct_pay(params, http_method='post', button_name='提交')
        # 基本参数
        params['service'] = 'create_direct_pay_by_user'
        params['partner'] = PARTNER
        params['_input_charset'] = 'utf-8'

        params['return_url'] = RETURN_URL
        params['notify_url'] = NOTIFY_URL

        # 业务参数
        params['payment_type'] = '1'
        params['seller_id'] = PARTNER
        params['seller_email'] = SELLER_EMAIL


        all_params = sign(params)
        all_params_kv = all_params.map do |key, value|
          key + "=" + value.to_s
        end

        html = "<form id='alipaysubmit' name='alipaysubmit' action='#{GATEWAY_URL}?_input_charset=#{INPUT_CHARSET}' method='#{http_method}'>";
        params.each do |key, value|
          html << "<input type='hidden' name='#{key}' value='#{value}'/>";
        end

        #submit按钮控件请不要含有name属性
        html << "<input type='submit' value='#{button_name}'></form>";

        html << "<script>document.forms['alipaysubmit'].submit();</script>";

        puts html
        return html;
      end


      # 批量付款
      def batch_tras_notify

      end

      private

      # 对参数签名
      def sign(params)
        params_kv = params.sort.map do |kv|
          kv.join('=')
        end
        sign = Digest::MD5.hexdigest(params_kv.join('&') + KEY)
        params['sign_type'] = 'MD5'
        params['sign'] = sign
        return params
      end


      #验证消息是否是支付宝发出的合法消息
      #@param params 通知返回来的参数数组
      #@return 验证结果
      def verify(params)

        #判断responsetTxt是否为true，isSign是否为true
        #responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
        #isSign不是true，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
        responseTxt = "true";
        notify_id = params.get("notify_id");
        # 同步返回时，没有notify_id, 也就不校验
        if notify_id.nil?
          responseTxt = verify_notify_id(notify_id)
        end

        sign = params.get("sign")
        isSign = verify_sign(params, sign)

        #写日志记录（若要调试，请取消下面两行注释）
        #String sWord = "responseTxt=" + responseTxt + "\n isSign=" + isSign + "\n 返回回来的参数：" + AlipayCore.createLinkString(params);
        #AlipayCore.logResult(sWord);

        if (isSign && responseTxt == "true")
          return true;
        else
          return false;
        end
      end


      #根据反馈回来的信息，生成签名结果
      #@param Params 通知返回来的参数数组
      #@param sign 比对的签名结果
      #@return 生成的签名结果
      def verify_sign(params,sign)
        #过滤空值、sign与sign_type参数
        sParaNew = {}

        # filter params
        params.each do |key, value|
          if (value != null && value != "" && key != sign && key != "sign_type")
            sParaNew[key] = value
          end
        end

        #获取待签名字符串
        md5_string = sParaNew.sort.collect do |s|
          unless s[0] == "notify_id"
            s[0]+"="+CGI.unescape(s[1])
          else
            s[0]+"="+s[1]
          end
        end

        #获得签名验证结果
        Digest::MD5.hexdigest(md5_string.join("&") + KEY) == sign.downcase
      end


      #获取远程服务器ATN结果,验证返回URL
      #@param notify_id 通知校验ID
      #@return 服务器ATN结果
      #验证结果集：
      #invalid命令参数不对 出现这个错误，请检测返回处理中partner和key是否为空
      #true 返回正确信息
      #false 请检查防火墙或者是服务器阻止端口问题以及验证时间是否超过一分钟
      def verify_notify_id(notify_id)
        #获取远程服务器ATN结果，验证是否是支付宝服务器发来的请求
        veryfy_url = "#{VERIFY_URL}?partner=#{PARTNER}&notify_id=#{notify_id}"

        #获取远程服务器ATN结果
        #验证结果集：
        #invalid命令参数不对 出现这个错误，请检测返回处理中partner和key是否为空
        #true 返回正确信息
        #false 请检查防火墙或者是服务器阻止端口问题以及验证时间是否超过一分钟
        Net::HTTP.get_response(URI(veryfy_url));
      end

    end
  end
end