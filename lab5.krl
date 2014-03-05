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
      andy_div = << <div>
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
                            <td>Shout</td>
                            <td>#{ent:shout}</td>
                        </tr>
                        <tr>
                            <td>Created</td>
                            <td>#{ent:created}</td>
                        </tr>
                    </table>
                    </div> >>;
    }
    
    notify("", ent:venue) with sticky = true;
    
  }
}


