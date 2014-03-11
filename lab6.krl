ruleset location_data {

  meta{
    provides get_location_data
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
      map = ent:map.put(key, value);
      
      get_location_data = function(k){
        map{k};
      };
      
    }
  }
}
