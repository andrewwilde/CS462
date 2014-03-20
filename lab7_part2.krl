ruleset lab7_part2{
  
  meta {
         
        key twilio {"account_sid" : "ACf527d62bb7af49b277e996b6c55bad9d",
                    "auth_token"  : "2ebfac2a96e24120658d58cbd0f224b1"
        }
         
        use module a8x115 alias twilio with twiliokeys = keys:twilio()
        
  } 
  
  
  rule nearby_event{
    select when location_nearby
    
    twilio:send_sms(event:attr("8013102683"), event:attr("3852194420"), "Location " + distance + "kilometers away");
    
  }
}
