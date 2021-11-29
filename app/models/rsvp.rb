# == Schema Information
#
# Table name: rsvps
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  food_id    :integer
#  user_id    :integer
#
class Rsvp < ApplicationRecord
  belongs_to(:food, { :required => true, :class_name => "Food", :foreign_key => "food_id" })
end
