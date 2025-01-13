public with sharing class AccountHelper {
    public AccountHelper() {

    }

    public static void stopDeleteForAccountsWithContacts(List<Account> accList){
        List<Contact> conList = [SELECT AccountId FROM Contact WHERE AccountId IN :accList];

        Set<Id> accountIds = new Set<Id>();
        for (Contact con : conList){
            accountIds.add(con.AccountId);
        }

        for(Account acc : accList){
            if(accountIds.contains(acc.Id)){
                acc.addError('Account cannot be deleted since theres an existing contact associated with it');
            }
        }
    }

    public static void createRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();

        for(Account acc : accList){
            Contact con = new Contact(LastName = 'Random' + String.valueOf((Integer)Math.floor(Math.random() * 100)));
            con.AccountId = acc.Id;
            conList.add(con);
        }

        Database.insert(conList);
    }
}