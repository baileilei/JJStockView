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

@interface DemoViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.navigationItem.title = @"股票表格";
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
}

#pragma mark - Stock DataSource

- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.stocks.count;
}

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

- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    for (int i = 0; i < 10; i++) {
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
                btnTitle = model.convert_price;
                break;
            case 4:
                btnTitle = model.convert_dt;//日期转String
                break;
            case 5:
                btnTitle = model.bond_id;//输入框？
                break;
            case 6:
                btnTitle = @"目标价位";
                break;
            case 7:
                btnTitle = @"买入策略";//输入框？
                break;
            case 8:
                btnTitle = @"目标价位";
                break;
                
            default:
                break;
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@",btnTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = i;
//        [bg addSubview:button];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"%@",btnTitle];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
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
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 40)];
    bg.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    for (int i = 0; i < 10; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
        label.text = [NSString stringWithFormat:@"标题:%d",i];
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
                label.text = @"债券转码";
                break;
            case 6:
                label.text = @"目标价位";
                break;
            case 7:
                label.text = @"买入策略";//输入框？
                break;
            case 8:
                label.text = @"目标价位";
                break;
                
            default:
                break;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [bg addSubview:label];
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
    
  
//    [self.navigationController pushViewController:[[UINavigationController alloc] initWithRootViewController:buyIntoVC] animated:YES];
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


- (void)requestData {
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/cb_list/?___jsl=LST___t=1550727503725"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //        NSLog(@"response -----%@",response);
                NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
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

@end
