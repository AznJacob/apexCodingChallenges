trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    switch on Trigger.operationType{
        when BEFORE_INSERT{
            
        }
        when BEFORE_UPDATE{
            
        }
        when BEFORE_DELETE{
            //AccountHelper.stopDeleteForAccountsWithContacts(Trigger.old);
        }
        when AFTER_INSERT{
            //AccountHelper.createRelatedContact(Trigger.new);
        }
        when AFTER_UPDATE{
            
        }
        when AFTER_DELETE{
            
        }
        when AFTER_UNDELETE{
            
        }
    }
}