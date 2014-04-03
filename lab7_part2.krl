ruleset lab7_part2{
  
  meta {
         
        key twilio {"account_sid" : "ACf527d62bb7af49b277e996b6c55bad9d",
                    "auth_token"  : "2ebfac2a96e24120658d58cbd0f224b1"
        }
         
        use module a8x115 alias twilio with twiliokeys = keys:twilio()
        
  } 
  
  
  rule nearby_event{
    select when pds location_nearby
    
    pre {
      distance = event:attr("value");
    }
    
    {
   
      send_directive('nearby_event') with body = "Texting";
      twilio:send_sms("(801) 900-7588", "(385) 219-4420", distance);
    }  
    
    always {
      set ent:distance distance;
    }
  }
  
  rule test{
    select when pageview ".*"
    
    pre{
      distance = ent:distance;
    }
    
    notify("Distance", distance);
  }
}
