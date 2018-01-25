class ScreenCaptureHandler
  attr_accessor :file_name
  def initialize(service_url)
    @service_url= service_url
    @file_name = create_file_name(service_url)
    run do
      @driver.get @service_url
      @driver.save_screenshot('public/screenshots/'+@file_name)
    end
  end

  def create_file_name(service_url)
    if service_url.include?('localhost')
      'demo'+Time.now.strftime('%d%b%y%H%M%S')+'.png'
    else
      service_url.sub('www.', '').split('//').last.split('.').first+Time.now.strftime('%d%b%y%H%M%S')+'.png'
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
    @file_name
  end
end