class Node < ActiveRecord::Base
  validates :name, presence:{message:"名称不能为空"}
  validates :server, format:{with: /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/, message:"IP格式不对"}
end
