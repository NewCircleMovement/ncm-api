require 'rails_helper'

RSpec.describe "Movements", type: :request do
  describe "GET /movements" do
    it "works! (now write some real specs)" do
      get movements_path
      expect(response).to have_http_status(200)
    end
  end
end
