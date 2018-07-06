class PlaylistsService
  def initialize(user)
    @user = user
  end

  def playlists
    data.map do |playlist_info|
      Playlist.new(playlist_info)
    end
  end

  private
  def conn
    Faraday.new("https://api.spotify.com")
  end

  def response
    conn.get "/v1/me/playlists" do |request|
      request.params["access_token"] = @user.token
    end
  end

  def data
    json = JSON.parse(response.body, symbolize_names: true)
    json[:items]
  end
end