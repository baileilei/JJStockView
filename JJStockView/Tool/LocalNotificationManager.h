//
//  LocalNotificationManager.h
//  AddressBook
//
//  Created by SCS2 on 20/06/15.
//  Copyright (c) 2015 Quix Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "yy"

@interface LocalNotificationManager : NSObject

@property (strong, nonatomic) UILocalNotification *notification;;


+ (LocalNotificationManager *)sharedNotificationManager;
- (void)setAllEventForNotification;
- (void)eventNotificationAlert:(UILocalNotification *)notifi;

/**
 *  添加一个本地通知
 *
 *  @param dmData MMHDrinkWaterDMData
 */
+ (void)addLocalNotification:(NSString *)dmData;

+ (void)addLocalNotification:(NSString *)dmData withName:(NSString *)name;

/**
 *  取消一个本地通知
 *
 *  @param dmData MMHDrinkWaterDMData
 */
+ (void)cancelLocalNotification:(NSString *)dmData;

/**
 *  取消所有的本地通知
 */
+ (void)cancelAllLocalNotifications;

@end
