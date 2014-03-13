ruleset location_data {

  meta{
    provides get_location_data
  }
  
  global {
      get_location_data = function(k){
        ent:key_map{k};
      };
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
    
      key = event:attr("key");
      value = event:attr("value");
      map = {};
      map = map.put(key, value);
    }
    
    fired {
      set ent:key_map map;
      set ent:my_key key;
      set ent:my_value value;
    }
    
  }
  
  rule display_map {
    select when pageview ".*"
    
    notify("My key", ent:my_key) with sticky = true;
    notify("My value", ent:my_value) with sticky = true;
  }
  
}
