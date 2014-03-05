ruleset foursquare {

  rule process_fs_checkin{
    select when foursquare checkin
    
    pre {
      data = event.attr("checkin").decode();
    }
    notify(data, "") with sticky = true;
  }
  
  rule display_checkin{
  
  }
}
