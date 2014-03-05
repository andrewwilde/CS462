ruleset lab5 {
  rule process_fs_checkin{
    select when foursquare checkin
    pre{
      checkin = event:attr("checkin").decode();
      x = "hello";
    }
    
    {
      set ent:checkin checkin;
      send_directive('text') with body = 'test';
    }
  }
  
  rule display_checkin {
    select when pageview re#.*#
    pre {
      x = ent:checkin;
    }
    
    notify(x, "");
  }
}
