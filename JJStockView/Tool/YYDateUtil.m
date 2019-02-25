//
//  YYDateUtil.m
//  JJStockView
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import "YYDateUtil.h"

@implementation YYDateUtil

+ (NSString *)dateToString:(NSDate *)date
                andFormate:(NSString *)formate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *stringFromDate = [formatter stringFromDate:date];
    if(stringFromDate)
        return stringFromDate;
    return @"";
}

+ (NSDate *)stringToDate:(NSString *)dateString
              dateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    NSDate *dateFromString = nil;
    dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}

+ (NSString *)suffixDateStringFromDate:(NSDate *)DateLocal
                            dateFormat:(NSString *)dateFormat{
    
    // set formate this @"MMMM d., yyyy" 1st Jan 2015
    
    NSDateFormatter *prefixDateFormatter = [[NSDateFormatter alloc] init];
    [prefixDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [prefixDateFormatter setDateFormat:dateFormat];//June 13th, 2013
    NSString * prefixDateString = [prefixDateFormatter stringFromDate:DateLocal];
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:DateLocal] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    
    prefixDateString = [prefixDateString stringByReplacingOccurrencesOfString:@"." withString:suffix];
    NSString *dateString =prefixDateString;
    return dateString;
}

+ (NSString *)getLocalizedStringFromDate:(NSDate *)date formate:(NSString *)formate{
    if(date){
        NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
        [dateFormate setDateFormat:formate];
        [dateFormate setTimeZone:[NSTimeZone defaultTimeZone]];
        NSString *strDate = [dateFormate stringFromDate:date];
        if(strDate != nil){
            return [[strDate componentsSeparatedByString:@"+"] objectAtIndex:0];
        }
    }
    return @"";
}


+ (NSInteger)ageFromBirthday:(NSDate *)birthdate {
    if(birthdate){
        NSDate *today = [NSDate date];
        NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                           components:NSCalendarUnitYear
                                           fromDate:birthdate
                                           toDate:today
                                           options:0];
        return ageComponents.year;
    }
    return 0;
}

@end
