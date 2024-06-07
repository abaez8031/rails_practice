# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
  validates :title, :image_url, :artist_id, presence: true
  validates :title, uniqueness: {scope: :artist_id}

  belongs_to :artist,
  class_name: :User,
  foreign_key: :artist_id,
  primary_key: :id

  has_many :artwork_shares,
  class_name: :ArtworkShare,
  foreign_key: :artwork_id,
  primary_key: :id

  has_many :shared_viewers,
  through: :artwork_shares,
  source: :viewer

  def self.artworks_for_user_id(user_id)
    owned_artworks = Artwork.where(artist_id: user_id).to_a
    shared_artworks = Artwork.joins(:artwork_shares).where(artwork_shares: { viewer_id: user_id }).to_a
    owned_artworks.concat(shared_artworks)
  end
end
