# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  entry_id   :integer          not null
#  member_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base

  belongs_to :entry
  belongs_to :member

  validate do
    unless member && member.votable_for?(entry)
      errors.add(:base, :invalid)
    end
  end
end
