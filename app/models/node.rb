class Node < ActiveRecord::Base
  validates :name, presence: true
end
