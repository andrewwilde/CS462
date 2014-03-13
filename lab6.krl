ruleset location_data {

  meta{
    provides get_location_data
  }
  
  global {
      get_location_data = function(k){
        app:key_map{k};
      };
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
    
      key = event:attr("key");
      value = event:attr("value");
      map = {};
      map = map.put(key, value);
      strMap = map.encode();
    }
    
    fired {
      set app:key_map map;
      set app:my_key key;
      set app:my_value value;
      set app:strMap strMap;
    }
    
  }
  
  rule display_map {
    select when pageview ".*"
    
   // notify("My key", app:my_key) with sticky = true;
   notify("My value", app:strMap) with sticky = true;
  }
  
}
