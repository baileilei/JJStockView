//
//  YYStockModel.m
//  HandleStockJson
//
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 pactera. All rights reserved.
//

#import "YYStockModel.h"

@implementation YYStockModel

+(NSString *)primaryKey{
    return @"bond_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
