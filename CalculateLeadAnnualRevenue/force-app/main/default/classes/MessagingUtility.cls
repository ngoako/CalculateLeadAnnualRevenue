public with sharing class MessagingUtility {
    public static void sendBatchJobStatusDetails(AsyncApexJob jobDetails, string jobName, Decimal totalRevenue ){
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddress = new string[]{jobDetails.createdBy.email, 'ngoakomasta@gmail.com'};
        email.setToAddresses(toAddress);
        email.setSenderDisplayName('Weekly Batch Support');
        string emailSubject = 'Alert: Weekly batch ' + jobName + ' job';
        email.setSubject(emailSubject);
        string emailContent = 'Dear Sir</br></br> Please find the batch job details</br></bd>' + 'Total lead records Annual Revenue = ' + totalRevenue;
        email.setHtmlBody(emailContent);


        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});

    }
}