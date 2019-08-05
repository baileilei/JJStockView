//
//  YYSelfCollectViewController.m
//  JJStockView
//
//  Created by g on 2019/4/17.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "YYSelfCollectViewController.h"
#import "HWNetTools.h"
#import "XMGSqliteModelTool.h"
#import "YYRedeemModel.h"

@interface YYSelfCollectViewController ()

@end

@implementation YYSelfCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374"]];
//    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    //如何快速测试一个网络请求
//    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//
//        NSError *error = nil;
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        //        NSLog(@"dict-----%@",dict[@"rows"]);
//
//        NSMutableArray *temp = [NSMutableArray array];
//        NSMutableArray *categoriStock = [NSMutableArray array];
//        NSMutableArray *ratioStock = [NSMutableArray array];
//        for (NSDictionary *dic in dict[@"rows"]) {
//
//            YYRedeemModel *stockModel = [[YYRedeemModel alloc] init];
//
//            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
//
//            [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"myFocus"];
//        }
//    }];
    
    //https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374
    [[HWNetTools shareNetTools] GET:@"https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSLog(@"responseObject----%@",responseObject);
        if (responseObject != nil){
            
                   NSLog(@"Successfully deserialized...");
                   //如果jsonObject是字典类
                   if ([responseObject isKindOfClass:[NSDictionary class]]){
                        NSDictionary *weatherDic = (NSDictionary *)responseObject;
                          NSLog(@"Dersialized JSON Dictionary = %@", responseObject);
                       }
            
                }
        NSError *error = nil;
        NSDictionary *dict = responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        //        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *categoriStock = [NSMutableArray array];
        NSMutableArray *ratioStock = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"rows"]) {
            
            YYRedeemModel *stockModel = [[YYRedeemModel alloc] init];
            
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            
            if (stockModel.redeem_real_days.integerValue > 0) {
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"myFocus"];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
