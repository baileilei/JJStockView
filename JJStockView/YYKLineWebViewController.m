//
//  YYKLineWebViewController.m
//  JJStockView
//
//  Created by godot on 2019/3/7.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import "YYKLineWebViewController.h"

@interface YYKLineWebViewController ()

@end

@implementation YYKLineWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/%@",[self.stockID substringFromIndex:2] ];
    NSString *chartURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml?from=BaiduAladin",self.stockID];
    //    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/600031"];
    NSLog(@"url-------%@",chartURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:chartURL]];
    [self.webView loadRequest:request];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = @"document.getElementsByClassName('item_row')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    NSString *str1 = @"document.getElementsByClassName('item_row')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str1];
    
    //document.getElementById('flex0').remove();
    NSString *str2 = @"document.getElementById('flex0').remove();";
    [webView stringByEvaluatingJavaScriptFromString:str2];
}

@end
