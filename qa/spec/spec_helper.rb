require 'capybara/rspec'

require 'browserstack_config'
require 'browsermob/proxy'

proxy_server = BrowserMob::Proxy::Server.new("/bin/browserup-proxy")
proxy_server.start

$browserup_proxy ||= proxy_server.create_proxy(8081)
$browserup_proxy.new_har('QA', {
  capture_headers: true,
  capture_content: true
})

RSpec.configure do |config|
  config.include Capybara::DSL

  Capybara.configure do |capybara|
    capybara.run_server = false
  end

  Capybara.register_driver :browserstack do |app|
    bs_config = BrowserStackConfig.new(app, $browserup_proxy)

    at_exit do
      bs_config.stop
    end

    bs_config.driver
  end

  config.before do
    Capybara.page.driver.browser.manage.window.maximize
  end

  Capybara.default_driver = :browserstack
end
