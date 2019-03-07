//
//  YYWebViewController.m
//  JJStockView
//
//  Created by godot on 2019/3/1.
//  Copyright © 2019年 Jezz. All rights reserved.
//

#import "YYWebViewController.h"

@interface YYWebViewController ()<UIWebViewDelegate>


@end

@implementation YYWebViewController

-(void)back{
//    [self.navigationController popViewControllerAnimated:YES];
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.view resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self testResultOfAPI];//如何解析Html数据？？？
    
//    UINavigationItem *leftItem = [[UINavigationItem alloc] initwith];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    
    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/%@",[self.stockID substringFromIndex:2] ];
//    NSString *chartURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml?from=BaiduAladin",self.stockID];
//    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/600031"];
    NSLog(@"url--%@-----%@",url,self);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
//    [self.webView reload];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"%s",__func__);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%s",__func__);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"%s",__func__);
    
//    "item_row";
    //document.getElementsByClassName('item_row')[0].remove();
   
    return  YES;
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}


//https://www.jisilu.cn/data/stock/600031
-(void)testResultOfAPI{
    //http://finance.sina.com.cn/realstock/company/sh600031/nc.shtml?from=BaiduAladin
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/stock/600031"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        NSLog(@"response -----%@",response);
//        NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //        NSLog(@"dict-----%@",dict[@"rows"]);
        
        //        NSMutableArray *temp = [NSMutableArray array];
        //        for (NSDictionary *dic in dict[@"rows"]) {
        //            YYStockModel *stockModel = [[YYStockModel alloc] init];
        //            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
        //            [temp addObject:stockModel];
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"Mystock"];
        //            });
        //        }
        
    }];
}

@end
