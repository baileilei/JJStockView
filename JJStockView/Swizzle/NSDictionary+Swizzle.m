//
//  NSDictionary+Swizzle.m
//  SampleApp
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Quix Creations. All rights reserved.
//

#import "NSDictionary+Swizzle.h"
#import "JRSwizzle.h"

@implementation NSDictionary (Swizzle)

+(void)load{
    NSError *error = nil;
    
    [self jr_swizzleMethod:@selector(setValue:forKey:) withMethod:@selector(YYsetValue:forKey:) error:&error];
    
    if (error) {
        NSLog(@"swizzle error %@",error);
    }
}

-(void)YYsetValue:(id)value forKey:(NSString *)key{
    if (value == nil) {
        value = @"";
    }
    [self YYsetValue:value forKey:key];
}

@end
