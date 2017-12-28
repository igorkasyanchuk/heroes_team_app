require 'rails_helper'

RSpec.describe Account::ProfileController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in @user
  end

  it "GET #edit returns http success" do
    get :edit
    expect(response).to have_http_status(200)
  end
end
