//
//  LocalNotificationManager.m
//  AddressBook
//
//  Created by SCS2 on 20/06/15.
//  Copyright (c) 2015 Quix Creations. All rights reserved.
//

#import "LocalNotificationManager.h"
//#import "TblCalendarEvent.h"
//#import "NSDate+Escort.h"
//#import "NSDate+FFDaysCount.h"
//#import "DbUtils.h"
//#import "CachingService.h"

@implementation LocalNotificationManager

+ (LocalNotificationManager *)sharedNotificationManager{
    static LocalNotificationManager *sharedInstance;
    @synchronized(self){
        if (sharedInstance == nil){
            sharedInstance = [[LocalNotificationManager alloc] init];
        }
    }
    return sharedInstance;
}

- (void)setAllEventForNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    NSArray *notificationArray = [DbUtils fetchAllObject:@"TblCalendarEvent"
//                                              andPredict:[NSPredicate predicateWithFormat:@"reminder != %@ AND reminderMode != %@",@"Never", @"Never"]
//                                       andSortDescriptor:[NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:TRUE]
//                                    managedObjectContext:[CachingService sharedInstance].managedObjectContext];
//    for (TblCalendarEvent *calEvent in notificationArray)
//        [self scheduleNotificationWithEvent:calEvent];
}

- (int)secondBefore:(NSString *)reminder{
    int second = 60;
    int minute = 60;
    int hour = 24;
    int day = 7;
    
    if([reminder isEqualToString:@"5 minutes before"])
        return 5 * second;
    else if([reminder isEqualToString:@"15 minutes before"])
        return 15 * second;
    else if([reminder isEqualToString:@"30 minutes before"])
        return 30 * second;
    else if([reminder isEqualToString:@"1 hour before"])
        return 1 * minute * second;
    else if([reminder isEqualToString:@"2 hour before"])
        return 2 * minute * second;
    else if([reminder isEqualToString:@"1 day before"])
        return 1 * hour * minute * second;
    else if([reminder isEqualToString:@"2 day before"])
        return 2 *hour * minute * second;
    else if([reminder isEqualToString:@"1 week before"])
        return 1 * day * hour * minute * second;
    return 0;
}

- (void)scheduleNotificationWithEvent:(id )event{
 
//    NSDate *setDate = [event.startDate dateByAddingTimeInterval:-[self secondBefore:event.reminder]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];//[calendar dateFromComponents:[setDate componentsOfDate]];
//    if([date isInFuture]){
        UILocalNotification *localNotifi = [[UILocalNotification alloc] init];
        if (localNotifi == nil)
            return;
        localNotifi.fireDate = date;
        localNotifi.timeZone = [NSTimeZone defaultTimeZone];
//        localNotifi.alertBody = [NSString stringWithFormat:@"Event name: %@ \n Description: %@",event.eventName,event.notes];
        localNotifi.alertAction = @"View";
    //    localNotif.alertTitle = NSLocalizedString(@"Item Due", nil);
        localNotifi.soundName = UILocalNotificationDefaultSoundName;
    //    localNotif.applicationIconBadgeNumber = 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotifi];
//    }
}

- (void)eventNotificationAlert:(UILocalNotification *)notifi{
    if(notifi != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event Notification"
                                                        message:notifi.alertBody
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

@end
