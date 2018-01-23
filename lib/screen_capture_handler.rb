class ScreenCaptureHandler
  def initialize(url, file_name)
    @url= url
    @file_name = file_name
    run do
      @driver.get @url
      @driver.save_screenshot file_name+'.png'
    end
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
end