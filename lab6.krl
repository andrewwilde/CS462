ruleset location_data {

  meta{
    provides get_location_data
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
    
      key = event:attr("key");
      value = event:attr("value");
      map = ent:key_map || {};
      map = map.put(key, value);
      
      get_location_data = function(k){
        map{k};
      };
    }
    
    fired {
      set ent:key_map map;
    }
    
  }
  
  
  
}
