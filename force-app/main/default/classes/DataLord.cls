public with sharing class DataLord {
    public DataLord() {

    }
    
    //SOQL Challenges
    //Challenge I
    public static Integer numAccounts(){
        Integer totalAccounts = [SELECT COUNT() FROM Account];
        return totalAccounts;
    }

    //Challenge II
    public static Integer numHot(){
        Integer hotAccounts = [SELECT COUNT() FROM Account WHERE Rating = 'Hot'];
        return hotAccounts;
    }

    //Challenge III
    public static Integer numComplex(){
        Integer ampAccounts = [SELECT COUNT() FROM Account WHERE Name LIKE '%&%'];
        return ampAccounts;
    }

    //Challenge IV
    public static List<Account> bigFive(){
        return [SELECT Name FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5];
    }

    //Challenge V
    public static Opportunity lastBigOpportunity(){
        return [SELECT Name FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate DESC NULLS LAST LIMIT 1];
    }

    //Challenge VI
    public static List<Contact> majorPlayers(){
        return [SELECT Name FROM Contact WHERE Account.Rating = 'Hot'];
    }

    //Challenge VII
    public static String mostPopularAccount(){
       AggregateResult aggregatedResult1 = [SELECT Account.Name, COUNT(Id) FROM Contact GROUP BY Account.Name ORDER BY COUNT(Id) DESC NULLS LAST LIMIT 1];
       return (String) aggregatedResult1.get('Name');
    }

    //Elite Challenge
    public static List<AggregateResult> closeLeadSources(){
        return [SELECT LeadSource, COUNT(Id) FROM Lead WHERE Rating ='Hot' AND LeadSource != null GROUP BY LeadSource ORDER BY COUNT(LeadSource) DESC NULLS LAST LIMIT 5];
    }

    //SOSL Challenges
    //Challenge I
    public static List<List<sObject>> tomContactsLeads(){
        return [FIND 'Tom' RETURNING Contact(Name), Lead(Name)];
    }

    //Challenge II
    public static List<sObject> aoAccounts(){
        List<List<sObject>> results = [FIND '*a* AND *o*' RETURNING Account(Name)];
        return results[0];
    }

    //Elite Challenge
    public static List<List<sObject>> phoneNames(){
        return [FIND '*1000' IN PHONE FIELDS RETURNING Account(Name), Contact(Name), Lead(Name)];
    }
}