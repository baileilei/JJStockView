//
//  UIButton+Swizzle.m
//  SampleApp
//
//  Created by godot on 2019/2/25.
//  Copyright © 2019年 Quix Creations. All rights reserved.
//

#import "UIButton+Swizzle.h"
#import "JRSwizzle.h"

@implementation UIButton (Swizzle)
+(void)load{
    NSError *error = nil;
    [self jr_swizzleMethod:@selector(addTarget:action:forControlEvents:) withMethod:@selector(YYaddTarget:action:forControlEvents:) error:&error];
    if (error) {
        NSLog(@"swizzle error : %@",error);
    }
}

-(void)YYaddTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self YYaddTarget:target action:action forControlEvents:controlEvents];
    
//#define VC_DEBUG

#ifdef VC_DEBUG
//    NSLog(@"%@ calls-- %s",target,action);
    
#endif
}
@end
