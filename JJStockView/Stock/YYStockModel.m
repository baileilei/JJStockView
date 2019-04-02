//
//  YYStockModel.m
//  HandleStockJson
//
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 pactera. All rights reserved.
//

#import "YYStockModel.h"
#import "XMGSqliteModelTool.h"

@implementation YYStockModel

+(NSString *)primaryKey{
    return @"bond_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}

//-(void)setRatio:(NSString *)ratio{
//    
//    _ratio = [NSString stringWithFormat:@"%.2f",(self.full_price.floatValue - self.convert_value.floatValue)/self.convert_value.floatValue];;
//    
////    [XMGSqliteModelTool saveOrUpdateModel:<#(id)#> uid:<#(NSString *)#>];
//}
@end
