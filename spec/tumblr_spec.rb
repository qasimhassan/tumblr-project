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
        email_elm = @browser.div(:id, "signup_determine").text_field.value = "qas_hassan@live.co.uk"
        next_btn = @browser.button id: "signup_forms_submit"
        next_btn.click
        pass_elm = @browser.div(:id, "signup_account").text_field(:id, "signup_password")
        pass_elm.when_present.set 'godzilla1'
        next_btn.click
      end
  end

  context 'create post tumblr tests' do
    it "should find the create post button" do
      text_btn = @browser.nav(:id, "post_buttons").a(:id, "new_post_label_text").click
      title_elm = @browser.div(:class, "editor-plaintext").when_present
      title_elm.click
      title_elm.send_keys("test post")
      body_elm = @browser.div(:class, "editor editor-richtext").when_present
      body_elm.click
      body_elm.send_keys("this is a test post")
      post_btn = @browser.button(:class, "button-area create_post_button")
      post_btn.click
#binding.pry
    end
  end
end
