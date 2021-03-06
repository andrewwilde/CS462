ruleset examine_location {

  meta {
    use module b505209x5 alias Terminator
  }
  
  rule show_fs_location {
    select when web cloudAppSelected
    
    pre {
      x = Terminator:get_location_data("fs_checkin");
      printX = x.encode();
      venue = x.pick("$.venue");
      city = x.pick("$.city");
      shout = x.pick("$.shout");
      created = x.pick("$.createdAt");
      latitude = x.pick("$.latitude");
      longitude = x.pick("$.longitude");
      
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
    
    every{
      replace_inner("#mycloud-app-container", andy_div);
      notify("Sanity Check", printX) with sticky = true;
    }
    
  }
}
