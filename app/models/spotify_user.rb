class SpotifyUser
  attr_reader :user
  def initialize(user)
    @user = user
  end

  def playlists
    PlaylistsService.new(@user).playlists
  end
end