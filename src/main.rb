require 'pg'
require_relative 'resolve_cats_params'
require_relative 'resolve_insert_value'

connection = PG.connect(
  host: "localhost",
  port: 5432,
  dbname: "wg_forge_db",
  user: "wg_forge",
  password: "42a"
)


connection.exec("SELECT * from cats") do |result|
  cats = result.to_a
  cat_colors = cats.collect { |cat| cat['color'] }.tally

  cat_colors.each do |color, count|
    connection.exec("INSERT INTO cat_colors_info (color, count) VALUES ('#{color}', '#{count}')")
  end

  cats_params = resolve_cats_params(cats)
  keys = cats_params.keys.join(",")
  values = cats_params
    .values
    .map { |value| resolve_insert_value(value) }
    .join(",")

  connection.exec("INSERT INTO cats_stat (#{keys}) VALUES (#{values})")
end

connection.exec("SELECT * from cat_colors_info") do |cat_colors_info|
  puts "cat_colors_info"
  puts cat_colors_info.to_a
end

connection.exec("SELECT * from cats_stat") do |cats_stat|
  puts "cats_stat"
  puts cats_stat.to_a
end

