@RestResource(urlMapping='/Contact/*')
global with sharing class ShopifyRestResource {

    public class ApplicantsData{
        String firstName;
        String lastName;
        String phone;
        String email;
        String jobId;
    }
    @HttpPost
    global static String doPost() {
        RestRequest req = RestContext.request;
		RestResponse res = Restcontext.response;
        List<ApplicantsData> appDataList = (List<ApplicantsData>)JSON.deserialize(EncodingUtil.Base64Encode(req.requestBody), ApplicantsData.class);
        List<Contact> listCon = New List<Contact>();
        List<Application__c> listApp = new List<Application__c>();
        Map<String, String> jobData = new Map<String, String>();
        try{
          
        for(ApplicantsData candidateData: appDataList){
            Contact conObj = new Contact();
            conObj.FirstName = candidateData.firstName;
            conObj.LastName = candidateData.lastName;
            conObj.Phone = candidateData.phone;
            conObj.Email = candidateData.email;
            listCon.add(conObj);
            jobData.put(candidateData.email, candidateData.jobId);
        }            
        insert listCon;
        for(Contact con : listCon){
            Application__c objApp = new Application__c();           
            objApp.Contact__c =con.id;
            objApp.Job_Posting__c= jobData.get(con.Email);
            listApp.add(objApp);
        }
        insert listApp;   
        }catch(Exception ex){
			return ex.getMessage();
        }
        return 'SUCCESS';
    }
}