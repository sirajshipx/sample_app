
require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit 'sessions/new' }

    it { should have_selector('h1',    text: 'Sign in') }
    it { should has_selector?('title', text: 'Sign in') }
  end
   describe "signin" do
    before { visit 'sessions/new' }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should has_selector?('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
    end
end
   describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it { should has_selector?('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should has_link?('Sign out', href: 'sessions/destroy') }
      it { should_not have_link('Sign in', href: 'sessions/new') }
       describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end
