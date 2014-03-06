ruleset lab5 {
  rule process_fs_checkin{
  
    select when foursquare checkin
    
    pre{
      checkin = event:attr("checkin").decode();
      venue = checkin.pick("$..venue.name");
      city = checkin.pick("$..location.city");
      shout = checkin.pick("$..shout", true).head();
      created = checkin.pick("$..createdAt");
    }
    
    send_directive('text') with body = 'test';
    
    always {
      set ent:venue venue;
      set ent:city city;
      set ent:shout shout;
      set ent:created created;
    }
  }
  
  rule display_checkin {
    select when web cloudAppSelected
    
    pre {
      venue = ent:venue;
      city = ent:city;
      shout = ent:shout;
      created = ent:created;
      
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
      replace_inner("#container", andy_div);
      notify("Venue", ent:venue) with sticky = true;
      notify("City", ent:city) with sticky = true;
      notify("Shout", ent:shout) with sticky = true;
      notify("Created", ent:created) with sticky = true;
    }
    
  }
}


