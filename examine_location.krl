ruleset examine_location {

  meta {
    use module b505209x5 alias Terminator
  }
  
  global {
    x = Terminator:get_location_data();
  }
  
  rule show_fs_location {
    select when pageview ".*"
    
    pre {
      venue = x["venue"];
      city = x["city"];
      shout = x["shout"];
      created = x["createdAt"];
      
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
                      </table>
                    </div>
                        >>; 
    }
    
    every{
      replace_inner("#mycloud-app-container", andy_div);
    }
    
  }
}
