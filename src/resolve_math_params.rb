require_relative 'get_median'
require_relative 'get_mode'

def resolve_math_params array
  {
    mean: (array.sum / array.length.to_f).round(1),
    median: get_median(array),
    mode: get_mode(array)
  }
end