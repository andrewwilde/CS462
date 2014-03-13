ruleset location_data {

  meta{
    provides get_location_data
  }
  
  global {
      get_location_data = function(k){
        app:key_map.values([k]);
      };
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
    
      key = event:attr("key");
      value = event:attr("value");
      myMap = {};
      myMap2 = myMap.put([key], value);
    }
    
    fired {
      set app:key_map myMap2;
      set app:my_key key;
      set app:my_value value;
    }
    
  }
  
  rule display_map {
    select when pageview ".*"
    
    notify("My value", app:my_value.pick("$.venue")) with sticky = true;
  }
  
}
