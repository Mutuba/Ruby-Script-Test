
require 'set'

env = ENV.fetch('ENV', 'development')
if env == 'test'
    file = 'webserver.test.log'
else
    file = ARGV[0]
end

class WebpagesTrafficCounter
    attr_accessor :file, :all_visits_hash, :unique_visits_hash, :unique_visits_ip_set

    def initialize(file)
        @file = file
        @all_visits_hash = {}
        @unique_visits_hash = {}
        @unique_visits_ip_set = Set.new
    end

    def generate_all_visits
        File.foreach(file) do |line|
            if all_visits_hash.key?(line.split(" ")[0])
                all_visits_hash[line.split(" ")[0]] += 1
            else
                all_visits_hash[line.split(" ")[0]] = 1
            end
        end
    end


    def generate_unique_visits
        File.foreach(file) do |line|
            if unique_visits_hash.key?(line.split(" ")[0])
                if unique_visits_ip_set.add?(line.split(" ")[1])
                    unique_visits_hash[line.split(" ")[0]] += 1
                end
            else
                unique_visits_hash[line.split(" ")[0]] = 1
                unique_visits_ip_set.add(line.split(" ")[1])
            end
        end
    end


    def print_all_visits
        sorted_all_visits_hash = all_visits_hash.sort {|a1,a2| a2[1]<=>a1[1]}.to_h
        puts "List of webpages with most page views ordered from most pages views to less page views"
        sorted_all_visits_hash.each do |key, value|
            puts "#{key}  #{value} \n"
        end
    end


    def print_unique_visits
        sorted_unique_visits_hash = unique_visits_hash.sort {|a1,a2| a2[1]<=>a1[1]}.to_h
        puts "List of webpages with most unique page views"
        sorted_unique_visits_hash.each do |key, value|
            puts "#{key}  #{value} \n"
        end
    end
end

if env == 'development'
    new_webpages_traffic_counter = WebpagesTrafficCounter.new(file)
    new_webpages_traffic_counter.generate_all_visits
    new_webpages_traffic_counter.print_all_visits
    new_webpages_traffic_counter.generate_unique_visits
    new_webpages_traffic_counter.print_unique_visits
end





