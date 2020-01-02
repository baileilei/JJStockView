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
