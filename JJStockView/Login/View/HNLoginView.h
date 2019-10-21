//
//  HNLoginView.h
//  HomeNetwork
//
//  Created by huangxiaogang on 17/3/9.
//  Copyright © 2017年 HUAWEI. All rights reserved.
//

@class HMTUnHighlightedButton;

#import <UIKit/UIKit.h>

typedef void(^LoginBtnClickBlock)(void);
typedef void(^LocalLoginClickBlock)(void);
typedef void(^RegisterBtnClickBlock)(void);
typedef void(^ForgetPswBtnClickBlock)(void);
typedef void(^CountryCodeBtnClickBlock)(void);
typedef void(^ChangeLangClickBlock)(UITapGestureRecognizer * _Nonnull tap);
typedef void(^LoginLogoClickBlock)(UILongPressGestureRecognizer * _Nullable longpress);
typedef void(^LoginLogoTapClickBlock)(UITapGestureRecognizer * _Nullable longpress);
typedef void(^PrivacyClickBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface HNLoginView : UIView

//国家码
@property (nonatomic, strong) UILabel *codeLabel;

//账号
@property (nonatomic, strong) UITextField *userNameTextField;

//密码
@property (nonatomic, strong) UITextField *pswTextField;

//验证码
@property (nonatomic, strong) UITextField *verCodeTextField;

// 顶部图标
@property (nonatomic, strong) UIImageView *topImg;

//点击登录按钮
@property (nonatomic, copy) LoginBtnClickBlock loginClickBlock;

//点击注册按钮
@property (nonatomic, copy) RegisterBtnClickBlock registerClickBlock;

//点击忘记密码按钮
@property (nonatomic, copy) ForgetPswBtnClickBlock forgetPswClickBlock;

//点击本地登录按钮
@property (nonatomic, copy) LocalLoginClickBlock localLoginClickBlock;

//国家码图标
@property (nonatomic, copy) CountryCodeBtnClickBlock countryCodeClickBlock;

//点击切换语言
@property (nonatomic, copy) ChangeLangClickBlock changeLangClickBlock;

//长按登录图标
@property (nonatomic, copy) LoginLogoClickBlock loginLogoClickBlock;

@property (nonatomic, copy) LoginLogoTapClickBlock loginLogoTapClickBlock;

//点击隐私声明
@property (nonatomic, copy) PrivacyClickBlock privacyClickBlock;

@end

NS_ASSUME_NONNULL_END
