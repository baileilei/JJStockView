//
//  HMTHintView.h
//  MaintainApp
//
//  Created by ***403142 on 16/11/24.
//  Copyright © 2016年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTHintView : UIView

/**
 弹出提示框,不阻断用户的界面操作

 @param view    需要添加到的父控件
 @param message 提示内容
 */
+ (void)alertWithView:(UIView *)view message:(NSString *)message;

/**
 弹出提示框,不阻断用户的界面操作 显示在视图下方
 
 @param view    需要添加到的父控件
 @param message 提示内容
 */
+ (void)alertInBottomWithView:(UIView *)view message:(NSString *)message;

/**
 弹出提示框,阻断用户的界面操作
 注意：阻断界面操作直到提示语消失
 @param view    需要添加到的父控件
 @param message 提示内容
 */
+ (void)alertWithViewAnduserInteractionDisEnabled:(UIView *)view message:(NSString *)message;

/**
 界面切换提示框（请稍后）,不阻断用户的界面操作

 @param view 需要添加到的父控件
 */
+ (void)alertWaitViewWithView:(UIView *)view;

+ (void)alertActivityWithView:(UIView *)view message:(NSString *)message;

/**
 界面切换提示框（请稍后）,阻断用户的界面操作
 注意：阻断界面操作直到提示语消失
 
 @param view 需要添加到的父控件
 */
+ (void)alertWaitViewWithViewAnduserInteractionDisEnabled:(UIView *)view;

/**
 移除弹出框

 @param superView 父控件
 */
+ (void)removeHintViewFromSuperView:(UIView *)superView;

/**
 添加非全局的提示视图
 */
+ (void)alertWithViewForMoreThanOnce:(UIView *)view message:(NSString *)message;

/**
 添加全局的提示视图，整个屏幕无法点击
 
 */
+ (void)alertWaitViewWithViewAndWholeViewDisabled:(UIView *)view;

@end
