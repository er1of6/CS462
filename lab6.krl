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
        
            map = ent:map;
            mapString = map.as("str");
            my_html = <<
            <h5>Hello, world!</h5>
            Value: #{ent:v} </br>
            Key: #{ent:k} </br>
            mapString
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
       
            notify("message1", " ") with sticky = true;
        }
  }   
    

  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        map = ent:m;
        key = event:attr("key");
        value = event:attr("value");
        updateMap = map.put([key], value);
    }
    
    always{
        set ent:k key;
        set ent:v value;
        set ent:m updateMap;
    }
    
    }
}

//     CloudRain:createLoadPanel("Hello World!", {}, my_html);
