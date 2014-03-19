ruleset b505207x8 {
    meta {
        name "notify example"
        author "nathan cerny"
        logging off
        use module a169x701 alias CloudRain
        use module a41x186  alias SquareTag
    }
    
  rule show_fs_location is active {
        select when web cloudAppSelected
        pre {
        
            
        }
        {
            SquareTag:inject_styling();
            CloudRain:createLoadPanel("Hello World!", {}, my_html);
        }
  }  
  
   
  
}
