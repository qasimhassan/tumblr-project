require 'spec_helper'

describe "Tumblr watir" do
  before :all do
    @browser = Watir::Browser.new
    @browser.goto "http://tumblr.co.uk"
    @file = YAML.load(File.open('./login_data.yml'))
  end

  context 'log in tumblr tests' do

    it "should find the initial login button and click it" do
      login_btn = @browser.button id: "signup_login_button"
      login_btn.click

      expect(@browser.url).to eq "https://www.tumblr.com/login"
    end

    it "should find the email and password textfield and enter values then click login" do

      email_elm = @browser.div(:id, "signup_determine").text_field.value = @file['logindetails']['email']
      next_btn = @browser.button id: "signup_forms_submit"
      next_btn.click
      pass_elm = @browser.div(:id, "signup_account").text_field(:id, "signup_password")
      pass_elm.when_present.set @file['logindetails']['password']
      next_btn.click
      text_btn = @browser.nav(:id, "post_buttons").a(:id, "new_post_label_text")

      expect(@browser.url).to eq "https://www.tumblr.com/dashboard"
      expect(text_btn.present?).to eq true
    end
  end

  context 'create post tumblr tests' do
    it "should find the create post button and click it" do
      text_btn = @browser.nav(:id, "post_buttons").a(:id, "new_post_label_text").click

      expect(@browser.url).to eq "https://www.tumblr.com/new/text"
    end

    it "should find and enter a value in the title field" do
      title_elm = @browser.div(:class, "editor-plaintext").when_present
      title_elm.click
      title_elm.send_keys(@file['postdetails']['title'])

      expect(title_elm.text).to eq @file['postdetails']['title']
    end

    it "should find and enter a value in the body text field" do
      body_elm = @browser.div(:class, "editor editor-richtext").when_present
      body_elm.click
      body_elm.send_keys(@file['postdetails']['text'])

      expect(body_elm.text).to eq @file['postdetails']['text']
    end

    it "should find and click the post button" do
      post_btn = @browser.button(:class, "button-area create_post_button")
      if post_btn.click != nil
        puts "failure!"
      else
        puts "success!"
      end
    end

    it "should check if the post has been created" do
      #set an implicit wait here
      @browser.driver.manage.timeouts.implicit_wait = 6 #6 seconds
      acc = @browser.div(id: "account_button").when_present
      acc.click
      post = @browser.li(class: "blog-sub-nav-item").when_present
      post.click
      @browser.driver.manage.timeouts.implicit_wait = 6 #6 seconds
      lists = @browser.lis(class: "post_container")
      expect(lists[1].text).to include @file['postdetails']['title']
    end
  end

  after :all do
    #@browser.close
  end
end
