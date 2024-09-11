global with sharing class CalculateTotalLeadRevenueBatch implements Database.Batchable<SObject>, Database.Stateful {
    Decimal totalLeadRevenue = 0.0;
    //Fetch the records in batches
    global Database.QueryLocator start(Database.BatchableContext bContext){
        string leadsQuery = 'SELECT Id, FirstName, LastName, annualRevenue FROM Lead WHERE annualRevenue != null';
        return Database.getQueryLocator(leadsQuery);
    }

    //perform business logic on records
    global void execute(Database.BatchableContext bContext, List<SObject> recordsToProcess){
        if(!recordsToProcess.isEmpty()){
            for(SObject sobj : recordsToProcess){
                Lead ldRecord = (Lead) sobj;
                totalLeadRevenue += ldRecord.annualRevenue;
            }
        }
    }

    global void finish(Database.BatchableContext bContext){
        AsyncApexJob jobDetails = [SELECT Id, status, totalJobItems, jobItemsProcessed, numberOfErrors, createdBy.Email FROM AsyncApexJob WHERE Id =: bContext.getJobId()];
        
        MessagingUtility.sendBatchJobStatusDetails(jobDetails, 'CalculateTotalLeadRevenueBatch', totalLeadRevenue);//Invoke the email class
    }

}