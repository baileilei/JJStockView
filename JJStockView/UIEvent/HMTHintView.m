//
//  HMTHintView.m
//  MaintainApp
//
//  Created by ***403142 on 16/11/24.
//  Copyright © 2016年 huawei. All rights reserved.
//

#define HMTUIdispatch_main_sync_safety(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define HMTUIdispatch_main_async_safety(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//  屏幕宽度
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
//  屏幕高度
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


#import "HMTHintView.h"
//#import "HNWholeMaskView.h"
//#import "HNMaskViewExculdedNavigationBar.h"
//#import "SMConstant.h"

@interface HMTHintView ()

@property (nonatomic, strong) UILabel *alertLabel;

@end

HMTHintView *alertView;
@implementation HMTHintView

- (instancetype)initWithMessage:(NSString *)message {

    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor grayColor];
        
        UILabel *alertLabel = [[UILabel alloc] init];
        alertLabel.text = message;
        alertLabel.numberOfLines = 0;
        alertLabel.font = [UIFont systemFontOfSize:15];
        CGRect rect = [message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.5, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:alertLabel.font}
                                            context:nil];
        CGFloat labelY = (SCREEN_HEIGHT - rect.size.height - 20) * 0.5;
        self.frame = CGRectMake((SCREEN_WIDTH - rect.size.width - 20) * 0.5, labelY, rect.size.width + 20, rect.size.height + 20);
        alertLabel.frame = CGRectMake(10, 10, rect.size.width, rect.size.height);
        alertLabel.textColor = [UIColor whiteColor];
        alertLabel.backgroundColor = [UIColor clearColor];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        self.alertLabel = alertLabel;
        [self addSubview:alertLabel];
    }
    return self;
}

+ (void)alertWithView:(UIView *)view message:(NSString *)message {
    
    HMTUIdispatch_main_async_safety(^{
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[HMTHintView class]]) {
                [subview removeFromSuperview];
            }
        }
        
        alertView = [[HMTHintView alloc] initWithMessage:message];
        [view addSubview:alertView];
        [UIView animateWithDuration:3.5 animations:^{
            alertView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [alertView removeFromSuperview];
//                [HMTHintView removeMaskViewExculdedNavigationBar:view];
            }
        }];
    });
}
+ (void)alertInBottomWithView:(UIView *)view message:(NSString *)message {
    
    HMTUIdispatch_main_async_safety(^{
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[HMTHintView class]]) {
                [subview removeFromSuperview];
            }
        }
        alertView = [[HMTHintView alloc] initWithMessage:message];
        CGRect alertViewRect = alertView.frame;
        alertViewRect.origin.y = SCREEN_HEIGHT - 150;
        alertView.frame = alertViewRect;
        [view addSubview:alertView];
        [UIView animateWithDuration:2.5 animations:^{
            alertView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                [alertView removeFromSuperview];
//                [HMTHintView removeMaskViewExculdedNavigationBar:view];
            }
        }];
    });
}
+ (void)alertWithViewAnduserInteractionDisEnabled:(UIView *)view message:(NSString *)message
{
    [self createMaskViewExculdedNavigationBar:view];
    
    [self alertWithView:view message:message];
}

+ (void)alertWaitViewWithView:(UIView *)view {
	[self alertActivityWithView:view message:@"请稍后..."];
}

+ (void)alertActivityWithView:(UIView *)view message:(NSString *)message{
	HMTUIdispatch_main_async_safety(^{
		for (UIView *subview in view.subviews) {
			if ([subview isKindOfClass:[HMTHintView class]]) {
				[subview removeFromSuperview];
			}
		}
		HMTHintView *waitView = [[HMTHintView alloc] initWithMessage:message];
		CGRect frame = waitView.frame;
		CGFloat alertViewX = frame.origin.x;
		CGFloat alertViewY = frame.origin.y - 15;
		CGFloat alertViewW = frame.size.width;
		CGFloat alertViewH = frame.size.height + 30;
		waitView.frame = CGRectMake(alertViewX, alertViewY, alertViewW, alertViewH);
		
		UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(alertViewW * 0.5 - 10, 10, 20, 20)];
		activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
		[waitView addSubview:activity];
		[activity startAnimating];
		
		CGRect labelFrame = waitView.alertLabel.frame;
		CGFloat labelX = labelFrame.origin.x;
		CGFloat labelY = labelFrame.origin.y + 30;
		CGFloat labelW = labelFrame.size.width;
		CGFloat labelH = labelFrame.size.height;
		waitView.alertLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
		[view addSubview:waitView];
	});
}

+ (void)alertWaitViewWithViewAnduserInteractionDisEnabled:(UIView *)view
{
    [self createMaskViewExculdedNavigationBar:view];
    
    [self alertWaitViewWithView:view];
}

+ (void)removeHintViewFromSuperView:(UIView *)superView {
    HMTUIdispatch_main_async_safety(^{
        for (UIView *view in superView.subviews) {
            if ([view isKindOfClass:[HMTHintView class]]) {
                [view removeFromSuperview];
            }
        }
//        [self removeMaskViewExculdedNavigationBar:superView];
    });
}

+(void)createMaskViewExculdedNavigationBar:(UIView *)view
{
//    HMTUIdispatch_main_async_safety(^{
        //  屏幕宽度
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
        //  屏幕高度
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height    });
}

+(void)removeMaskViewExculdedNavigationBar:(UIView *)superView
{
    HMTUIdispatch_main_async_safety(^{
        for (UIView *view in superView.subviews) {
//            if ([view isKindOfClass:[HNMaskViewExculdedNavigationBar class]]) {
                [view removeFromSuperview];
//            }
        }
    });
}

//非全局视图现实
+ (void)alertWithViewForMoreThanOnce:(UIView *)view message:(NSString *)message {
    
    HMTUIdispatch_main_async_safety(^{
         HMTHintView *alertView = [[HMTHintView alloc] initWithMessage:message];
        [view addSubview:alertView];
        [UIView animateWithDuration:5.0 animations:^{
            alertView.alpha = 0.0;
        } completion:^(BOOL finished) {
            [alertView removeFromSuperview];
            [HMTHintView removeMaskViewExculdedNavigationBar:view];
        }];
    });
}

+ (void)alertWaitViewWithViewAndWholeViewDisabled:(UIView *)view{
	HMTUIdispatch_main_async_safety(^{
//        HNWholeMaskView *maskView  = [[HNWholeMaskView alloc]init];
//        [view addSubview:maskView];
		[self alertWaitViewWithView:view];
	});
}

@end
