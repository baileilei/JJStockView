//
//  YYSingleBondModel.m
//  JJStockView
//
//  Created by smart-wift on 2019/9/30.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYSingleBondModel.h"

@implementation YYSingleBondModel
+(NSString *)primaryKey{
    return @"last_chg_dt";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
