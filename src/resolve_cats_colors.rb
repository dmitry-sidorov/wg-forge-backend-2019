def resolve_cats_colors cats
  colors = {}

  cats
    .collect { |cat| cat['color'] }
    .each do |color|
      if !colors.include? color
        colors[color] = 1
      else
        colors[color] += 1
      end
    end
    
  colors
end