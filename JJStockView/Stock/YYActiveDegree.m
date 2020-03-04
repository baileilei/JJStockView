//
//  YYActiveDegree.m
//  JJStockView
//
//  Created by smart-wift on 2020/1/2.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import "YYActiveDegree.h"

@implementation YYActiveDegree

+(NSString *)primaryKey{
    return @"stock_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}


@end
/*
 1579.89    11109.57    111.916    sz002728-2020-01-02    128025     捡漏，但是未出手！！！
 8856.79    19671.75    116.610    sz002203-2020-01-02    128081
 7458.54    23564.59    118.500    sz002728-2020-01-03    128025      捡漏，但是未出手！！！
 5471.50    5965.32    116.450    sz002203-2020-01-03    128081        未到转股期，  之后必然会回调  应该是在派发中
 
 */
