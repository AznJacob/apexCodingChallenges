public with sharing class ClassDeliveryHelper {
    public ClassDeliveryHelper() {

    }

    public static void createClassDelivery(String className){

        if(Schema.sObjectType.Class_Delivery__c.isCreateable() || !Schema.sObjectType.Class_Delivery__c.fields.Class__c.isCreateable()){
            Class_Delivery__c cDelivery = new Class_Delivery__c(
                Name = className,
                Class__c = className
            );
            Database.insert(cDelivery);
        }

    }

    public static void deleteClassDelivery(Id classDeliveryID){

        if(Schema.sObjectType.Class_Delivery__c.isDeletable()){
            Database.delete(classDeliveryID);
        }

    }

    public static void changeClassToDotNet(Id classDeliveryID){

        Class_Delivery__c cDelivery = [SELECT Id, Class__c FROM Class_Delivery__c WHERE Id = :classDeliveryID];

        if(Schema.sObjectType.Class_Delivery__c.isUpdateable() || !Schema.sObjectType.Class_Delivery__c.fields.Class__c.isUpdateable()){
            cDelivery.Class__c = 'DotNet';
            Database.update(cDelivery);
        }
    }
}