@IsTest
public class testWS_clientList {
    @isTest static void testCreateClientList() {
        // Set up a test request 
        RestRequest request=new RestRequest();
        RestResponse res = new RestResponse();
        request.requestUri ='https://resourceful-fox-5cfioq-dev-ed.my.salesforce.com/services/apexrest/ModuleAppTest17/clientList';
        request.httpMethod = 'POST';
        RestContext.request = request;
        request.requestBody = Blob.valueOf('{"name":"test","description":"test","image url":"www.test.com"}');
        RestContext.request = request; 
        RestContext.response = res;
	    WS_clientList.addClientList();
    }     
}
