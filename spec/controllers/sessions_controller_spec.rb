require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  describe "登录" do
    it "登录成功" do
      post :create, email: @user.email, password: @user.password
      expect(response.status).to eq 302
    end

    it "登录失败" do
      post :create, email: @user.email, password: 'wrong password'
      expect(response.status).to eq 200
    end
  end

  describe '退出登录' do
    it '退出登录' do
      session[:user_name] = @user.name
      session[:user_id] = @user.id
      get 'destroy'
      expect(response.status).to eq 302
    end
  end
end
