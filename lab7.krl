ruleset b505207x7 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
        use module b505207x5 alias location_data
    }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        pre {
        
        r = location_data:getValue('fs_checkin2');
        venue = r.pick("$..venue");
        city = r.pick("$..city");
        shout = r.pick("$..shout");
        createdAt = r.pick("$..createdAt");
        lat = r.pick("$..lat");
        lng = r.pick("$..lng");
        
        my_html = <<
            <h5>Hello, world!</h5>
            Venue: #{venue} </br>
            City: #{city} </br>
            shout: #{shout} </br>
            createdAt: #{createdAt} </br>
            lat: #{lat} </br>
            lng: #{lng} </br>
            lat2: #{ent:lat} </br>
            lng2: #{ent:lng} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
    rule thing is active {
        select when theLocation theCurrent
        pre {
        r = event:attr("theCurrent").decode();
        
        venue = r.pick("$..lat");
        city = r.pick("$..lng");
      
       always{
        set ent:lat lat;
        set ent:lng lng;
       
       }
  }  
  
  
  
}
