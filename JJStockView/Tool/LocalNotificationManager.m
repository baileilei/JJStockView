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

/** 喝水提醒本地通知的category Key */
NSString * const kDrinkWaterLocalNotificationCategory = @"kDrinkWaterLocalNotificationCategory";
/** 喝水提醒通知的 alertBody Key */
NSString * const kDrinkWaterAlertBody = @"小喵提醒：主人记得喝水哟！";

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

+(void)addLocalNotification:(NSString *)dmData withModel:(YYStockModel *)model{
    //    if (NO == dmData.isTurnOn) return;
    // 如果有相同的通知，则直接 return
    if ([self hasSameLocalNotification:dmData]) return;
    
    UILocalNotification *localNotification = [UILocalNotification new];
    if (localNotification == nil) return;
    
    // 通知的类型
    localNotification.category = kDrinkWaterLocalNotificationCategory;
    
    // 设置本地通知的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone defaultTimeZone];
    // HH是24进制，hh是12进制
    //    formatter.dateFormat = @"HH:mm:ss"; //yyyy-MM-dd HH:mm
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:[dmData stringByAppendingString:@":00"]];
    NSLog(@"date: %@", date);
    // 设置本地通知的触发时间
    localNotification.fireDate = date;
    
    // 设置通知的内容
    localNotification.alertBody = [NSString stringWithFormat:@"%@ %@",model.bond_nm,model.convert_price];
    
    // 设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    // 设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    localNotification.userInfo = @{@"noteTime":dmData};
    
    // 重复触发的类型
    localNotification.repeatInterval = kCFCalendarUnitDay;
    
    // 在规定的时间触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

+(void)addLocalNotification:(NSString *)dmData withName:(NSString *)name{
   
    //    if (NO == dmData.isTurnOn) return;
    // 如果有相同的通知，则直接 return
    if ([self hasSameLocalNotification:dmData]) return;
    
    UILocalNotification *localNotification = [UILocalNotification new];
    if (localNotification == nil) return;
    
    // 通知的类型
    localNotification.category = kDrinkWaterLocalNotificationCategory;
    
    // 设置本地通知的时区
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone defaultTimeZone];
    // HH是24进制，hh是12进制
    //    formatter.dateFormat = @"HH:mm:ss"; //yyyy-MM-dd HH:mm
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:[dmData stringByAppendingString:@":00"]];
    NSLog(@"date: %@", date);
    // 设置本地通知的触发时间
    localNotification.fireDate = date;
    
    // 设置通知的内容
    localNotification.alertBody = name;
    
    // 设置提醒的声音，可以自己添加声音文件，这里设置为默认提示声
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    // 设置通知的相关信息，这个很重要，可以添加一些标记性内容，方便以后区分和获取通知的信息
    localNotification.userInfo = @{@"noteTime":dmData};
    
    // 重复触发的类型
    localNotification.repeatInterval = kCFCalendarUnitDay;
    
    // 在规定的时间触发通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

#pragma mark 添加一个本地通知
+ (void)addLocalNotification:(NSString *)dmData
{
    [self addLocalNotification:dmData withName:nil];
}

#pragma mark 取消一个本地通知
+ (void)cancelLocalNotification:(NSString *)dmData
{
    UILocalNotification *localNotification = [self hasSameLocalNotification:dmData];
    if (localNotification)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
    }
}

#pragma mark 取消所有的本地通知
+ (void)cancelAllLocalNotifications
{
    NSArray<UILocalNotification *> *notifyArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"通知的个数: %zd", notifyArray.count);
    
    [notifyArray enumerateObjectsUsingBlock:^(UILocalNotification * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.category &&
            [obj.category isEqualToString:kDrinkWaterLocalNotificationCategory])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
            NSLog(@"%zd", idx);
        }
    }];
}

#pragma mark 检查本地是否有相同的通知
+ (UILocalNotification *)hasSameLocalNotification:(NSString *)dmData
{
    NSArray<UILocalNotification *> *notifyArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification * obj in notifyArray)
    {
        if (obj.category &&
            [obj.category isEqualToString:kDrinkWaterLocalNotificationCategory])
        {
//            MMHDrinkWaterDMData *tmp_dmData = [MMHDrinkWaterDMData yy_modelWithDictionary:obj.userInfo];
            if ([dmData isEqualToString:obj.userInfo[@"noteTime"]])
            {
                return obj;
            }
        }
    }
    
    return nil;
}


@end
