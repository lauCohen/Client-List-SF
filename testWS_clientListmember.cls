@IsTest
public class testWS_clientListmember  {
    @isTest static void testCreateClientListMember() {
        // Set up a test request 
        Id recordIdClientList = createTestClientList();
        Id recordIdAccount = createTestAccount();
        RestRequest request = new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='https://resourceful-fox-5cfioq-dev-ed.my.salesforce.com/services/apexrest/ModuleAppTest17/client-list/'+recordIdClientList+'/member/';
        request.httpMethod = 'POST';
        RestContext.request = request;
        request.requestBody = Blob.valueOf('{"accountId":"'+recordIdAccount+'"}');
        RestContext.request = request; 
        RestContext.response = res;
        WS_clientListMember.addClientListMember();
    }
    @isTest static void testUpdateAccount() {
        // Set up a test request 
        Account accTest = new Account(Name = 'Test record');
        insert accTest;
        
        ModuleAppTest17__Client_List__c clientListTest = new ModuleAppTest17__Client_List__c(
            ModuleAppTest17__Name__c = 'Test record',
            ModuleAppTest17__Description__c = 'test',
            ModuleAppTest17__Image_url__c = 'www.test.com');
        insert clientListTest; 
        
        ModuleAppTest17__Client_list_member__c clientListMember = new ModuleAppTest17__Client_list_member__c(
            ModuleAppTest17__Account__c = accTest.id,
            ModuleAppTest17__Client_List__c = clientListTest.id);
        insert clientListMember;
        
        RestRequest request=new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='https://resourceful-fox-5cfioq-dev-ed.my.salesforce.com/services/apexrest/ModuleAppTest17/client-list/'+clientListTest.id+'/member/'+clientListMember.id;
        request.httpMethod = 'PUT';
        request.requestBody = Blob.valueOf('{"name":"test","Phone":"0878675645","NumberOfEmployees":"'+1000+'","AnnualRevenue":"'+350000000+'","ModuleAppTest17__SLAExpirationDate__c":"'+Date.newInstance(2018,04,04)+'"}');
        RestContext.request = request; 
        RestContext.response = res;

        WS_clientListMember.updateAccount();
    }
    static Id createTestClientList() {
        // Create test record
        ModuleAppTest17__Client_List__c clientListTest = new ModuleAppTest17__Client_List__c(
            ModuleAppTest17__Name__c ='Test record',
            ModuleAppTest17__Description__c ='test',
            ModuleAppTest17__Image_url__c = 'www.test.com');
        insert clientListTest;
        return clientListTest.id;
    }
    static Id createTestAccount() {
        // Create test record
        Account accTest = new Account(
            Name='Test record');
        insert accTest;
        return accTest.id;
    }   
}