//
//  YYStockScrollView.m
//  YYStockView
//
//  Created by Jezz on 2017/10/17.
//  Copyright © 2017年 YYStockView. All rights reserved.
//

#import "YYStockScrollView.h"

@implementation YYStockScrollView


/**
 重写touchesShouldCancelInContentView方法，
 达到当Button作为子View时，可正常滑动

 @param view UIView
 @return 如果返回YES，当前的UIView可以一起滑动，如果NO,当前会拦截滑动事件
 */
- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

@end
