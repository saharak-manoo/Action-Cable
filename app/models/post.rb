class Post < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", class_name: "User"
  has_many :comment, foreign_key: "post_id", class_name: "Comment"
end
