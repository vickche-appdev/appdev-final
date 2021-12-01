# == Schema Information
#
# Table name: foods
#
#  id              :integer          not null, primary key
#  caption         :text
#  image           :string
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
  
  
  has_many(:rsvps, { :class_name => "Rsvp", :foreign_key => "user_id", :dependent => :destroy })
end
