class AddArtistRefToConcert < ActiveRecord::Migration
  def up
    add_reference :concerts, :artist, index: true
    Concert.all.each do |concert|
      artist = Artist.where(:name => concert.performer).first_or_create
      concert.artist = artist
      concert.save
    end
    remove_column :concerts, :performer
  end
  def down
    add_column :concerts, :performer, :string
    Artists.all.each do |artist|
      Concert.where(:performer => artist.name) do |concert|
        concert.performer = artist.name
      end
    end
    remove_reference :concerts, :artist
  end
end
