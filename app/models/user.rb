# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  post_count :integer
#  rsvp_count :integer
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
end
