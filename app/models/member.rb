# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  number        :integer          not null
#  name          :string           not null
#  full_name     :string
#  email         :string
#  birthday      :date
#  gender        :integer          default(0), not null
#  administrator :boolean          default(FALSE), not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Member < ActiveRecord::Base
  def self.search(query)
    one = order 'number'
    if query.present?
      one = one.where('name LIKE ? OR full_name LIKE ?', "%#{query}%", "%#{query}%")
    end
    one
  end
end
