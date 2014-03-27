ruleset lab8{

  rule location_catch{
  
    select when location notification
    
    pre {
      venue = event:attr("venue");
      city = event:attr("city");
      latitude = event:attr("latitude");
      longitude = event:attr("longitude");
      shout = event:attr("shout");
      created = event:attr("created");
    }
    
    always{
      set ent:venue venue;
      set ent:city city;
      set ent:latitude latitude;
      set ent:longitude longitude;
      set ent:shout shout;
      set ent:created created;
    }
  
  }
  
  rule show_location{
  
    select when web cloudAppSelected
  
    pre{
      andy_div = << <div>
                      <h3>Last Checkin </h3>
                      <table>
                        <tr>
                          <td>Venue</td>
                          <td>#{ent:venue}</td>
                        </tr>
                        <tr>
                          <td>City</td>
                          <td>#{ent:city}</td>
                        </tr>
                        <tr>
                          <td>Latitude</td>
                          <td>#{ent:latitude}</td>
                        </tr>
                        <tr>
                          <td>Longitude</td>
                          <td>#{ent:longitude}</td>
                        </tr>
                        <tr>
                          <td>Shout</td>
                          <td>#{ent:shout}</td>
                        </tr>
                        <tr>
                          <td>Created</td>
                          <td>#{ent:created}</td>
                        </tr>
                      </table> 
                    </div>
                  >>; 
      }
    
    

    replace_inner("#mycloud-app-container", andy_div);

  }

}
