//
//  LocalNotificationManager.h
//  AddressBook
//
//  Created by SCS2 on 20/06/15.
//  Copyright (c) 2015 Quix Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LocalNotificationManager : NSObject

@property (strong, nonatomic) UILocalNotification *notification;;


+ (LocalNotificationManager *)sharedNotificationManager;
- (void)setAllEventForNotification;
- (void)eventNotificationAlert:(UILocalNotification *)notifi;

@end
