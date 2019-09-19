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
 
    //http://money.finance.sina.com.cn/bond/quotes/sh110032.html
    //http://quote.eastmoney.com/bond/sh110055.html
    NSString *chartURL = nil;
    if (self.stockURL) {//股票
        chartURL = self.stockURL;
    }else{//债券
        chartURL = [NSString stringWithFormat:@"%@",self.bondURL];
    }
    NSLog(@"url-------%@",chartURL);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:chartURL]];
    [self.webView loadRequest:request];
    
    self.navigationItem.title = self.bigPrice;
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = @"document.getElementsByClassName('wrap topAD')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    NSString *str1 = @"document.getElementById('hq_main_top_tgWrap').remove();";
    [webView stringByEvaluatingJavaScriptFromString:str1];
    
    //document.getElementById('flex0').remove();
    NSString *str2 = @"document.getElementsByClassName('AD_R')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str2];
    
    //document.getElementsByClassName('AD_hqbottom')[0].remove();

    NSString *str3 = @"document.getElementsByClassName('AD_hqbottom')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str3];
    
    //document.getElementsByClassName('cj_app_left')[0].remove();
    NSString *str4 = @"document.getElementsByClassName('cj_app_left')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str4];
    //document.getElementsByClassName('topBlk')[0].remove();
    NSString *str5 = @"document.getElementsByClassName('topBlk')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str5];

}

@end
