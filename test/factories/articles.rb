# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  body        :text             not null
#  released_at :datetime         not null
#  expired_at  :datetime
#  member_only :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "Article#{n}" }
    body 'Blah, Blah.'
    released_at 2.weeks.ago
    expired_at 2.weeks.from_now
  end
end
