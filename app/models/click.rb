# frozen_string_literal: true

# == Schema Information
#
# Table name: clicks
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  link_id    :uuid
#
# Indexes
#
#  index_clicks_on_link_id  (link_id)
#
# Foreign Keys
#
#  fk_rails_...  (link_id => links.id)
#

class Click < ApplicationRecord
  belongs_to :link
end
