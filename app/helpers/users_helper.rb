module UsersHelper

  def k_m_g(total)
    if total<1024*1024
      return "#{(total/1024.0).round(2)}KB"
    elsif total<1024*1024*1024.0
      return "#{(total/1024.0/1024.0).round(2)}MB"
    else
      return "#{(total/1024.0/1024.0/1024.0).round(2)}GB"
    end
  end

  def m_g(total)
    if total<1024
      return "#{total.round(2)}KB"
    elsif total<1024*1024.0
      return "#{(total/1024.0).round(2)}MB"
    else
      return "#{(total/1024.0/1024.0).round(2)}GB"
    end
  end
end
