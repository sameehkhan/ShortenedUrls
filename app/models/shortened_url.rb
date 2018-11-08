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
    code = ShortenedUrl.random_code
    ShortenedUrl.create(short_url: code, user_id: user.id)
  end 
  
  
  def num_clicks
    self.visited_urls.count 
  end 
  
  def num_uniques
    arr = []
    self.visited_urls.each do |visit|
      arr << visit[:user_id]
    end 
    arr.uniq.count
  end 
  
  def num_recent_uniques
    
  end 
  
  
  
  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User
  
  has_many :visited_urls,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: :Visit
  
  
  # entry = ShortenedUrl.create(short_url: ShortenedUrl.create_code(s, "twitter.com"), user_id: s.id)
  
  
end
