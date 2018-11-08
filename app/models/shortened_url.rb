# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint(8)        not null, primary key
#  short_url  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :string           not null
#

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true

  
  
  def self.random_code  
    code = SecureRandom.urlsafe_base64
    ShortenedUrl.exists?(short_url: code) ? ShortenedUrl.random_code : code
  end 
  
  
  def self.create_code(user,long_url)
    ShortenedUrl.random_code
  end 
  
  
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
  
  # entry = ShortenedUrl.create(short_url: ShortenedUrl.create_code(s, "twitter.com"), user_id: s.id)
  
  
end
