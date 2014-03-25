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
  
  rule show_location{
  
    select when pageview ".*"
  
    pre{
      andy_div = << <div>
                      <h3>Last Checkin </h3>
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
                          <td>Created At</td>
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
                      </table> 
                    </div>
                  >>; 
      }
    
    

    replace_inner("#mycloud-app-container", andy_div);

  }

}
