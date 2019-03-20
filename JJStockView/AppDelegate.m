//
//  AppDelegate.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

//#define VC_DEBUG

#import "AppDelegate.h"
#import "DemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",NSHomeDirectory());
    
    //从启动选项中获取本地通知--------应用杀死状态
    UILocalNotification *localNote = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    
    [self showLocalNote:localNote];
    
    DemoViewController* view = [[DemoViewController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:view];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//应用在后台的状态
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSString *content = notification.userInfo[@"content"];
    NSLog(@"%@",content);
    [self showLocalNote:notification];
}

- (void)showLocalNote:(UILocalNotification *)localNote{
    
    //    //使用UI展示获取的通知内容
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 700, 50)];
    //    [self.window.rootViewController.view addSubview:label];
    //    label.text = localNote.userInfo[@"content"];
    
    
    
    
    /**
     *
     
     typedef NS_ENUM(NSInteger, UIApplicationState) {
     UIApplicationStateActive,      应用激活状态(应用在前台)
     UIApplicationStateInactive,    应用未激活状态
     UIApplicationStateBackground   应用在后台
     } NS_ENUM_AVAILABLE_IOS(4_0);
     */
    
    //根据传递数据跳转不同控制器
    NSInteger type = [localNote.userInfo[@"type"] integerValue];
    
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) { //当应用不在前台时,进行界面跳转
        
        UITabBarController *tabBarVc =  (UITabBarController *)self.window.rootViewController;
        switch (type) {
            case 1:
                tabBarVc.selectedIndex = 1;
                break;
            case 2:
                tabBarVc.selectedIndex = 2;
                break;
            default:
                break;
        }
    } else {
        
        NSLog(@"接收到索引:%zd", type);
    }
    
}


@end
