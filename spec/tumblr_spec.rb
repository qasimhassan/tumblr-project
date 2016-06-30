require 'spec_helper'

describe Tumblr do
  before :all do
    @browser = Watir::Browser.new
    @browser.goto "http://tumblr.co.uk"
  end
  context 'log in tumblr tests' do
      it "should find the login button and click it" do
        login_btn = @browser.button id: "signup_login_button"
        login_btn.click
      end
      it "should find the email and password textfield and enter values then click login" do
        email = @browser.div(:id, "signup_determine").text_field.value = "qas_hassan@live.co.uk"
        next_btn = @browser.button id: "signup_forms_submit"
        next_btn.click
        pass = @browser.text_field(id: "signup_password").set "godzilla1"
        next_btn.click
      end
  end

  context 'create post tumblr tests' do
    it "should find the create post button" do
      post_btn = @browser.button class: "compose-button"
      post_btn.flash
      post_btn.click
      #post-type-icon icon-text
    end
  end
end
