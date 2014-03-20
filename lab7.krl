ruleset lab7 {
  
  meta {
    use module b505209x5 alias Terminator
  }

  rule nearby {
    select when pageview ".*"
    
    pre {
      x = Terminator:get_location_data("fs_checkin");
      x_latitude = x.pick("$.latitude");
      x_longitude = x.pick("$.longitude");
      latitude = event:attr("latitude");
      longitude = event:attr("longitude");
      
      
      r90   = math:pi()/2;      
      rEk   = 6378;
      rlata = math:deg2rad(x_latitude);
      rlnga = math:deg2rad(x_longitude);
      rlatb = math:deg2rad(latitude);
      rlngb = math:deg2rad(longitude);
      dE = math:great_circle_distance(rlnga,r90 - rlata, rlngb,r90 - rlatb, rEk);
    }
    
    send_directive('nearby') with body = "In the nearby rule";
    
    if (dE < 100) then {
      noop();
    }
    fired{
      raise pds event location_nearby with 
        key = "distance" and
        value = dE;
        
      set ent:test "Fired";
    }
    else{
      raise pds event location_far with 
        key = "distance" and
        value = dE;
        
      set ent:test "Not Fired";
    }
  }
  
  rule test{
    select when pageview ".*"
    
    every{
      notify("Test", ent:test);
    }
  }
}
