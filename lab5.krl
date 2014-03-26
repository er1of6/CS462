ruleset b505207x4 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
    global{
        subscription_map = {
        "cid+1": "A32C6A60-B4A3-11E3-8EC9-4781AD931101",
        "cid+2": "E8298580-B4A3-11E3-A180-1DF8283232C8"
        };
    }
    
    rule MyDispatcherRuleThing is active {
        select when explicit new_location_data
        foreach subscription_map setting (n,v)
        pre{
            value = event:attr("value");
            lat = value.pick("$..lat");
            lng = value.pick("$..lng");
            count = ent:count;
        }
        
        every{
        
        event:send(subscription_map, "notification", "location")
            with attrs = {"lat": lat, "lng" : lng}
              and cid_key = n
        }
        
        always{
            set ent:count 2;
        }
        
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
            lat: #{ent:lat} </br>
            lng: #{ent:lng} </br>
            count: #{ent:count} </br>
            otherCount: #{ent:otherCount}
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
        thing = r.as("str");
        lat = r.pick("$..lat");
        lng = r.pick("$..lng");
        innards = {'venue' : venue, 'city' : city, 'shout' : shout, 'createdAt' : createdAt, 'lat' : lat, 'lng' : lng};
    }
    
    send_directive(venue) with key = 'checkin' and value = venue;
    
   always{
         set ent:venue venue;
         set ent:city city;
         set ent:shout shout;
         set ent:createdAt createdAt;
         set ent:lat lat;
         set ent:lng lng;
         set ent:r thing;
         set ent:otherCount 9;
         
          raise explicit event new_location_data 
                with key = 'fs_checkin2'
                and value = innards;
    }
   
  }
  
}
