require 'yaml'
require 'selenium-webdriver'

class BrowserStackConfig
  attr_reader :driver

  def initialize(app, proxy = nil)
    @app = app
    @proxy = proxy

    @bs_local = start_bs_local
    @driver = create_driver
  end

  def stop
    @proxy.close

    return unless @bs_local

    @bs_local.stop
  end

  private

  def create_driver
    final_caps = caps
    final_caps['browserstack.localIdentifier'] = "QA#{task_id}"
    final_caps['proxy'] = @proxy.selenium_proxy unless @proxy.nil?

    Capybara::Selenium::Driver.new(
      @app,
      browser: :remote,
      url: "http://#{user}:#{key}@#{server}/wd/hub",
      desired_capabilities: final_caps
    )
  end

  def start_bs_local
    return unless enable_local

    bs_local_args = {
      'key' => key, 'logfile' => "local#{task_id}.log",
      'forcelocal' => true, 'localIdentifier' => "QA#{task_id}",
      '-enable-logging-for-api' => '',
      '-parallel-runs' => '10'
    }

    # Code to start browserstack local before start of test
    BrowserStack::Local.new.tap do |browser_stack_local|
      browser_stack_local.start(bs_local_args)
    end
  end

  def enable_local
    caps['browserstack.local'] && caps['browserstack.local'].to_s == 'true'
  end

  def user
    ENV['BROWSERSTACK_USERNAME'] || config_file['user']
  end

  def key
    ENV['BROWSERSTACK_ACCESS_KEY'] || config_file['key']
  end

  def server
    config_file['server']
  end

  def caps
    config_file['common_caps']
      .merge(config_file['browser_caps'][task_id])
  end

  def task_id
    (ENV['TASK_ID'] || 0).to_i
  end

  def config_file
    @config_file ||= YAML.safe_load(File.read(config_file_name))
  end

  def config_file_name
    config_name = ENV['CONFIG_NAME'] || 'single'

    File.join(File.dirname(__FILE__), "../config/#{config_name}.config.yml")
  end
end
