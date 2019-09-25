//
//  YYHoldingViewController.m
//  JJStockView
//
//  Created by smart-wift on 2019/9/25.
//  Copyright © 2019 Jezz. All rights reserved.
//
//M
#import "YYMockBuyModel.h"

//V
#import "JJStockView.h"

//C
#import "YYHoldingViewController.h"

//T
#import "XMGSqliteModelTool.h"

//同一个文件内传递 值的方法有：函数参数，全局变量，属性。
//不同文件之间：block，代理，

@interface YYHoldingViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

#define columnCount 25
#define columnWidth 120
@property (nonatomic,strong) NSArray *headTitles;
@property (nonatomic,strong) NSMutableArray *headMatchContents;

@end

@implementation YYHoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.stockView];
    
    self.stocks = [XMGSqliteModelTool queryAllModels:[YYMockBuyModel class] uid:@"mockExchange"].mutableCopy;
    [self.stockView reloadStockView];
}

#pragma mark - Stock DataSource
//多少行
- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.stocks.count;
}
//左侧显示什么名称
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    YYMockBuyModel *model = self.stocks[row];
    //    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text = [NSString stringWithFormat:@"%@",model.bond_id];
    
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
#pragma mark - 内容
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, columnCount * columnWidth, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    NSArray *temp = [self headMatchContent:row];;
    for (int i = 0; i < columnCount; i++) {
        //        temp = [self headMatchContent:i];
        float titleWidth = 100;
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * titleWidth, 0, columnWidth, 30)];
        
        [button setTitle:[NSString stringWithFormat:@"%@",temp[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = row;
        
        [bg addSubview:button];
        //修改背景色
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
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, columnCount * columnWidth, 40)];
    bg.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    
    for (int i = 0; i < columnCount; i++) {
        //        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * columnWidth, 0, columnWidth, 40)];
        //        label.text = [NSString stringWithFormat:@"标题:%d",i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * columnWidth, 0, columnWidth, 40);
        //        label.textAlignment = NSTextAlignmentCenter;
        //        label.textColor = [UIColor grayColor];
        [button setTitle:self.headTitles[i] forState:UIControlStateNormal];
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
    YYMockBuyModel *stockModel = self.stocks[row];;
//    YYBuyIntoViewController *buyIntoVC = [[YYBuyIntoViewController alloc] init];
//    buyIntoVC.stockModel = stockModel;
//    [self presentViewController:buyIntoVC animated:YES completion:nil];
}

#pragma mark - Get

- (JJStockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [JJStockView new];
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}

-(NSArray *)headTitles{
    if (!_headTitles) {//单独的可排序
        _headTitles = [NSArray arrayWithObjects:@"债价/成本",@"持仓/可用",@"市值",@"总盈亏",@"当日盈亏",nil];
    }
    return _headTitles;
}

-(NSMutableArray *)headMatchContents{
    if (!_headMatchContents) {
        _headMatchContents = [NSMutableArray array];
    }
    return _headMatchContents;
}

-(NSMutableArray *)headMatchContent:(NSInteger)index{
    
    [self.headMatchContents removeAllObjects];
    //多多运用三目运算符。可以简化很多代码和条件判断
//    YYStockModel *model = self.isSearch == YES? self.searchResults[index] : self.stocks[index];
    YYMockBuyModel *model = self.stocks[index];
    NSArray *mockArray = [XMGSqliteModelTool queryAllModels:[YYMockBuyModel class] uid:@"mockExchange"];
//    for (YYMockBuyModel *mockModel in mockArray) {
//        if ([[mockModel.bond_id substringToIndex:6] isEqualToString:[model.bond_id substringToIndex:6]]) {
//            model.full_price = [NSString stringWithFormat:@"%@/%@",model.full_price,mockModel.buyPrice];
//        };
//    }
//    [self.headMatchContents addObject:model.full_price];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@",model.increase_rt]];
//    [self.headMatchContents addObject:model.sprice];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@",model.sincrease_rt]];
//    [self.headMatchContents addObject:model.put_convert_price];
//
//    [self.headMatchContents addObject:model.convert_price];
//    [self.headMatchContents addObject:model.force_redeem_price];
//    [self.headMatchContents addObject:@"对比"];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.ma20_SI]];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.ratio]];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.convertToStockRatio]];//
    
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@-%@",model.redeem_real_days,model.redeem_total_days,model.redeem_count_days]];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@-%@",model.put_real_days,model.put_total_days,model.put_count_days]];
//    [self.headMatchContents addObject:model.year_left];
//    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@",model.curr_iss_amt,model.orig_iss_amt] ];
    
    [self.headMatchContents addObject:@""];
//    [self.headMatchContents addObject:[model.rating_cd stringByAppendingFormat:@"%d个",model.SIBibber9Count]];
//    [self.headMatchContents addObject:model.redeem_price];
//    [self.headMatchContents addObject:model.convert_dt];
    
    [self.headMatchContents addObject:@"股价K线图"];
    [self.headMatchContents addObject:@"债K线图"];
    [self.headMatchContents addObject:@"公告"];
//    [self.headMatchContents addObject:model.stockMainBusiness ?: @"主营业务"];
//    if (!model.stockConcept) {
//        model.stockConcept = [[NSUserDefaults standardUserDefaults] objectForKey:model.stock_nm];
//    }
//    [self.headMatchContents addObject:model.stockConcept ?: @"概念"];
//    [self.headMatchContents addObject:model.stockConcept ?: @"概念"];

    return  self.headMatchContents;
}
@end
