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
  
  }


}
