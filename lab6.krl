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
        
            theMap = ent:m;
            value = theMap{ent:k};
            mapString = theMap.as("str");
            len = theMap.length();
            my_html = <<
            <h5>Hello, world!</h5>
            Value: #{ent:v} </br>
            Key: #{ent:k} </br>
            MAPSTRING: #{mapString} </br>
            THEVALUE: #{value} </br>
            LENGTH: #{len}
            >>;
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
       
            notify("message1", theMap.length()) with sticky = true;
        }
  }   
    

  rule add_location_item{
    select when explicit new_location_data
    
    pre{
        theMap = ent:m || {};
        key = event:attr("key");
        value = event:attr("value");
        thing = 'hello';
        otherMap = theMap.put([key], thing);
    }
    
    always{
        set ent:k key;
        set ent:v value;
        set ent:m otherMap;
    }
    
    }
}

//     CloudRain:createLoadPanel("Hello World!", {}, my_html);
//  thing = '"' + key + '"';
