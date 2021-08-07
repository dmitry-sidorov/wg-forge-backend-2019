require_relative 'resolve_math_params'

def resolve_cats_params(cats)
  tail_lengths = cats.map { |cat| cat['tail_length'].to_i }
  whiskers_lengths = cats.map { |cat| cat['whiskers_length'].to_i }

  { 
    tail_length: resolve_math_params(tail_lengths),
    whiskers_length: resolve_math_params(whiskers_lengths)
  }
end