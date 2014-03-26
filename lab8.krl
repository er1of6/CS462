ruleset b505207x9 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
  rule location_show is active {
        select when web cloudAppSelected
        pre {
        
        my_html = <<
          <h2> latest checkin location: </h2> </br>
            lat: #{ent:lat} </br>
            lng: #{ent:lng} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
    rule thing is active {
        select when notification location
        pre {
        
        lat = event:attr("lat");
        lng = event:attr("lng");
      
      }
      
      send_directive('location') with nofication = 'success';
      
       always{
        set ent:lat lat;
        set ent:lng lng;
      
        }
  }  
  
}

