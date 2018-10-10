require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit '/users/new' }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should has_selector?('title', text: 'Sign up') }
  end
end