class Visit < ApplicationRecord
  validates :short_url_id, presence: true
  validates :user_id, presence: true


end
