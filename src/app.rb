# Server entry point
require "sinatra"
require "mysql2"
require "inifile"

# try mysql
begin
    mysql_cnf = File.join(File.dirname(__FILE__), "db", "my.cfg")
    mysql_conf = IniFile.new(:filename => mysql_cnf)['client']
    client = Mysql2::Client.new(
        :host => mysql_conf["host"],
        :username => mysql_conf["username"],
        :password =>mysql_conf["password"]
    )
    puts client.info
rescue StandardError => e
    puts e.message
    puts e.backtrace.inspect
end

get "/" do
    "hello world"
end
