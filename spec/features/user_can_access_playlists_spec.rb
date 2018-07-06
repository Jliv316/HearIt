require 'rails_helper'

feature 'user clicks on playlists' do
  scenario 'users playlists are returned' do
    auth = 
      {
        provider: "spotify",
        uid: "1263322089",
        info: {
          email: "z1685839@students.niu.edu",
          name: "Johnny Craig",
        },
        credentials: {
          token: "BQCQT8kuGYb29HHDwj2N0FU5CEApbc4GvOVAPPhAGnrfvlijAyfw_hwk-c9e3makSWK9BApYcTHQCZQ44ifr3B7FyBMAjTrqXmuY3r2hZONitgGi6ciiZbalgXZSkgMQ9EIB8dZLw5MQyJQ-X7XjMly10uOo6WMaC0G2-7RSSAUqPxbCsbZLmw",
          refresh_token: "AQCTHcmah4nCu7a8n4m8kGAML7LCfsYFHGwCPjQm0lq58gdTTIX4X5eYHtvtz2PvhIozIC7Zp_B55Q1KSJZx3ghFcXkJqaBvP0yjVcuZwtNgY0l3AXv3k8Xgeypy7zgw5TI",
          expires_at: 1530823574.seconds.from_now}
      }
    User.update_or_create(auth)
    user = User.first
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    json_response = File.open("./fixtures/playlists.json")
    url = "https://api.spotify.com/v1/me/playlists?access_token=#{user.token}"
    stub_request(:get, url).to_return(status: 200, body: json_response)

    visit '/'

    click_on "Playlists"

    expect(current_path).to eq("/Johnny%20Craig")
    expect(SpotifyUser.new(user).playlists.count).to eq(20)
  end
end
