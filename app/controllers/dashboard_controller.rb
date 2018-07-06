class DashboardController < ApplicationController
  def show
    @playlists = SpotifyUser.new(current_user).playlists
  end
end