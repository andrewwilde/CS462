ruleset lab5 {
  rule process_fs_checkin{
  
    select when foursquare checkin
    
    pre{
      checkin = event:attr("checkin").decode();
    }
    
    send_directive('text') with body = 'test';
    
    always {
      set ent:checkin checkin;
    }
  }
  
  rule display_checkin {
    select when web cloudAppSelected
    
    pre{
      x = ent:checkin;
    }
    notify(x, "");
    
  }
}
