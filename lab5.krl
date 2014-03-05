ruleset lab5 {

  rule fs_checkin {
    select when foursquare checkin
    pre {
      // decode the JSON to get the data structure
      checkin = event:attr("checkin").decode();          
    }
    noop();
    fired {
      raise pds event new_location_available with
         key = "foursquare" and
         value = 
           {"venue": checkin.pick("$..venue.name"),
            "city": checkin.pick("$..location.city"),
            "shout": checkin.pick("$..shout", true).head(),
            "createdAt": checkin.pick("$..createdAt")
           }
    }
  }
  

}
