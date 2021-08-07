require 'pg'
require_relative 'resolve_cats_colors'

connection = PG.connect(
  host: "localhost",
  port: 5432,
  dbname: "wg_forge_db",
  user: "wg_forge",
  password: "42a"
)

cat_colors = []

connection.exec("SELECT * from cats") do |cats|
  cat_colors = resolve_cats_colors(cats.to_a)
end

cat_colors.each do |color, count|
  connection.exec("INSERT INTO cat_colors_info (color, count) VALUES ('#{color}', '#{count}')")
end

connection.exec("SELECT * from cat_colors_info") do |cat_colors_info|
  puts cat_colors_info.to_a
end

