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

@property (nonatomic,copy) NSString *stockID;

@property (nonatomic,copy) NSString *market;


@property (strong,nonatomic) UIWebView *webView;

@property (copy,nonatomic) NSString *targetUrl;

@property (nonatomic,copy) NSString *bigPrice;
@end
