public class JobsListController {
    public List<Job_Posting__c> listOfJobs {get;set;}
     public JobsListController(ApexPages.StandardController stdController){
    

    }
   
	public List<Job_Posting__c> getActiveJobs() {
  		 listOfJobs =  [SELECT Name, Department__c, Grade__c, Job_Location__c,Job_Status__c FROM Job_Posting__c where Job_Status__c=true];
    return listOfJobs;
    }
    
    
   
}