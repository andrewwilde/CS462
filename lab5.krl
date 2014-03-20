ruleset lab5 {
  rule process_fs_checkin{
  
    select when foursquare checkin
    
    pre{
      checkin = event:attr("checkin").decode();
      venue = checkin.pick("$..venue.name");
      city = checkin.pick("$..location.city");
      shout = checkin.pick("$..shout", true).head();
      created = checkin.pick("$..createdAt");
      myMap = {"venue":venue,"city":city,"shout":shout,"createdAt":created};
      
    }
    
    always {
      set ent:my_venue venue;
      set ent:my_city city;
      set ent:my_shout shout;
      set ent:my_created created;
      set ent:my_checkin checkin;
      
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
                    </table>
                  </div> >>;
    }
    
    every{
      replace_inner("#mycloud-app-container", andy_div);
    }
    
  }
  
  rule test_page{
    select when pageview ".*"
    
    pre {
      checkin = ent:checkin;
    }
    
    notify(checkin, "test") with sticky = true;
  }
}


