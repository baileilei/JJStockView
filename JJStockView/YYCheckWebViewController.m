//
//  YYCheckWebViewController.m
//  JJStockView
//
//  Created by g on 2019/3/19.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYCheckWebViewController.h"

@interface YYCheckWebViewController ()

@end

@implementation YYCheckWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = [NSString stringWithFormat:@"http://www.sse.com.cn/market/bonddata/convertible/"];
    //    NSString *chartURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml?from=BaiduAladin",self.stockID];
    //    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/600031"];
    NSLog(@"url--%@-----%@",url,self);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}



@end
