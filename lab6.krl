ruleset location_data {

  meta{
    provides get_location_data
  }
  
  global {
      get_location_data = function(k){
        //ent:key_map{k};
        "test";
      };
  }
  
  rule add_location_data{
    select when pds new_location_data
    
    pre{
    
      key = event:attr("key");
      value = event:attr("value");
      map = ent:key_map || {};
      map = map.put(key, value);
    }
    
    every{
      send_directive('checkin') with body = value;
      notify("Add_Location_Data", "");
    }
    fired {
      set ent:key_map map;
    }
    
  }
  
  
  
}
