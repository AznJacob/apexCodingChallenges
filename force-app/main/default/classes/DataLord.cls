public with sharing class DataLord {
    public DataLord() {

    }
    
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
        List<Opportunity> opportunities = [SELECT Name FROM Opportunity WHERE Amount > 100000 ORDER BY CloseDate DESC NULLS LAST LIMIT 1];
        Opportunity bigOpportunity = opportunities[0];
        return bigOpportunity;
    }

    //Challenge VI
    public static List<Contact> majorPlayers(){
        return [SELECT Name FROM Contact WHERE Account.Rating = 'Hot'];
    }

    //Challenge VII
    public static List<AggregateResult> mostPopularAccount(){
        return [SELECT Account.Name, COUNT(Id) FROM Contact GROUP BY Account.Name ORDER BY COUNT(Id) DESC NULLS LAST LIMIT 1];
    }

    //Elite Challenge
    public static List<AggregateResult> closeLeadSources (){
        return [SELECT LeadSource, Count(Id) FROM Lead WHERE Rating ='Hot' AND LeadSource != null GROUP BY LeadSource ORDER BY Count(Id) DESC NULLS LAST LIMIT 5];
    }
}