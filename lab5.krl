ruleset lab5 {

  global{
  
    subscribers = [
                    { "cid":"80B24A7A-B437-11E3-B0C2-6AC7E058E56E"}, 
                    { "cid":"34E7385C-B438-11E3-9386-6AC7E058E56E"}
                  ]
    subscription_map =
                 {"name":"Phil",
                  "phone":"8013625611",
                  "cid":"34E7385C-B438-11E3-9386-6AC7E058E56E",
                  "calendar":"https://www.google.com/calendar/..."
                 };
  
  }


  rule dispatch {
    select when foursquare checkin
    
    foreach subscribers setting (subscriber)
    pre{
      checkin = event:attr("checkin").decode();
      venue = checkin.pick("$..venue.name");
      city = checkin.pick("$..location.city");
      latitude = checkin.pick("$..location.lat");
      longitude = checkin.pick("$..location.lng");
      shout = checkin.pick("$..shout", true).head();
      created = checkin.pick("$..createdAt");
      myMap = {"venue":venue,"city":city,"shout":shout,"createdAt":created,"latitude":latitude,"longitude":longitude};
      
    }
    {
      event:send(subscriber,"location","notification") 
        with attrs = {"values" : myMap};
    }
    always {
      set ent:my_venue venue;
      set ent:my_city city;
      set ent:my_shout shout;
      set ent:my_created created;
      set ent:my_lat latitude;
      set ent:my_lng longitude;
      set ent:test "test";
    }
  }

  rule process_fs_checkin{
  
    select when foursquare checkin
    
    foreach subscribers setting (subscriber)
    pre{
      cid = subscriber.pick("$.cid");
      checkin = event:attr("checkin").decode();
      venue = checkin.pick("$..venue.name");
      city = checkin.pick("$..location.city");
      latitude = checkin.pick("$..location.lat");
      longitude = checkin.pick("$..location.lng");
      shout = checkin.pick("$..shout", true).head();
      created = checkin.pick("$..createdAt");
      myMap = {"venue":venue,"city":city,"shout":shout,"createdAt":created,"latitude":latitude,"longitude":longitude};
      
    }
    
    always {
      raise pds event new_location_data with
        key = "fs_checkin" and
        value = myMap;
    }
    
  }
  
  rule display_checkin {
    select when web cloudAppSelected
    
    pre {
      venue = ent:my_venue;
      city = ent:my_city;
      shout = ent:my_shout;
      created = ent:my_created;
      latitude = ent:my_lat;
      longitude = ent:my_lng;
      test = ent:test;
      
      andy_div = << <div>
                    <table>
                        <tr>
                            <td>Venue</td>
                            <td>#{venue}</td>
                        </tr>
                        <tr>
                            <td>City</td>
                            <td>#{city}</td>
                        </tr>
                        <tr>
                            <td>Shout</td>
                            <td>#{shout}</td>
                        </tr>
                        <tr>
                            <td>Created</td>
                            <td>#{created}</td>
                        </tr>
                        <tr>
                            <td>Latitude</td>
                            <td>#{latitude}</td>
                        </tr>
                        <tr>
                            <td>Longitude</td>
                            <td>#{longitude}</td>
                        </tr>
                                                <tr>
                            <td>Test</td>
                            <td>#{test}</td>
                        </tr>
                    </table>
                  </div> >>;
    }
    
    every{
      replace_inner("#mycloud-app-container", andy_div);
    }
    
  }
  
}


