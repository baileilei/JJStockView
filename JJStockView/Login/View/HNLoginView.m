//
//  HNLoginView.m
//  HomeNetwork
//
//  Created by huangxiaogang on 17/3/9.
//  Copyright © 2017年 HUAWEI. All rights reserved.
//

#import "HNLoginView.h"
#import "HNNoPasteTextField.h"
#import "HMTMasonry.h"

#define XFont(x)                [UIFont systemFontOfSize:(x)]
#define LocalizedStringForkey(key)  [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]
// 细线的高度
#define APP_SEPARATOR_COMMON_HIGHT  0.5
// 登录输入框的高度
#define LOGIN_COMMON_HIGHT          45
//  加载图片
#define AppGetImage(imageName)  [UIImage imageNamed:imageName]

// 屏幕比例
#define SCREEN_SCALE        [UIScreen mainScreen].bounds.size.width / 320

#define LOGIN_COMMON_MARGIN         30 * SCREEN_SCALE
// 登录控件的左右边距
#define LOGIN_COMMON_MARGIN_LEFT    30 * SCREEN_SCALE

// 通用控件短间距
#define APP_CUSTOM_DISTANCE         12


@interface HNLoginView()

// 切换语言
@property (nonatomic, strong) UIImageView *changeLanguage;

//// 顶部图标
//@property (nonatomic, strong) UIImageView *topImg;

// 小眼睛
@property (nonatomic, strong) UIButton *seeButton;

// 登录按钮
@property (nonatomic, strong) UIButton *loginBtn;

// 注册
@property (nonatomic, strong) UIButton *registerButton;

// 忘记密码按钮
@property (nonatomic, strong) UIButton *forgetPSWButton;


@end


@implementation HNLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    
    return self;
}

#pragma mark - 添加子控件
- (void)setUpUI {
    
    self.backgroundColor = [UIColor whiteColor];

    // 顶部图标
    self.topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    self.topImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.topImg];
    [self.topImg mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset(20 + 45);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
    }];
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(logoLongPress:)];
    [self.topImg addGestureRecognizer:longPress];
    self.topImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.topImg addGestureRecognizer:tap];
    
    // 子view用来放输入框和前面的图标
    UIView *textView = [[UIView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textView];
    [textView mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImg.mas_bottom).mas_offset(30);
        make.leading.mas_equalTo(self.mas_leading).mas_offset(30);
        make.trailing.mas_equalTo(self.mas_trailing).mas_offset(-30);
        make.height.mas_equalTo(4*0.5 + 30*2);
    }];
    
    // 用户名输入框
    self.verCodeTextField = [[HNNoPasteTextField alloc] init];
    self.verCodeTextField.font = XFont(15);
    self.verCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verCodeTextField.placeholder = @"请输入验证码";
    [self.verCodeTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [textView addSubview:self.verCodeTextField];
    [self.verCodeTextField mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImg.mas_bottom).mas_offset(20);
        make.leading.mas_equalTo(textView.mas_leading);
        make.trailing.mas_equalTo(textView.mas_trailing);
        make.height.mas_equalTo(LOGIN_COMMON_HIGHT);
    }];
    
    // 用户名输入框
    self.userNameTextField = [[HNNoPasteTextField alloc] init];
    self.userNameTextField.font = XFont(15);
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.placeholder = LocalizedStringForkey(@"ids_login_account");
    [self.userNameTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [textView addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImg.mas_bottom).mas_offset(LOGIN_COMMON_HIGHT * 2);
        make.leading.mas_equalTo(textView.mas_leading);
        make.trailing.mas_equalTo(textView.mas_trailing);
        make.height.mas_equalTo(LOGIN_COMMON_HIGHT);
    }];
    
    // 分割线1
    UIView *separateLine = [[UIView alloc] init];
    separateLine.backgroundColor = [UIColor lightGrayColor];
    [textView addSubview:separateLine];
    [separateLine mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextField.mas_bottom);
        make.leading.mas_equalTo(textView.mas_leading);
        make.trailing.mas_equalTo(textView.mas_trailing);
        make.height.mas_equalTo(APP_SEPARATOR_COMMON_HIGHT);
    }];
    
    // 密码输入框
    self.pswTextField = [[HNNoPasteTextField alloc] init];
    self.pswTextField.font = XFont(15);
    self.pswTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.pswTextField.placeholder = LocalizedStringForkey(@"ids_login_pwd");
    self.pswTextField.secureTextEntry = YES;
    self.pswTextField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.pswTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [textView addSubview:self.pswTextField];
    [self.pswTextField mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.centerY.mas_equalTo(textView.mas_centerY).offset(LOGIN_COMMON_HIGHT);
        make.leading.mas_equalTo(textView.mas_leading);
        make.trailing.mas_equalTo(textView.mas_trailing).offset(-APP_CUSTOM_DISTANCE-LOGIN_COMMON_HIGHT);
        make.height.mas_equalTo(LOGIN_COMMON_HIGHT);
    }];
    
    // 小眼睛图标
    self.seeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seeButton setImage:[UIImage imageNamed:@"login_eyeClose"] forState:UIControlStateNormal];
    [self.seeButton setImage:[UIImage imageNamed:@"login_eyeOpen"] forState:UIControlStateSelected];
    [self.seeButton addTarget:self action:@selector(btnPasswordVisualClick:) forControlEvents:UIControlEventTouchUpInside];
    [textView addSubview:self.seeButton];
    [self.seeButton mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.leading.mas_equalTo(self.pswTextField.mas_trailing);
        make.top.mas_equalTo(self.pswTextField.mas_top);
        make.width.mas_equalTo(LOGIN_COMMON_HIGHT);
        make.height.mas_equalTo(LOGIN_COMMON_HIGHT);
    }];
    
    // 分割线2
    UIView *separateLine1 = [[UIView alloc]init];
    separateLine1.backgroundColor = [UIColor lightGrayColor];
    [textView addSubview:separateLine1];
    [separateLine1 mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(self.pswTextField.mas_bottom);
        make.leading.mas_equalTo(textView.mas_leading);
        make.trailing.mas_equalTo(textView.mas_trailing);
        make.height.mas_equalTo(APP_SEPARATOR_COMMON_HIGHT);
    }];
    
//    // 顶部图标
//    self.topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
//    self.topImg.contentMode = UIViewContentModeScaleAspectFit;
//    [self addSubview:self.topImg];
//    [self.topImg mas_makeConstraints:^(HMTMASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top).mas_offset(APP_HEADER_HEIGHT + LOGIN_COMMON_HIGHT);
//        make.centerX.mas_equalTo(self);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(100);
//    }];
    
    // 隐私声明授权按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setImage:AppGetImage(@"login_agreeNomal") forState:UIControlStateNormal];
    [sureBtn setImage:AppGetImage(@"login_agreeSel") forState:UIControlStateSelected];
    [self addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.leading.equalTo(separateLine1.mas_leading).offset(-7);
        make.top.equalTo(separateLine1.mas_bottom).offset(10);
        make.width.height.mas_equalTo(30);
    }];
    
    // 同意隐私声明
    UILabel *privacyL = [[UILabel alloc] init];
    privacyL.text = LocalizedStringForkey(@"ids_login_agreePrivacy");
    privacyL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
    privacyL.textAlignment = NSTextAlignmentLeft;
//    privacyL.textColor = APP_MAIN_COLOR;
    privacyL.userInteractionEnabled = YES;
    [self addSubview:privacyL];
    [privacyL mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.centerY.equalTo(sureBtn);
        make.leading.equalTo(sureBtn.mas_trailing).offset(5);
        make.trailing.equalTo(separateLine1.mas_trailing);
    }];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(privacyAction)];
    [privacyL addGestureRecognizer:tapGesture];
    
    // 登录按钮
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:LocalizedStringForkey(@"ids_login_btn") forState:UIControlStateNormal];
    [self.loginBtn setTintColor:[UIColor blueColor]];
    self.loginBtn.backgroundColor = [UIColor orangeColor];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 4.0f;
    self.loginBtn.titleLabel.font = XFont(18);
    [self.loginBtn addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.mas_equalTo(sureBtn.mas_bottom).offset(LOGIN_COMMON_MARGIN);
        make.leading.mas_equalTo(self.mas_leading).offset(LOGIN_COMMON_MARGIN_LEFT);
        make.trailing.mas_equalTo(self.mas_trailing).offset(-LOGIN_COMMON_MARGIN_LEFT);
        make.height.mas_equalTo(LOGIN_COMMON_HIGHT);
    }];
//    [self enabelLoginBtn:NO];
    
}

#pragma mark - 密码可视
- (void)btnPasswordVisualClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    _pswTextField.secureTextEntry = _pswTextField.isSecureTextEntry ? NO : YES;
    /**  在切换时，如果只使用secureTextEntry来切换会出现明文时字体不一致且光标错位的BUG，可使用下面的方法解决*/
    NSString *text = _pswTextField.text;
    _pswTextField.text = @"";
    _pswTextField.text = text;
}

#pragma mark - 隐私声明授权
- (void)agreeAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self enabelLoginBtn:sender.selected];
}

- (void)logoLongPress:(UILongPressGestureRecognizer *)longPress {
    if (self.loginLogoClickBlock) {
        self.loginLogoClickBlock(longPress);
    }
}

-(void)tap{
    if (self.loginLogoTapClickBlock) {
        self.loginLogoTapClickBlock(nil);
    }
}

- (void)enabelLoginBtn:(BOOL)enable
{
    _loginBtn.enabled = enable;
//    _loginBtn.backgroundColor = enable ? BUTTON_MAIN_COLOR : [[UIColor blackColor] colorWithAlphaComponent:0.3];
}

- (void)privacyAction
{
    if (self.privacyClickBlock) {
        self.privacyClickBlock();
    }
}

#pragma mark 登录按钮
- (void)btnLoginClick:(UIButton *)sender {
    NSLog(@"点击登录按钮");
    if (self.loginClickBlock) {
        self.loginClickBlock();
    }
} 


#pragma mark - 监听textField输入
//取消联想输入法
- (void)textFieldDidChanged:(UITextField *)textField {
    
    NSInteger length_Max = 16;
    
    NSString *toBeString = textField.text;
    /** 键盘输入模式*/
    NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];
    
    if ([lang isEqualToString:@"zh-Hans"])
    {   /** 简体中文输入，包括简体拼音，简体五笔，简体手写*/
        UITextRange *selectedRange = [textField markedTextRange];
        /** 获取高亮部分*/
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        /** 没有高亮选择的字，则对已输入的文字进行字数统计和限制，有高亮选择的字符串，则暂不对文字进行统计和限制*/
        if (!position) {
            if (toBeString.length > length_Max) {
                textField.text = [toBeString substringToIndex:length_Max];
            }
        }
    }
    else {    /** 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况*/
        if(toBeString.length > length_Max) {
            textField.text = [toBeString substringToIndex:length_Max];
        }
    }
}


@end
