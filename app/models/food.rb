# == Schema Information
#
# Table name: foods
#
#  id              :integer          not null, primary key
#  caption         :text
#  image           :string
#  location        :string
#  meals_avaliable :integer
#  title           :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class Food < ApplicationRecord
  def poster
    return User.where({ :id => self.user_id }).at(0)
  end

#ADDING VALIDATION SO THAT YOU CANT POST WITHOUT BEING A USER
  validates :user_id, :presence => true

  mount_uploader :image, ImageUploader

  #has_many(:rsvps, { :class_name => "Rsvp", :foreign_key => "user_id", :dependent => :destroy })

  def rsvps
    my_id = self.id

    matching_rsvps = Rsvp.where({ :food_id => my_id })

    return matching_rsvps
  end
end
