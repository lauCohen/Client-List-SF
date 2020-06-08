@RestResource(urlMapping='/clientList')
global with sharing class WS_clientList { 
    public class MyException extends Exception{}
    
    @HttpPost
    global static void addClientList() {
        RestRequest request = RestContext.request; 
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type','application/json');
        ModuleAppTest17__Client_List__c  clientList = new ModuleAppTest17__Client_List__c ();
        insert clientList;
        Map<String,Object> body = new Map<String,Object>();
        try{
            if (request.requestBody.toString() != '') {
                body = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
                if(isValid(body)){
                    clientList.ModuleAppTest17__Name__c = String.ValueOf(body.get('name'));
                    clientList.ModuleAppTest17__Description__c = String.ValueOf(body.get('description'));
                    clientList.ModuleAppTest17__Image_url__c = String.ValueOf(body.get('image url'));
                    update clientList;
                	res.statusCode = 200;
                	res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'success' => String.valueOf(clientList.id)}));
                }
                else{
                    throw new MyException ();
                } 
            } 
            else{
                throw new MyException ();
            }
        }  
        catch(Exception e){
            res.statusCode = 400;
            res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'failed' => String.valueOf(clientList.id)}));
        } 
    } 
    
    public static Boolean isValid(Map<String,object>body){
        Boolean isValid = true;
        for(String fieldName : body.keySet()){
            if((String.ValueOf(body.get(fieldName)) == '' || String.ValueOf(body.get(fieldName)) == null ||
               !(body.get(fieldName) instanceOf String))
               || (fieldName != 'name' && fieldName != 'description' && fieldName !='image url')){
                isValid =false;
               }
        }
        if(isValid == false)
            return false;
        else
            return true;
    }
}
