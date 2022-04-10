require "rspec"
require_relative './solution'

RSpec.describe WebpagesTrafficCounter, '.all_visits_hash' do
    let(:subject) { WebpagesTrafficCounter.new('webserver.test.log') }
    it 'it returns correct keys for all visits' do
      subject.generate_all_visits
      expect(subject.all_visits_hash.keys).to match_array(
        ['/help_page/1', '/contact', '/home', '/about/2', '/index', '/about'],
      )
    end
  
    it 'it returns correct values for all visits' do
      subject.generate_all_visits
      p subject.all_visits_hash
      expect(subject.all_visits_hash.values).to match_array([1, 1, 1, 1, 2, 6])
    end
  end
  
  RSpec.describe WebpagesTrafficCounter, '.unique_visits_hash' do
    let(:subject) { WebpagesTrafficCounter.new('webserver.test.log') }
    it 'it returns correct keys for unique visits' do
      subject.generate_unique_visits
      expect(subject.unique_visits_hash.keys).to match_array(
        ['/help_page/1', '/contact', '/home', '/about/2', '/index', '/about'],
      )
    end
  
    it 'it returns correct values for unique visits and handles multiple visits by same ip address' do
      subject.generate_unique_visits
      expect(subject.unique_visits_hash.values).to match_array([4, 1, 2, 1, 1, 1])
    end
  
    it 'it returns correct values for unique ip addresses in the unique_visits_ip_set' do
      subject.generate_unique_visits
      expect(subject.unique_visits_ip_set.to_a).to match_array(
        ['126.318.035.038', '722.247.931.582', '646.865.545.408', '184.123.665.067',
         '444.701.448.104', '929.398.951.889', '061.945.150.735', '235.313.352.950'],
      )
    end
  end