//
//  YYRedeemModel.m
//  JJStockView
//
//  Created by smart-wift on 2019/8/5.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYRedeemModel.h"
#import "XMGSqliteModelTool.h"

@implementation YYRedeemModel

+(NSString *)primaryKey{
    return @"bond_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}

@end
