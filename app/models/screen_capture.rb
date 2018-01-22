class ScreenCapture < ApplicationRecord

  def initialize(url)
    @url= url
  end

  class << self
    def setup
      puts "===============#{@url.inspect}"
      @url = @url
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

  run do
    puts "-------###---#{@url.inspect}###--running the process"
    @driver.get 'http://localhost:63342/screencapture/screencapture.html'
    @driver.save_screenshot 'headless2_internal.png'
  end
end
