//
//  YYShareHoldersModel.m
//  JJStockView
//
//  Created by smart-wift on 2020/3/17.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import "YYShareHoldersModel.h"

@implementation YYShareHoldersModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gdrs_List_json = [[NSMutableArray alloc] init];
        self.sdltgd_List_json = [[NSMutableArray alloc] init];
        self.jjcc_List_json = [[NSMutableArray alloc] init];
        self.zlcc_List_json = [[NSMutableArray alloc] init];
    }
    return self;
}

+(NSString *)primaryKey{
    return @"stock_id";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"ratio"]) {
        NSLog(@"没有这个key ratio");
    }
}

@end


@implementation YYGgdrsModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation YYSdltgdModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation YYJjcgModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation YYZlccModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
