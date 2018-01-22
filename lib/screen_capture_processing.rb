# require 'selenium-webdriver'
# require 'headless'

module ScreenCaptureProcessing

  def initialize(url)
    @url =url
  end

  def setup
    @headless = Headless.new(display: 100, reuse: true, destroy_at_exit: true).start
    @driver = Selenium::WebDriver.for :firefox
  end

  def teardown
    @driver.quit
  end

  def run
    setup
    yield
    teardown
  end

  run do
    @driver.get @url
    @driver.save_screenshot 'headless2_internal.png'
  end
end