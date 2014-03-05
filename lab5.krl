ruleset lab5 {
  rule process_fs_checkin{
    select when foursquare checkin
    pre{
      checkin = event:attr("checkin").decode();
    }
    
    always {
      set ent:checkin checkin;
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
