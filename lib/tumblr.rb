class Tumblr
  def initialize
    browser = Watir::Browser.new
    browser.goto "https://tumblr.com"
  end
end
