module UsersHelper

  # 流量单位转换,基数单位为B
  def k_m_g(total)
    if total<1024*1024
      return "#{(total/1024.0).round(2)}KB"
    elsif total<1024*1024*1024.0
      return "#{(total/1024.0/1024.0).round(2)}MB"
    else
      return "#{(total/1024.0/1024.0/1024.0).round(2)}GB"
    end
  end

  # 流量单位转换,基数单位为kB
  def m_g(total)
    if total<1024
      return "#{total.round(2)}KB"
    elsif total<1024*1024.0
      return "#{(total/1024.0).round(2)}MB"
    else
      return "#{(total/1024.0/1024.0).round(2)}GB"
    end
  end

  # 生成二维码链接
  def base64_ss_uri(method,ip)
    "ss://"+Base64.urlsafe_encode64("#{method}:#{@current_user.passwd}@#{ip}:#{@current_user.port}")
  end
end
