//
//  UIViewController+Swizzle.m
//  SampleApp
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Quix Creations. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "JRSwizzle.h"

@implementation UIViewController (Swizzle)

+(void)load{
    NSError *error = nil;
    
    [self jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(YYViewWillAppear:) error:&error];
}

-(void)YYViewWillAppear:(BOOL)animated{
    [self YYViewWillAppear:animated];
    NSLog(@"[当前视图控制器]:%@",self);
}

@end
