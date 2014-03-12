ruleset b505207x5 {
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
    }
    
   always{
         set ent:venue venue;
         set ent:city city;
         set ent:shout shout;
         set ent:createdAt createdAt;
    }
   
  }
  
  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        key = event:attr("key");
        value = event:attr("value");
    }
    
    notify(key.as("str"), value.as("str"));
    
    }
  
}
