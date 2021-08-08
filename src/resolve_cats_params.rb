require_relative 'get_mean'
require_relative 'get_median'
require_relative 'get_mode'

def resolve_cats_params(cats)
  tail_lengths = cats.map { |cat| cat['tail_length'].to_i }
  whiskers_lengths = cats.map { |cat| cat['whiskers_length'].to_i }

  {
    tail_length_mean: get_mean(tail_lengths),
    tail_length_median: get_median(tail_lengths),
    tail_length_mode: get_mode(tail_lengths),
    whiskers_length_mean: get_mean(whiskers_lengths),
    whiskers_length_median: get_median(whiskers_lengths),
    whiskers_length_mode: get_mode(whiskers_lengths)
  }
end