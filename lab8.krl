ruleset lab8{

  rule location_catch{
  
    select when location notification
    
    pre {
      x = event:attr("values");
      venue = x.pick("$.venue");
      city = x.pick("$.city");
      shout = x.pick("$.shout");
      created = x.pick("$.createdAt");
      latitude = x.pick("$.latitude");
      longitude = x.pick("$.longitude");
    
    }
    
    always{
      set ent:venue venue;
      set ent:city city;
      set ent:shout shout;
      set ent:created created;
      set ent:latitude latitude;
      set ent:longitude longitude;
    }
  
  }


}
