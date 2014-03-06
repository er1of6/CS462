ruleset b505207x4 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
    dispatch {
        // domain "exampley.com"
        // xnrrv5u46fcruqw642tm7v2z
    }
    global {
      
    }
    rule first_rule {
        select when web pageview
      
      notify("Hello World", "This is a sample rule.");
       
    }
    rule HelloWorld is active {
        select when web cloudAppSelected
        pre {
            my_html = <<
            <h5>Hello, world!</h5>
            #{ent:fsquarePush}
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }
  rule process_fs_checkin {
    select when foursquare checkin
    
   always{
         set ent:fsquarePush true;
    }
   
  }
  
}




//Write a rule called process_fs_checkin that listens for the foursquare:checkin event. 
//The rule should store the venue name, city, shout, and createdAt event attributes in entity variables. 
//Write a rule called display_checkin that shows the results in SquareTag.
//You will need to register the ruleset and install it in your SquareTag account. 

