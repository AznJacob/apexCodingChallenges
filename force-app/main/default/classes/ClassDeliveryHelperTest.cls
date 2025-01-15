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
private class ClassDeliveryHelperTest {

    @TestSetup
    static void setupUnitTest(){

        Class_Delivery__c newClassDelivery = new Class_Delivery__C(
            Name = 'Class Delivery',
            Class__c = 'Setup'
        );   

        Database.insert(newClassDelivery);

    }

    @isTest
    static void positiveCreateClassDeliveryAsSalesUser() {

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Sales User'];

        User salesUser = new User(Alias = 'salesU', Email='sales@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = profile.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName='uniqueUserName123@username.com'
        );

        Database.insert(salesUser);

        System.runAs(salesUser) {

            Test.startTest();
            ClassDeliveryHelper.createClassDelivery('Test Class');
            Test.stopTest();

            Class_Delivery__c testClassDelivery = [SELECT Class__c FROM Class_Delivery__c WHERE Class__c = 'Test Class' LIMIT 1];

            Assert.areEqual('Test Class', testClassDelivery.Class__c);
        }
    }

    @isTest
    static void positiveCreateClassDeliveryAsSalesManager() {

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Sales User'];
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Name = 'Sales Manager'];

        User salesManager = new User(Alias = 'salesM', Email='sales@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = profile.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName='uniqueUserName123@username.com'
        );

        Database.insert(salesManager);

        PermissionSetAssignment permSetAssign = new PermissionSetAssignment(
            AssigneeId = salesManager.Id,
            PermissionSetId = permSet.Id
        );

        Database.insert(permSetAssign);

        System.runAs(salesManager) {

            Test.startTest();
            ClassDeliveryHelper.createClassDelivery('Test Class');
            Test.stopTest();

            Class_Delivery__c testClassDelivery = [SELECT Class__c FROM Class_Delivery__c WHERE Class__c = 'Test Class' LIMIT 1];

            Assert.areEqual('Test Class', testClassDelivery.Class__c);
        }
    }

    @isTest
    static void positiveDeleteClassDeliveryAsSalesUser() {

        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Sales User'];
        Id classDeliveryId = [SELECT Id FROM Class_Delivery__c WHERE Class__c = 'Setup' LIMIT 1].Id;

        User salesUser = new User(Alias = 'salesU', Email='sales@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = profile.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName='uniqueUserName123@username.com'
        );

        Database.insert(salesUser);

        System.runAs(salesUser) {

            Test.startTest();
            ClassDeliveryHelper.deleteClassDelivery(classDeliveryId);
            Test.stopTest();


            Class_Delivery__c testClassDelivery = [SELECT Class__c FROM Class_Delivery__c WHERE Class__c = 'Setup' LIMIT 1];


            Assert.areEqual(null, testClassDelivery);
        }

    }
}