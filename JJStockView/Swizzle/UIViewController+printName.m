//
//  UIViewController+printName.m
//  JJStockView
//
//  Created by smart-wift on 2019/8/6.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "UIViewController+printName.h"
#import <objc/runtime.h>
#define SHOW_VC_NAME 1//可以打开或关闭VC名字的提示 方便查找控制器


@implementation UIViewController (printName)

+ (void)load
{
#if SHOW_VC_NAME
    Method nMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method oldMethod = class_getInstanceMethod([self class], @selector(printVcName));
    method_exchangeImplementations(nMethod, oldMethod);
#endif
}

- (void)printVcName
{
    NSString * vcString = NSStringFromClass([self class]);
    NSLog(@"当前控制器-->%@",vcString);
    //自动隐藏底部tabbar
    self.hidesBottomBarWhenPushed = (self.navigationController.childViewControllers.count >= 2);
    [self printVcName];
}

@end
