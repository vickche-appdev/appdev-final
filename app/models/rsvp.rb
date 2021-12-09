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
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id" })

  def rsvper
    my_user_id = self.user_id

    matching_users = User.where({ :id => my_user_id })

    the_user = matching_users.at(0)

    return the_user
  end
  
end
