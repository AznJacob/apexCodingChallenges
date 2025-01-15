public with sharing class ContactHelper {
    public ContactHelper() {

    }

    // Challenge II
    public static void setDefaultEmailForContacts(List<Contact> conList){
        for(Contact con : conList){
            if(con.Email == null || con.Email == ''){
                con.Email = 'PorterRobinson@default.com';
            }
        }
    }

    // Challenge IV
    public static void updateAccountPhone(List<Contact> conList){

        Map<Id, String> accountPhoneMap = new Map<Id, String>();

        for(Contact con : conList){
            if(con.Phone != null && con.AccountId != null){
                accountPhoneMap.put(con.AccountId, con.Phone);
            }               
        }

        List<Account> accList = [Select Id FROM Account WHERE Id IN :accountPhoneMap.keySet()];

        for(Account acc: accList){
            acc.Phone = accountPhoneMap.get(acc.Id);          
        }

        Database.update(accList);
    }

    // 1/3 afternoon coding challenge
    public static void stopSaveIfDifferentEmails(List<Contact> conList){
        
        //get list of account ids where there is a contact that has an email
        Set<Id> accountIds = new Set<Id>();
        for(Contact con: conList){
            if(con.Email != null && con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }

        // query for all contacts in that set account list
        List<Contact> emailContacts = [SELECT Id, AccountId, Email FROM Contact WHERE AccountId IN :accountIds];

        // create a map to map each account id to a list of associated email contacts
        Map<Id, List<String>> accountContactEmails = new Map<Id, List<String>>();        
        for(Contact con: emailContacts){
            if(accountContactEmails.get(con.AccountId)==null){
                List<String> accountEmail = new List<String>();

                accountEmail.add(con.Email.subStringAfter('@').toLowerCase());
                accountContactEmails.put(con.AccountId, accountEmail);
            }
            else{
                accountContactEmails.get(con.AccountId).add(con.Email.subStringAfter('@').toLowerCase());
            }
        }

        // loop through triggered contact list to see if it matches any email in the associated account
        for(Contact con: conList){
            if(!(accountContactEmails.get(con.AccountId).contains(con.Email.subStringAfter('@').toLowerCase()))){
                con.addError('Email domain must match ex>isting Contacts associated with the same account.');
            }
        }
    }
}