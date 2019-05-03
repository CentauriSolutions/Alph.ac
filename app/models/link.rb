# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id         :uuid             not null, primary key
#  slug       :text
#  url        :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid
#
# Indexes
#
#  index_links_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Link < ApplicationRecord
  belongs_to :user, optional: true
  has_many :clicks, dependent: :destroy

  def to_param
    "#{slug}+"
  end
end
