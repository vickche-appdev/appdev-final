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
end
