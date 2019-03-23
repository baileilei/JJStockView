//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "DemoViewController.h"
#import "JJStockView.h"
#import "YYStockModel.h"
#import "XMGSqliteModelTool.h"

#import "YYBuyIntoViewController.h"
#import "YYWebViewController.h"
#import "YYKLineWebViewController.h"

#import "XMGSessionManager.h"
#import "BaseNetManager.h"

#import "YYCheckWebViewController.h"

#import "YYDateUtil.h"

#define columnCount 12

@interface DemoViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

@end

@implementation DemoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self p_testLoaclNotification];
//    [self testResultOfAPI];
//    .[self testAPIWithAFN];
    
    [self requestData];
    self.navigationItem.title = @"股票表格";
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查看" style:UIBarButtonItemStyleDone target:self action:@selector(p_checkSum)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - Stock DataSource
//多少行
- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.stocks.count;
}
//左侧显示什么名称
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    YYStockModel *model = self.stocks[row];
//    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text = [NSString stringWithFormat:@"%@",model.bond_nm];
    
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
//内容
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, columnCount * 100, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    for (int i = 0; i < columnCount; i++) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        YYStockModel *model = self.stocks[row];
        NSString *btnTitle = nil;
        float ratio = (model.full_price.floatValue - model.convert_value.floatValue)/model.convert_value.floatValue;
        switch (i) {
            case 0:
                btnTitle = [NSString stringWithFormat:@"%.2f%%",ratio * 100];
                break;
            case 1:
                btnTitle = model.full_price;
                break;
            case 2:
                btnTitle = model.convert_value;
                break;
            case 3:
                btnTitle = model.convert_price;// 0.9   1.3
                break;
            case 4:
                btnTitle = model.convert_dt;//日期转String
                break;
            case 5:
                btnTitle = model.sprice;//输入框？
                break;
            case 6:
                btnTitle = model.issue_dt;
                break;
            case 7:
                btnTitle = model.list_dt.length > 0 ? model.list_dt : model.price_tips;//@"买入策略";//输入框？
                break;
            case 8:
                btnTitle = [NSString stringWithFormat:@"K-%@",model.bond_id];
                break;
            case 9:
                btnTitle = model.stock_id;
                break;
            case 10:
                btnTitle = model.stock_id;
                break;
            case 11:
                btnTitle = model.stock_id;
                break;
            case 12:
                btnTitle = model.stock_id;
                break;
            default:
                break;
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@",btnTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"%@",btnTitle];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
        if ([btnTitle isEqualToString:model.stock_id] || [btnTitle isEqualToString:[NSString stringWithFormat:@"K-%@",model.bond_id]]) {
            [bg addSubview:button];
        }
        
        //青橙黄绿蓝棕紫
        /*
          + (UIColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB    青   蓝绿
         + (UIColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB    橙
         + (UIColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB   黄
         + (UIColor *)greenColor;      // 0.0, 1.0, 0.0 RGB   绿
         + (UIColor *)blueColor;       // 0.0, 0.0, 1.0 RGB    蓝
         + (UIColor *)brownColor;      // 0.6, 0.4, 0.2 RGB   棕
          + (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB    紫
         
         + (UIColor *)redColor;        // 1.0, 0.0, 0.0 RGB  红
         + (UIColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB    粉红
         */
        //关注- 上市日期在8天之内的
        //        model.issue_dt
        if (ABS(model.full_price.integerValue - 100) < 10 ) {//关注
            label.backgroundColor = [UIColor orangeColor];
        }
        
        if ([YYDateUtil toCurrentLessThan8Days:model.issue_dt]) {//上市八天内的
            label.backgroundColor = [UIColor purpleColor];
        }
        
        if (model.sprice.floatValue > model.convert_price.floatValue && ABS(model.full_price.integerValue - 100) < 13) {//关注
            label.backgroundColor = [UIColor redColor];
        }
       
        
        
//        策略2-----经济整体周期进入了衰退期   债券和黄金为主要标的  所以可以放宽一点  从周期把握趋势
        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 10) {//特别关注
            label.backgroundColor = [UIColor magentaColor];
        }
         
        //策略1
        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 8 && model.full_price.integerValue != 100) {
            label.backgroundColor = [UIColor orangeColor];//特别关注
        }
        

       

        
    }
    return bg;
}

#pragma mark - Stock Delegate

- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    return 30.0f;
}

- (UIView*)headRegularTitle:(JJStockView*)stockView{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"标题";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)headTitle:(JJStockView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, columnCount * 100, 40)];
    bg.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    for (int i = 0; i < columnCount; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"标题:%d",i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * 100, 0, 100, 40);
        
        switch (i) {
            case 0:
                label.text = @"溢价率";
                break;
            case 1:
                label.text = @"现价";
                break;
            case 2:
                label.text = @"转股价值";
                break;
            case 3:
                label.text = @"转股价";
                break;
            case 4:
                label.text = @"转股起始日";
                break;
            case 5:
                label.text = @"股价";
                break;
            case 6:
                label.text = @"可申购日期";
                break;
            case 7:
                label.text = @"上市日期";//@"买入策略";//输入框？
                break;
            case 8:
                label.text = @"K线图";
                break;
            case 9:
                label.text = @"公告";
                break;
            case 10:
                label.text = @"公告";
                break;
            case 11:
                label.text = @"公告";
                break;
            case 12:
                label.text = @"公告";
                break;
            default:
                break;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [button setTitle:label.text forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:button];
//        [bg addSubview:label];
    }
    return bg;
}

- (CGFloat)heightForHeadTitle:(JJStockView*)stockView{
    return 40.0f;
}

- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"DidSelect Row:%ld",row);
    YYStockModel *stockModel = self.stocks[row];
    YYBuyIntoViewController *buyIntoVC = [[YYBuyIntoViewController alloc] init];
    buyIntoVC.stockModel = stockModel;
    [self presentViewController:buyIntoVC animated:YES completion:nil];
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    
    if ([sender.currentTitle hasPrefix:@"K-"]) {
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.stockID = [sender.currentTitle substringFromIndex:2];
//        NSLog(@" 啥---%@",[self.stocks valueForKey:kWeb.stockID]);
        for (YYStockModel *m in self.stocks) {
            if ([m.bond_id isEqualToString:kWeb.stockID]) {
                kWeb.market = m.market;
            }
        }
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
    web.stockID = sender.currentTitle;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
  
    
//    [self.navigationController pushViewController:[[UINavigationController alloc] initWithRootViewController:buyIntoVC] animated:YES];
}

-(void)sort:(UIButton *)btn{
    NSLog(@"%@",btn.currentTitle);
    
    [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
        return obj1.full_price > obj2.full_price;
    }];
    
//    [self.stocks sortusing];
    
    [self.stockView reloadStockView];
}

#pragma mark - Get

- (JJStockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [JJStockView new];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}


/**
 
 */
- (void)requestData {
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/cb_list/?___jsl=LST___t=1550727503725"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //        NSLog(@"response -----%@",response);
//                NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"rows"]) {
            YYStockModel *stockModel = [[YYStockModel alloc] init];
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            [temp addObject:stockModel];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"Mystock"];
            });
        }
        
        self.stocks = temp;
        
        
        [self.stockView reloadStockView];
    }];
}

//https://xian.newhouse.fang.com/sales/
//http://www.sse.com.cn/market/bonddata/convertible/
/**
 
 */
-(void)testResultOfAPI{
    //http://finance.sina.com.cn/realstock/company/sh600031/nc.shtml?from=BaiduAladin
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.sse.com.cn/market/bonddata/convertible/"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"response -----%@",response);
        NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
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
//http://www.sse.com.cn/market/bonddata/convertible/
-(void)testAPIWithAFN{
//    XMGSessionManager *manager = [[XMGSessionManager alloc] init];
//    [manager request:RequestTypeGet urlStr:@"https://xian.newhouse.fang.com/sales/" parameter:nil resultBlock:^(id responseObject, NSError *error) {
//        
//        NSLog(@"responseObject----%@",responseObject);
//        
//        if (error) {
//            NSLog(@"error-----%@",error);
//        }
//        
//    }];
    
    [[BaseNetManager defaultManager] GET:@"http://www.sse.com.cn/market/bonddata/convertible/" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject----%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error-----%@",error);
        }
    }];
    
}

-(void)p_checkSum{
    YYCheckWebViewController *checkVC = [[YYCheckWebViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:checkVC] animated:YES completion:nil];
}

-(void)p_testLoaclNotification{
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNote.alertBody = @"八戒，来信息了";
    //设置其他信息
    localNote.userInfo = @{@"content": @"高小姐喊你回家吃饭", @"type": @2};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

@end
