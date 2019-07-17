# Server entry point

require "sinatra"
require "mysql2"
require "inifile"

# try mysql
begin
    mysql_config_file = File.join(File.dirname(__FILE__), "db", "mysql.ini")
    mysql_params = IniFile.new(:filename => mysql_config_file)['client']
    client = Mysql2::Client.new(mysql_params)
    puts client.info
rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
end

get "/" do
    "hello world"
end
