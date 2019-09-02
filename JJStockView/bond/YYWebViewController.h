//
//  YYWebViewController.h
//  JJStockView
//
//  Created by godot on 2019/3/1.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YYWebViewController : UIViewController



@property (nonatomic,copy) NSString *bondURL;

@property (nonatomic,copy) NSString *stockURL;

//父类 统一处理标题 和 webView的初始化
@property (strong,nonatomic) UIWebView *webView;
@property (nonatomic,copy) NSString *bigPrice;
@end
