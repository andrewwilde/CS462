ruleset examine_location {

  meta {
    use module b505209x5 alias Terminator
  }
  
  rule show_fs_location {
    select when pageview ".*"
    
    pre {
      values = Terminator:get_location_data("fs_checkin");
      venue = values["venue"];
      city = values["city"];
      shout = values["shout"];
      created = values["createdAt"];
      
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
                          <td>Created At</td>
                          <td>#{created}</td>
                        </tr> >>;
    }
    
    every{
      replace_inner("#mycloud-app-container", andy_div);
    }
    
  }
}
