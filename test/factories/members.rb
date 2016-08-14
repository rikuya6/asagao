# == Schema Information
#
# Table name: members
#
#  id              :integer          not null, primary key
#  number          :integer          not null
#  name            :string           not null
#  full_name       :string
#  email           :string
#  birthday        :date
#  gender          :integer          default(0), not null
#  administrator   :boolean          default(FALSE), not null
#  created_at      :datetime
#  updated_at      :datetime
#  hashed_password :string
#

FactoryGirl.define do
  factory :member do
    sequence(:number) { |n| n + 1 }
    sequence(:name) { |n| "Taro#{n}" }
    full_name 'Yamada Taro'
    sequence(:email) { |n| "taro#{n}@example.com" }
    birthday 20.years.ago
    password 'password'
    password_confirmation 'password'
  end
end
