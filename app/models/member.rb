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

class Member < ActiveRecord::Base
  include EmailAddressChecker

  attr_accessor :password, :password_confirmation

  has_many :entries, dependent: :destroy
  has_one  :image, class_name: 'MemberImage', dependent: :destroy 

  validates :number,      presence: true,
                          numericality: { only_integer: true, greater_than: 0, less_then: 100, allow_blank: true },
                          uniqueness: true

  validates :name,        presence: true,
                          format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true,
                                    message: :invalid_member_name },
                          length: { minimum: 2, maximum: 20, allow_blank: true },
                          uniqueness: { case_sensitive: false }

  validates :full_name,   length: { maximum: 20 }

  validate  :check_email

  validates :password,    presence: { on: :create },
                          confirmation: { allow_blank: true }

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  private

  def self.search(query)
    one = order 'number'
    if query.present?
      one = one.where('name LIKE ? OR full_name LIKE ?', "%#{query}%", "%#{query}%")
    end
    one
  end

  def check_email
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end

  def self.authenticate(name, password)
    member = find_by(name: name)
    if member && member.hashed_password.present? &&
        BCrypt::Password.new(member.hashed_password) == password
      member
    else
      nil
    end
  end
end
