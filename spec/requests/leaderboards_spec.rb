require 'rails_helper'

RSpec.describe "Leaderboards", type: :request do
  describe "GET /leaderboards" do
    it "displays leaderboard list" do
      Leaderboard.create!({name: "Test Leaderboard"})
      get leaderboards_path
      expect(response.status).to be 200
      expect(response.body).to include("Test Leaderboard")
    end
  end
  describe "GET /leaderboards/:id" do
    it "shows the leaderboard" do
      leaderboard = Leaderboard.create!({name: "Test Leaderboard"})
      get leaderboard_path leaderboard.id
      expect(response.status).to be 200
      expect(response.body).to include("Test Leaderboard")
    end
    it "handles entries with nil" do
      leaderboard = Leaderboard.create!({name: "Test Leaderboard"})
      LeaderboardEntry.create!(score: 10, leaderboard: leaderboard)
      LeaderboardEntry.create!(score: nil, leaderboard: leaderboard)
      get leaderboard_path leaderboard.id
      expect(response.status).to be 200
    end
  end
end
