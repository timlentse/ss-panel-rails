class UserToken < ActiveRecord::Base
  belongs_to :user, class_name: 'user'
end
