require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates or updates itself from an oauth hash" do
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
    new_user = User.first

    expect(new_user.provider).to eq("spotify")
    expect(new_user.uid).to eq("1263322089")
    expect(new_user.email).to eq("z1685839@students.niu.edu")
    expect(new_user.name).to eq("Johnny Craig")
    expect(new_user.token).to eq("BQCQT8kuGYb29HHDwj2N0FU5CEApbc4GvOVAPPhAGnrfvlijAyfw_hwk-c9e3makSWK9BApYcTHQCZQ44ifr3B7FyBMAjTrqXmuY3r2hZONitgGi6ciiZbalgXZSkgMQ9EIB8dZLw5MQyJQ-X7XjMly10uOo6WMaC0G2-7RSSAUqPxbCsbZLmw")
    expect(new_user.refresh_token).to eq("AQCTHcmah4nCu7a8n4m8kGAML7LCfsYFHGwCPjQm0lq58gdTTIX4X5eYHtvtz2PvhIozIC7Zp_B55Q1KSJZx3ghFcXkJqaBvP0yjVcuZwtNgY0l3AXv3k8Xgeypy7zgw5TI")
    expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])

  end
end
