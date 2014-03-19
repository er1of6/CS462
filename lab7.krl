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
            lat2: #{ent:lat} </br>
            lng2: #{ent:lng} </br>
            hit: #{ent:hit} </br>
            fslat: #{ent:fslat} </br>
            fslng: #{ent:fslng} </br>
            dr: #{ent:dR} </br>
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
    rule thing is active {
        select when theCurrent theLocation
        pre {
        r = location_data:getValue('fs_checkin2');
        fslat = r.pick("$..lat");
        fslng = r.pick("$..lng");
        lat = event:attr("lat");
        lng = event:attr("lng");
        
       
        rlat = math:deg2rad(lat);
        rlng = math:deg2rad(lng);
        rfslat = math:deg2rad(fslat);
        rfslng = math:deg2rad(fslng);
        
        r90   = math:pi()/2;
        rEk   = 6378; 
        
        dR = math:great_circle_distance(rlng,r90 - rlat, rfslng,r90 - rfslat);
        
        
      }
      
      send_directive('hit') with key = 'success';
      
       always{
        set ent:lat lat;
        set ent:lng lng;
        set ent:hit "hit";
        set ent:fslat fslat;
        set ent:fslng fslng;
        set ent:dr dR;
       
       }
  }  
  
  
  
}
