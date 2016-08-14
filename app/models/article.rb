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

class Article < ActiveRecord::Base
  before_validation :clear_expired_at

  validates :title,         presence: true,
                            length: { maximum: 200 }

  validates :body,          presence: true

  validates :released_at,   presence:true

  validate :check_expired_at

  scope :open, -> {
    now = Time.current
    where("released_at <= ? AND (? < expired_at OR " +
      "expired_at IS NULL)", now, now)
  }

  def no_expiration
    expired_at.blank?
  end

  def no_expiration=(val)
    @no_expiration = val.in?([true, 1, '1'])
  end

  private

  def check_expired_at
    if expired_at && expired_at < released_at
      errors.add(:expired_at, :expired_at_too_old)
    end
  end


  def clear_expired_at
    self.expired_at = nil if @no_expiration
  end

  def self.sidebar_articles(num = 5)
    open.order(released_at: :desc).limit(num)
  end
end
