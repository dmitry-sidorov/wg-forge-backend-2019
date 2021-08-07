require 'pg'
require_relative 'resolve_cats_params'

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
  cats_params.each do |tail_length, whiskers_length|
    keys = "
      tail_length_mean,
      tail_length_median,
      tail_length_mode,
      whiskers_length_mean,
      whiskers_length_median,
      whiskers_length_mode
    "

    values = "
      #{tail_length['mean']}, 
      #{tail_length['median']},
      #{tail_length['mode']},
      #{whiskers_length['mean']},
      #{whiskers_length['median']},
      #{whiskers_length['mode']}
    "

    connection.exec("INSERT INTO cats_stat (#{keys}) VALUES (#{values})")
  end
end

# connection.exec("SELECT * from cat_colors_info") do |cat_colors_info|
#   puts cat_colors_info.to_a
# end

