//
//  YYDateUtil.m
//  JJStockView
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import "YYDateUtil.h"

@implementation YYDateUtil

+(BOOL)compareDate:(NSDate *)date{
    
    NSDate *date0 = [self stringToDate:date dateFormat:@"yyyy-MM-dd"];
    
    return [self compareDate:date0];
}

+(BOOL)toCurrentLessThan8Days:(NSString *)dateStr{
    if (dateStr.length == 0) {
        return NO;
    }
    NSDate *currentDate = [NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *currentcomponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    
    NSInteger currentyear=[currentcomponents year];
    NSInteger currentmonth=[currentcomponents month];
    NSInteger currentday=[currentcomponents day];
    
//    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,currentyear,currentmonth,currentday);
    
    NSDate *issueDate = [self stringToDate:dateStr dateFormat:@"yyyy-MM-dd"];
    NSDateComponents *issuecomponents = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:issueDate];
    
    NSInteger issuetyear=[issuecomponents year];
    NSInteger issuemonth=[issuecomponents month];
    NSInteger issueday=[issuecomponents day];
//     NSLog(@"issueDate = %@ ,issueyear = %ld ,issuemonth=%ld, issueday=%ld",issueDate,issuetyear,issuemonth,issueday);
    if (currentyear == issuetyear && currentmonth == issuemonth && abs(currentday - issueday) < 8) {
        return YES;
    }
    
//    if (issuetyear == 2019) {
//        return YES;
//    }
    
    
    return NO;
}


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
