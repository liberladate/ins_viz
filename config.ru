app_file = File.join File.dirname(File.expand_path(__FILE__)), 'app.rb'

require app_file

run Ronin::Website
