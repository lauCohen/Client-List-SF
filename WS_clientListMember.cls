@RestResource(urlMapping='/client-list/*/member/*')
global with sharing class WS_clientListMember {
    public class MyException extends Exception{}
    @HttpPost
    global static void addClientListMember() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type','application/json'); 
        Map<String,Object> body = new Map<String,Object>();
        String clientListId = request.requestURI.substringBetween('client-list/','/member');
        List<ModuleAppTest17__Client_list_member__c> clientListMemberList = new List<ModuleAppTest17__Client_list_member__c>();
        ModuleAppTest17__Client_list_member__c clientListMember = new ModuleAppTest17__Client_list_member__c();
        
        try{
            //check that the body if not null
            if (request.requestBody.toString() != '') {
                body = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
                //check that field accountId is Valid 
                if(String.ValueOf(body.get('accountId')) != '' && String.ValueOf(body.get('accountId')) != null && body.get('accountId') instanceOf String){
                    clientListMemberList=[SELECT Id,ModuleAppTest17__Account__c,ModuleAppTest17__Client_List__c FROM ModuleAppTest17__Client_list_member__c WHERE ModuleAppTest17__Account__c =:String.ValueOf(body.get('accountId'))
                                          AND ModuleAppTest17__Client_List__c =:clientListId];
                    if(clientListMemberList.size() == 0){
                        //check if accountId exist Database
                        List<Account> accList =[SELECT Id FROM Account WHERE Id =:String.ValueOf(body.get('accountId'))];
                        if(accList.size()>0){
                            clientListMember.ModuleAppTest17__Account__c = String.ValueOf(body.get('accountId'));
                            clientListMember.ModuleAppTest17__Client_List__c = clientListId;
                            insert clientListMember;
                            res.statusCode = 200;
                            res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'success' => String.valueOf(clientListMember.id)}));  
                        }
                        else{
                            throw new MyException ();
                        }
                    }
                    //no insertion clientListMember already exist 
                    else{
                        res.statusCode = 200;
                        res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'success,client list member already exist' => String.valueOf(clientListMemberList[0].id)})); 
                    } 
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
            clientListMember.ModuleAppTest17__Client_List__c = clientListId;
            insert clientListMember;
            res.statusCode = 400;
            res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'failed' => String.valueOf(clientListMember.id)}));
        }
    }
    
    @HttpPut
    global static void updateAccount() {
        RestRequest request = RestContext.request;
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type','application/json');
        String clientListMemberId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        ModuleAppTest17__Client_list_member__c clientListMember= [SELECT Id,ModuleAppTest17__Account__c FROM ModuleAppTest17__Client_list_member__c WHERE Id = :clientListMemberId];
        Account acc = new Account();
        try{
            //check that the body if not null
            if (request.requestBody.toString() != '') {
                // Deserialize the JSON string into name-value pairs
                Map<String, Object> body = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.tostring());
                // get the type of values in Account 
                Schema.SObjectType targetType = Schema.getGlobalDescribe().get('Account');
                Map<String, Schema.sObjectField> targetFields = targetType.getDescribe().fields.getMap();
                acc.id=clientListMember.ModuleAppTest17__Account__c;
                // Iterate through each parameter field and value and check input parameter
                for(String fieldName : body.keySet()) {
                    Object value = body.get(fieldName);
                    Schema.DisplayType valueType = targetFields.get(fieldName).getDescribe().getType();
                    if (value instanceof String && valueType != Schema.DisplayType.String){
                        String svalue = (String)value;
                        if (valueType == Schema.DisplayType.Date)
                            acc.put(fieldName, Date.valueOf(svalue));
                        else if(valueType == Schema.DisplayType.DateTime)
                            acc.put(fieldName, DateTime.valueOfGmt(svalue));
                        else if (valueType == Schema.DisplayType.Percent || valueType == Schema.DisplayType.Currency)
                            acc.put(fieldName, svalue == '' ? null : Decimal.valueOf(svalue));
                        else if (valueType == Schema.DisplayType.Double)
                            acc.put(fieldName, svalue == '' ? null : Double.valueOf(svalue));
                        else if (valueType == Schema.DisplayType.Integer)
                            acc.put(fieldName, Integer.valueOf(svalue));
                        else if (valueType == Schema.DisplayType.Base64)
                            acc.put(fieldName, Blob.valueOf(svalue));
                        else
                            acc.put(fieldName, svalue);
                    }
                    else
                        acc.put(fieldName, value);  
                }
                update acc;
                res.statusCode = 200;
                res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'success' => String.valueOf(clientListMemberId)}));                
            }
            else{
                throw new MyException ();
            }
        }
        catch(Exception e){
            res.statusCode = 400;
            res.responseBody =  Blob.valueOf(JSON.serialize(new Map<String, String>{'failed' => String.valueOf(clientListMemberId)}));
        }   
    } 
}