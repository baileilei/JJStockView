//
//  LocalNotificationManager.h
//  AddressBook
//
//  Created by SCS2 on 20/06/15.
//  Copyright (c) 2015 Quix Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYStockModel.h"

@interface LocalNotificationManager : NSObject

@property (strong, nonatomic) UILocalNotification *notification;;
//[self p_testLoaclNotification:[stockModel.bond_nm stringByAppendingFormat:@"涨幅大于5"]]
//条件：   回调10的时候。从最高价
-(void)Tool_testLoaclNotification:(NSString *)noteName;

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

+ (void)addLocalNotification:(NSString *)dmData withModel:(YYStockModel *)model;

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
