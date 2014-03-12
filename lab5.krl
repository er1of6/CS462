ruleset b505207x4 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }

    rule HelloWorld is active {
        select when web cloudAppSelected
        pre {
            my_html = <<
            <h5>Hello, world!</h5>
            Venue: #{ent:venue} </br>
            City: #{ent:city} </br>
            shout: #{ent:shout} </br>
            createdAt: #{ent:createdAt} </br>
            r: #{ent:r} 
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
        r = event:attr("checkin").decode();
        venue = r.pick("$.venue.name");
        city = r.pick("$..city");
        shout = r.pick("$..shout");
        createdAt = r.pick("$..createdAt");
        r = r.as("str");
    }
    
   always{
         set ent:venue venue;
         set ent:city city;
         set ent:shout shout;
         set ent:createdAt createdAt;
         set ent:r r;
         
          raise explicit event new_location_data for b505207x5
                with key = "fs_checkin"
                and value = "do something";
    }
   
  }
  
}




//Write a rule called process_fs_checkin that listens for the foursquare:checkin event. 
//The rule should store the venue name, city, shout, and createdAt event attributes in entity variables. 
//Write a rule called display_checkin that shows the results in SquareTag.
//You will need to register the ruleset and install it in your SquareTag account. 

