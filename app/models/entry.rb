# == Schema Information
#
# Table name: entries
#
#  id         :integer          not null, primary key
#  member_id  :integer          not null
#  title      :string           not null
#  body       :text
#  posted_at  :datetime         not null
#  status     :string           default("draft"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Entry < ActiveRecord::Base

  belongs_to :author, class_name: 'Member', foreign_key: 'member_id'

  STATUS_VALUES = %w(draft member_only public)

  validates :title,     presence: true, length: { maximum: 200 }

  validates :body,      presence: true

  validates :posted_at, presence: true

  validates :status,    inclusion: { in: STATUS_VALUES }

  scope :common,        -> { where(status: 'public') }
  scope :published,     -> { where("status <> ?", 'draft') }
  scope :full,          ->(member) { where("status <> ? OR member_id = ?", 'draft', member.id) }
  scope :readable_for,  ->(member) { member ? full(member) : common }

  private

  def self.status_text(status)
    I18n.t("activerecord.attributes.entry.status_#{status}")
  end

  def self.status_options
    STATUS_VALUES.map { |status| [status_text(status), status] }
  end

  def self.sidebar_entries(member, num = 5)
    readable_for(member).order(posted_at: :desc).limit(num)
  end
end
