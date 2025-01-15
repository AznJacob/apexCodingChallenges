/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class ContactHelperTest {
    /** 
     * TODO LIST
     * setup method 
     * positive test method
     * negative test method
     * single test method
     * multiple test method
    */

    // setup method
    @testSetup
    static void setupUnitTests(){
        Account acc = new Account(
            Name = 'Nurture'
        );

        Contact con1 = new Contact(
            LastName = 'Musician',
            Email = 'musician@nurture.com',
            AccountId = acc.Id
        );

        Contact con2 = new Contact(
            LastName = 'Unfold',
            Email = 'unfold@nurture.com',
            AccountId = acc.Id
        );

        Database.insert(acc);
        Database.insert(con1);
        Database.insert(con2);
    }

    // positive unit test
    @isTest
    static void positiveUnitTest() {

        Account acc = [SELECT Id FROM Account WHERE Name = 'Nurture' LIMIT 1];       

        Contact positiveContact = new Contact(
            LastName = 'Wish',
            Email = ' wish@nurture.com',
            AccountId = acc.Id
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(positiveContact);
        Test.stopTest();

        Assert.areEqual(sr.isSuccess(), true);
    }

    @isTest
    static void negativeUnitTest(){

        Account acc = [SELECT Id FROM Account WHERE Name = 'Nurture' LIMIT 1];   

        Contact negativeContact = new Contact(
            LastName = 'Tempos',
            Email = ' Tempos@wind.com',
            AccountId = acc.Id
        );

        Test.startTest();
        Database.SaveResult sr = Database.insert(negativeContact);
        Test.stopTest();

        Assert.areEqual(!sr.isSuccess(), false);
    }

    static void bulkPositiveUnitTest(){

        Account acc = [SELECT Id FROM Account WHERE Name = 'Nurture' LIMIT 1];       

        List<Contact> conList = new List<Contact>();

        Contact positiveContact1 = new Contact(
            LastName = 'Wish',
            Email = ' wish@nurture.com',
            AccountId = acc.Id
        );

        Contact positiveContact2 = new Contact(
            LastName = 'Alive',
            Email = ' Alive@nurture.com',
            AccountId = acc.Id
        );

        conList.add(positiveContact1);
        conList.add(positiveContact2);

        Test.startTest();
        Database.insert(conList);
        Test.stopTest();

        List<Contact> finalConList = [SELECT LastName FROM Contact WHERE Contact.AccountId = :acc.Id];

        Assert.areEqual(finalConList.size(), 2);
    }
}