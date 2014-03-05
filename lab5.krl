ruleset foursquare {

  rule process_fs_checkin{
    select when foursquare checkin
    
    pre {
      data = event.attr("checkin").decode();
    }
    notify("hello", "everyone") with stick = true;
  }
  
  rule display_checkin{
  
  }
}
