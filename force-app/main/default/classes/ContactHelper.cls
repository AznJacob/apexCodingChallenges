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
            if(con.Phone != null)
             accountPhoneMap.put(con.AccountId, con.Phone);
        }

        List<Account> accList = [Select Id FROM Account WHERE Id IN :accountPhoneMap.keySet()];

        for(Account acc: accList){
            acc.Phone = accountPhoneMap.get(acc.Id);          
        }

        Database.update(accList);
    }
}