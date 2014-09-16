class Like < ActiveRecord::Base
  belongs_to :post, class_name: "Forem::Post"
  belongs_to :user, class_name: "User"
end
