ruleset lab5 {
  rule process_fs_checkin{
  
    select when foursquare checkin
    
    pre{
      checkin = event:attr("checkin").decode();
      venue = checkin.pick("$..venue.name");
    }
    
    send_directive('text') with body = 'test';
    
    always {
      set ent:checkin checkin;
      set ent:venue venue;
    }
  }
  
  rule display_checkin {
    select when web cloudAppSelected
    
    pre {
      andy_div = << <div id="andy"></div> >>;
    }
    
    notify("", ent:venue) with sticky = true;
    
  }
}


