class Playlist
  attr_reader :name, :tracks_href
  def initialize(data)
    @name = data[:name]
    @tracks_href = data[:tracks][:href]
  end
end