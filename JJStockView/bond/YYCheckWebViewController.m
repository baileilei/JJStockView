//
//  YYCheckWebViewController.m
//  JJStockView
//
//  Created by g on 2019/3/19.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYCheckWebViewController.h"
#import <WebKit/WebKit.h>

//(function(NSDictionary *) {
//    var init = function() {
//        return {
//        imgSrc: document.getElementsByClassName('item')[0].getElementsByTagName('img')[0].src,
//        price: document.getElementsByClassName('real-price')[0].getElementsByClassName('price')[0].textContent,
//        title: document.getElementsByClassName('main')[0].textContent
//        };
//    };
////    return init();
//})();

@interface YYCheckWebViewController ()<UIWebViewDelegate,WKNavigationDelegate>

//@property (weak,nonatomic) WKWebView *wkwebView;

@end

@implementation YYCheckWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *url = [NSString stringWithFormat:@"http://vip.stock.finance.sina.com.cn/mkt/#chgn_700234"];
    //    NSString *chartURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml?from=BaiduAladin",self.stockID];
    //    NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/600031"];
    NSLog(@"url--%@-----%@",url,self);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request.URL----%@",request.URL);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //document.getElementsByClassName('isClickTr')[0].textContent
    NSString *jsStr = [NSString stringWithFormat:@"document.getElementsByClassName('isClickTr')[0].textContent"];
//    NSString *jsStr = [NSString stringWithFormat:@"(function(){var init = function(){return {imgSrc:document.getElementsByClassName('item')[0].getElementsByTagName('img')[0].src,price:document.getElementsByClassName('real-price')[0].getElementsByClassName('price')[0].textContent,title:document.getElementsByClassName('main')[0].textContent};}; return init();})()"];
    NSString *targetStr = [webView stringByEvaluatingJavaScriptFromString:jsStr];
    NSLog(@"targetStr--%@",targetStr);
    //没有效果，根本原因在于这个网络请求中没有这个数据的返回。  这个网络请求中应该是直接回发起两次网络请求，但是怎么发出去的却不太懂。    回调中才有数据的返回。 相同的网络请求，不同的返回结果。
}

@end
