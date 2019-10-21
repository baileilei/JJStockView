//
//  SMLoginVc.m
//  smartWiFi
//
//  Created by Smart Wi-Fi on 2019/8/13.
//  Copyright © 2019 Smart Wi-Fi. All rights reserved.
//

#import "SMLoginVc.h"
#import "HNLoginView.h"
#import "SMLoginManage.h"
#import "SMLoginNetwork.h"
#import "SMUserInfo.h"
#import "HNLoginIPView.h"
#import "DemoViewController.h"
#import "HMTHintView.h"

//#import "SMHomeVc.h"
//#import "SMCommonWebViewVc.h"

//  国际化
#define LocalizedStringForkey(key)  [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil]
//  self
#define WeakSelf(weakSelf)      __weak __typeof(&*self) weakSelf  = self;


@interface SMLoginVc ()<LoginIPViewDelegate>

@property (nonatomic, weak) HNLoginView *loginView;
@property (nonatomic, copy) NSString *loginUserName; //账号
@property (nonatomic, copy) NSString *loginPassword; //密码
@property (nonatomic, copy) NSString *loginVerCode;  //验证码
@property (nonatomic, copy) NSString *loginImgToken; //imageToken

/**
 ip弹框
 */
@property (nonatomic,strong) HNLoginIPView *loginIPView;

@end

@implementation SMLoginVc

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 绘制界面
    [self configSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    self.loginView.userNameTextField.text = [[SMLoginManage sharedManager] getCurrentUserAccount];
//    self.loginView.pswTextField.text = nil;
}

#pragma mark - 添加子控件
- (void)configSubViews {
     WeakSelf(weakSelf);
    //登录界面
    HNLoginView *loginView = [[HNLoginView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:loginView];
    self.loginView = loginView;
    
    //点击隐私声明文字
    loginView.privacyClickBlock = ^{
        [weakSelf privacyEvent];
    };
    //点击登录按钮
    loginView.loginClickBlock = ^{
        [weakSelf loginButtonClick];
    };
    //长按切换IP
    loginView.loginLogoClickBlock = ^(UILongPressGestureRecognizer *longpress) {
        [weakSelf longpressAction:longpress];
    };
    
    loginView.loginLogoTapClickBlock = ^(UITapGestureRecognizer * _Nullable longpress) {
        [weakSelf getImageCode];
    };
    _loginIPView = [[HNLoginIPView alloc] init];
    _loginIPView.delegate = self;
    _loginIPView.altwidth = SCREEN_WIDTH;
    
    //收回键盘操作
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapKeyboardBack)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.loginView.userNameTextField.text = @"yangjie";
    self.loginView.pswTextField.text = @"Huawei@2019";
    
    [self getImageCode];
}

// 收回键盘方法
- (void)tapKeyboardBack {
    [self.view endEditing:YES];
}

#pragma mark - 跳转隐私声明
- (void)privacyEvent {
    [self.view endEditing:YES];
    
}

#pragma mark 切换IP
- (void)longpressAction:(UILongPressGestureRecognizer*)longpress {
    [self.view endEditing:YES];
    
    if (longpress.state == UIGestureRecognizerStateChanged){
        [_loginIPView creatAltWithAltTile:LocalizedStringForkey(@"ids_newCloud_ip") content:@"IP"];
        [self.view addSubview:_loginIPView];
        [_loginIPView show];
    }
}

#pragma mark - LoginIPViewDelegate
- (void)alertview:(id)altview clickbuttonIndex:(NSInteger)index withTextField:(NSString *)textField{
    [self.view endEditing:YES];
    if (index == 0) {
        [_loginIPView hide];
        NSLog(@"cancel");
    }else{
        if(textField == nil || textField.length == 0) {
//            [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_tip_ip_empty")];
            return;
        }
        else if (![SMLoginManage isUrlAddress:textField] && ![SMLoginManage isIp:textField]) {//  检测ip正则表达式
//            [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_check_ip")];
            return;
        }
        else {
            //保存用户输入----------输入错误 -----登录不成功！
            [[NSUserDefaults standardUserDefaults] setValue:textField forKey:@"IPAddress"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_loginIPView hide];
        }
    }
}

#pragma mark - 登录事件
- (void)loginButtonClick {
    [self.view endEditing:YES];

    _loginUserName = self.loginView.userNameTextField.text;
    _loginPassword  = self.loginView.pswTextField.text;
    _loginVerCode = self.loginView.verCodeTextField.text;

    if (!_loginUserName.length || !_loginPassword.length) {
//        [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_login_accountPwd_null")];
        return;
    }
    
    [self test2_loginRequest];
    
}

-(void)getImageCode{
     WeakSelf(weakSelf);
    //验证码请求
    SMBaseConnect *net = [[SMBaseConnect alloc] init];
    [net.manager GET:@"http://mcloud-uat.huawei.com/mcloud/umag/FreeProxyForText/smartwifi_rtm/smartdesiginer/framework/authentication/v1/code/captacha" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if (responseObject) {
            NSString *imageStr = responseObject[@"data"][@"img"];
            
            weakSelf.loginImgToken = responseObject[@"data"][@"imgToken"];
            
            if(!imageStr.length) {
                return;
            }
            
            //进行首尾空字符串的处理
            imageStr = [imageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            //进行空字符串的处理
            imageStr = [imageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            
            //进行换行字符串的处理
            imageStr = [imageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            //去掉头部的前缀//data:image/jpeg;base64, （可根据实际数据情况而定，如果数据有固定的前缀，就执行下面的方法，如果没有就注销掉或删除掉）
            imageStr = [imageStr substringFromIndex:23];   //23 是根据前缀的具体字符长度而定的。
            //            NSLog(@"imageStr:%@", imageStr);
            
            NSString *encodedImageStr = imageStr;
            
            //进行字符串转data数据 -------NSDataBase64DecodingIgnoreUnknownCharacters
            NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:encodedImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            
            //把data数据转换成图片内容
            UIImage *decodedImage = [UIImage imageWithData:decodedImgData];
            
            // 把图片赋值给图片视图去接受
            weakSelf.loginView.topImg.image = decodedImage;
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)test2_loginRequest {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_loginUserName,@"account", _loginPassword,@"password", _loginVerCode,@"validateCode", _loginImgToken,@"imgToken", nil];
    NSLog(@"params:%@", params);
    
    [HMTHintView alertWaitViewWithView:self.view];
    [[SMLoginNetwork new] doTestPost:@"http://mcloud-uat.huawei.com/mcloud/umag/FreeProxyForText/smartwifi_rtm/smartdesiginer/framework/authentication/v1/login/web-login"
                           paramters:params
                       completeBlock:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull response)
    {
//        [HMTHintView removeHintViewFromSuperView:self.view];
        NSLog(@"%@",response);
        
//        if (conn.resultCode == 200) {
        
            SMUserInfo *userInfo = [SMUserInfo userInfoWithObject:response];
            //保存用户信息
            [[SMLoginManage sharedManager] saveCurrentUserInfo:userInfo];
            
            DemoViewController *homeVc = [[DemoViewController alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:homeVc];
            [self presentViewController:navigation animated:YES completion:nil];
        
//        }
        
    }];
}

- (void)loginRequest {
    WeakSelf(weakSelf);
    
    [HMTHintView alertWaitViewWithView:self.view];
    [SMLoginNetwork loginWithAccount:_loginUserName password:_loginPassword completeBlock:^(SMLoginNetwork * _Nonnull conn, id  _Nonnull responsed) {
//        [HMTHintView removeHintViewFromSuperView:self.view];
        
        NSLog(@"%@", responsed);
        
        if (conn.resultCode == 200) {
            
            SMUserInfo *userInfo = [SMUserInfo userInfoWithObject:responsed];
            //保存用户信息
            [[SMLoginManage sharedManager] saveCurrentUserInfo:userInfo];
            
            DemoViewController *homeVc = [[DemoViewController alloc] init];
            UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:homeVc];
            [weakSelf presentViewController:navigation animated:YES completion:nil];
            
        } else if (conn.resultCode == 501) { //账号密码错误
//            [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_login_accountPwd_incorrect")];
        } else if (conn.resultCode == 502) { //账号锁定中
            [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_login_accountPwd_lock")];
        } else {
            [HMTHintView alertWithView:self.view message:LocalizedStringForkey(@"ids_tip_ServiceTimeout")];
        }
        
    }];

}

- (void)Test_loginRequest {
    
    [HMTHintView alertWaitViewWithView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HMTHintView removeHintViewFromSuperView:self.view];
        SMUserInfo *userInfo = [[SMUserInfo alloc] init];
        userInfo.userName = self.loginUserName;
        userInfo.userPwd = self.loginPassword;
        userInfo.userId = @"ssss";
        userInfo.token = @"2222";
        //保存用户信息
        [[SMLoginManage sharedManager] saveCurrentUserInfo:userInfo];
        
        DemoViewController *homeVc = [[DemoViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:homeVc];
        [self presentViewController:navigation animated:YES completion:nil];
    });
}

@end
