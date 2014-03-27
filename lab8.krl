ruleset lab8{

  rule location_catch{
  
    select when location notification
    
    pre {
      venue = event:attr("my_venue");
    }
    
    always{
      set ent:test "test;
      set ent:venue venue;
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
                          <td>#{ent:venue}</td>
                        </tr>
                        <tr>
                          <td>Test</td>
                          <td>#{ent:test}</td>
                        </tr>
                      </table> 
                    </div>
                  >>; 
      }
    
    

    replace_inner("#main", andy_div);

  }

}
