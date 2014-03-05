ruleset lab5 {
  rule process_fs_checkin{
    select when foursquare checkin
    pre{
      checkin = event:attr("checkin").decode();
      x = "hello"
    }
    
    always {
      set ent:checkin checkin;
      set ent:hello x;
    }
  }
  
  rule display_checkin {
    select when pageview re#.*#
    pre {
      x = ent:hello;
    }
    
    notify(x, "");
  }
}
