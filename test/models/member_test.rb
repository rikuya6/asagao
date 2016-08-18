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

require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test 'factory girl' do
    member = FactoryGirl.create(:member)
    assert_equal 'Yamada Taro', member.full_name
  end

  test 'authenticate' do
    member = FactoryGirl.create(:member, name: 'taro',
      password: 'happy', password_confirmation: 'happy')
    assert_nil Member.authenticate('taro', 'lucky')
    assert_equal member, Member.authenticate('taro', 'happy')
  end
end
