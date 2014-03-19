ruleset b505207x8 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
        
        
         key twilio {"account_sid" : "ACb2e87aa20dca2f309b0fb2b02f1e892f",
                    "auth_token"  : "86fefe3b6339b70d97a62408508484fd"
        }
         
        use module a8x115 alias twilio with twiliokeys = keys:twilio()
    }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        
        pre{
             my_html = <<
            <h5>Hello, world!</h5>
            event: #{ent:name} </br>
            dr: #{ent:dr} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
  rule nearby is active {
    select when explicit nearby
    
    pre{
        
       
    }
    
    twilio:send_sms("5037268034", "3852452538", "distance: " + event:attr("dr"));
    always{
     
    set ent:name "nearby";
    set ent:dr event:attr("dr");
    }
  
  }
  
  rule faraway is active {
    select when explicit faraway
    
      pre{
     //   dr = event:attr("dr");
    }
     always{
    set ent:name "faraway";
    set ent:dr event:attr("dr");
    }
    
  }
  
    rule ename is active {
    select when explicit ename
    
      pre{
     //   dr = event:attr("dr");
    }
     always{
    set ent:name "ename";
    set ent:dr event:attr("dr");
    }
    
  }
  
   
  
}
