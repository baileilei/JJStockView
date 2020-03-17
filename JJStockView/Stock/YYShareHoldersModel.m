//
//  YYShareHoldersModel.m
//  JJStockView
//
//  Created by smart-wift on 2020/3/17.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import "YYShareHoldersModel.h"

@implementation YYShareHoldersModel

+(NSString *)primaryKey{
    return @"stock_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}

@end


@implementation YYJjcgModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
