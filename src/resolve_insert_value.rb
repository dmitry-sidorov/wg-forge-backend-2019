def resolve_insert_value(value)
  return "'{#{value.join(",")}}'" if value.kind_of?(Array)
   
  value
end