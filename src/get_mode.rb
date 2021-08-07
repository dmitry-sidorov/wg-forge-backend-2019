def get_mode(array)
  array
    .tally
    .sort_by { |_, value| value }
    .last(2)
    .collect { |_, value| value }
    .uniq
end