ruleset b505207x6 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
        use module b505207x5 alias location_data
    }
    
  }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        pre {
        
        r = location_data:get_location_data('fs_checkin');
        venue = r.pick("$.venue.name");
        city = r.pick("$..city");
        shout = r.pick("$..shout");
        createdAt = r.pick("$..createdAt");
        r = r.as("str");
        
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
         //   replace_inner("#main", my_html);
       
       //     notify("message1", theMap.length()) with sticky = true;
        }
  }   
  
}
