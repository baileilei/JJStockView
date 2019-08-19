//
//  YYBuyintoStockModel.m
//  JJStockView
//
//  Created by g on 2019/2/24.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYBuyintoStockModel.h"

@implementation YYBuyintoStockModel

+(NSString *)primaryKey{
    return @"bond_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}

@end
