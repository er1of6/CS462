ruleset b505207x4 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
    rule first_rule {
        select when web pageview
      
       pre {
            my_html = <<
            <h5>Hello, world!</h5>
            #{ent:fsquarePush}
            >>;
        }
        {
          
            notify("Hello World!", my_html);
        }
       
    }
    rule HelloWorld is active {
        select when web cloudAppSelected
        pre {
            my_html = <<
            <h5>Hello, world!</h5>
            #{ent:fsquarePush}
            #{ent:innards} </br>
            #{ent:venue}
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }
  rule process_fs_checkin {
    select when foursquare checkin
    pre{
        json_file = event:attr("checkin").decode();
        venue = r.pick("$..address");
        
        //venue name, city, shout, and createdAt
      
    }
    
   always{
         set ent:fsquarePush true;
         set ent:innards json_file.as("str");
         set ent:venue venue;
    }
   
  }
  
}




//Write a rule called process_fs_checkin that listens for the foursquare:checkin event. 
//The rule should store the venue name, city, shout, and createdAt event attributes in entity variables. 
//Write a rule called display_checkin that shows the results in SquareTag.
//You will need to register the ruleset and install it in your SquareTag account. 

