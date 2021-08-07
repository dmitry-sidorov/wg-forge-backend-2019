require 'pg'

connection = PG.connect(
  host: "localhost",
  port: 5432,
  dbname: "wg_forge_db",
  user: "wg_forge",
  password: "42a"
)

cats = connection.exec("SELECT * from cats") do |result|
  result.each do |row|
    puts row
  end
end
