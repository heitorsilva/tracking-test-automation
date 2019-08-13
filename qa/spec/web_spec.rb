require 'spec_helper'
require 'json'

describe 'QA' do
  context 'and web system' do
    before do
      visit 'http://web.localhost:8000'
    end

    it 'are communicating well' do
      expect(page).to have_text('Welcome to Your Vue.js App')
    end

    context 'when clicking on Click Me' do
      before do
        @tracking_fired = false

        page.find(:xpath, '//input[@id="btn1"]').click
      end

      it 'should fire a tracking event' do
        expect(@tracking_fired).to be(false)
      end

      after do
        sleep(1) # give time to capture everything on the proxy

        network = JSON.parse($browserup_proxy.har.entries.to_json)

        (0..network.size-1).each do |i|
          url = 'http://api.localhost:3000/track'
          @tracking_fired = true and break if network[i]['request']['method'] == 'POST' && network[i]['request']['url'] == url
        end

        expect(@tracking_fired).to be(true)
      end
    end
  end

  context 'and API system' do
    before do
      visit 'http://api.localhost:3000'
    end

    it 'can access api system' do
      expect(page).to have_text('Hello API World!')
    end
  end
end
