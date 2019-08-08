//
//  YYDateUtil.h
//  JJStockView
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDateUtil : NSObject

+(BOOL)compareDate:(NSString *)date;

+(BOOL)toCurrentLessThan8Days:(NSString *)dateStr;

+ (NSString *)dateToString:(NSDate *)date
                andFormate:(NSString *)formate;

+ (NSDate *)stringToDate:(NSString *)dateString
              dateFormat:(NSString *)dateFormat;

+ (NSString *)suffixDateStringFromDate:(NSDate *)DateLocal
                            dateFormat:(NSString *)dateFormat;

+ (NSString *)getLocalizedStringFromDate:(NSDate *)date
                                 formate:(NSString *)formate;


//1-3   5-6
+ (NSInteger)ageFromBirthday:(NSDate *)birthdate;

@end
