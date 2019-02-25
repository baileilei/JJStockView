//
//  UIApplication+Swizzle.m
//  SampleApp
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Quix Creations. All rights reserved.
//

#import "UIApplication+Swizzle.h"
#import "JRSwizzle.h"

@implementation UIApplication (Swizzle)

+(void)load{
    NSError *error = nil;
    [self jr_swizzleMethod:@selector(sendEvent:) withMethod:@selector(YYsendEvent:) error:&error];
    if (error) {
        NSLog(@"swizzle error : %@",error);
    }
}

- (void)YYsendEvent:(UIEvent *)event{
    [self YYsendEvent:event];
//    NSLog(@"%@ %@",self,event);
}


@end
