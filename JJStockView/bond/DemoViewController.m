//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
// 模拟交易功能

//M
#import "YYStockModel.h"
#import "YYBuyintoStockModel.h"
#import "YYAnotherWatchPondStock.h"
#import "YYSingleStockModel.h"
#import "YYMockBuyModel.h"
#import "YYSingleBondModel.h"
#import "YYDueBondModel.h"
#import "YYMarketValueAndTureOver.h"
#import "YYTicaiModel.h"

//V
#import "WSDatePickerView.h"
#import "HNNetworkFooterView.h"
#import "HNLoginIPView.h"

//C
#import "DemoViewController.h"
#import "YYBuyIntoViewController.h"
#import "YYWebViewController.h"
#import "YYKLineWebViewController.h"
#import "YYCheckWebViewController.h"
#import "YYSerachViewController.h"
#import "YYSelfCollectViewController.h"
#import "WillBondViewController.h"
#import "YYHoldingViewController.h"

//T
#import "XMGSqliteModelTool.h"
#import "XMGSessionManager.h"
#import "BaseNetManager.h"
#import "YYDateUtil.h"
#import "LocalNotificationManager.h"
#import "SMLogManager.h"
#import "FMDB.h"//多线程 处理数据库的问题
#import <Foundation/Foundation.h>
#import "HWNetTools.h"

#import "YYActiveDegree.h"


#define kYYCachePath @"/Users/g/Desktop"

#define oneHour 60 * 60

#define halfAnHour 60 * 30

#define everyTenMinutes 60 * 10

static int AllCount = 1;


@interface DemoViewController ()<StockViewDataSource,StockViewDelegate,UISearchBarDelegate,LoginIPViewDelegate>

@property (nonatomic,strong) NSMutableArray *holdingPonds;
@property (nonatomic,strong) NSMutableArray *watchPond;//监控池功能

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (assign,nonatomic) BOOL isSearch;

@property (nonatomic, strong) NSTimer *timer;

#define columnCount 27
#define columnWidth 120
@property (nonatomic,strong) NSArray *headTitles;
@property (nonatomic,strong) NSMutableArray *headMatchContents;

@property (nonatomic,strong) HNLoginIPView *loginIPView;
@end

@implementation DemoViewController

#pragma mark - 懒加载返回数据定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:everyTenMinutes target:self selector:@selector((onTimer:)) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)onTimer:(NSTimer *)timer{
    NSLog(@"%d",AllCount++);
    
    // 保存的次数
    [[NSUserDefaults standardUserDefaults] setInteger:AllCount forKey:@"AllCount"];
    
    
    
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _loginIPView = [[HNLoginIPView alloc] init];
    _loginIPView.delegate = self;
    _loginIPView.altwidth = SCREEN_WIDTH;
//    [self testResultOfAPI];
//    [self testAPIWithAFN];
    self.searchResults = [NSMutableArray array];
    
    self.isSearch = NO;
    
//    [self requestData];
    
//    [self testAPIWithAFN];
    
    self.navigationItem.title = @"股票表格";
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入名称、代码";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    HNNetworkFooterView *header = [[HNNetworkFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    header.backgroundColor = [UIColor orangeColor];
    //SELECT sprice - convert_price, bond_nm,full_price from YYStockModel where sprice - convert_price > 0 ORDER BY sprice - convert_price;
    //投资模型！   变量因子：时间，股价差。 目的：转债。
    header.titleLable.text = @"缩量滞跌   放量滞涨  放量下跌 缩量上涨---局部，一周为宜   看板：9.25 格力地产的价格是多少？ 5.23？ 未来热点：环保，大气污染（12月）工业大麻--三力士 ";
    self.stockView.jjStockTableView.tableHeaderView = header;
    [self.view addSubview:self.stockView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"对比同类" style:UIBarButtonItemStyleDone target:self action:@selector(p_checkSum)];
    
     UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"强赎" style:UIBarButtonItemStyleDone target:self action:@selector(p_redeem)];
    
    NSString *resourceBundel = [[NSBundle mainBundle] pathForResource:@"Resource.bundle" ofType:nil];
    NSString *pathStr = [[NSBundle bundleWithPath:resourceBundel] pathForResource:@"更新.png" ofType:nil inDirectory:@"images"];
    NSLog(@"pathStr----%@",pathStr);
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:pathStr] style:UIBarButtonItemStyleDone target:self action:@selector(p_calenar)];
     UIBarButtonItem *rightItem3 = [[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStyleDone target:self action:@selector(p_saoYiSao)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1,rightItem2,rightItem3];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(p_refresh)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.timer setFireDate:[NSDate date]];
    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    NSArray *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *holdingDirectory = [[libPath objectAtIndex:0] stringByAppendingPathComponent:@"FocusLog"];
    NSString *SIBigger10FilePath = [holdingDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SIBigger10.plist"]];
    
    
//    NSString *path = [SIBigger10FilePath pathForResource:holdingDirectory ofType:@"plist"];
    NSDictionary *keyDict = [[NSDictionary alloc] initWithContentsOfFile:SIBigger10FilePath];
    
    NSLog(@"keyDict-%@---%@",SIBigger10FilePath,keyDict);
    
    for (NSString *key in keyDict.allKeys) {
        NSString *dtStr = [key substringFromIndex:@"哈哈哈哈".length];
        if ([YYDateUtil toCurrentLessThan3Days:dtStr]) {
//            [LocalNotificationManager addLocalNotification:dtStr withName:[NSString stringWithFormat:@"%@昨日SI>9",key]];
            [[SMLogManager sharedManager] Tool_logPlanName:@"今日关注.txt" targetStockName:[keyDict.allKeys componentsJoinedByString:@","] currentStockPrice:[keyDict.allValues componentsJoinedByString:@","] currentBondPrice:@"" whenToVerify:@"第三天回调？" comments:@"低吸？"];
        }
    }
    
}

#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearch = YES;
    
    if (searchText.length == 0) {
        [self.searchResults removeAllObjects];
    }
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    
    NSArray *temp = [[self.stocks valueForKey:@"bond_nm"] filteredArrayUsingPredicate:resultPredicate];
//    NSArray *nameArray = [self.stocks valueForKey:@"bond_nm"];
    for (NSString *name in temp) {
        for (YYStockModel *model in self.stocks) {
            if ([name isEqualToString:model.bond_nm]) {
                NSLog(@"%@",model.full_price);
                [self.searchResults addObject:model];
            }
        }
    }
    
    NSLog(@"self.searchResults---%@",self.searchResults);
    
    [self.stockView reloadStockView];
   
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
   
    
//    self.searchResults = [XMGSqliteModelTool queryModels:[YYStockModel class] columnName:@"full_price" relation:ColumnNameToValueRelationTypeEqual value:searchBar.text uid:@"Mystock"];
    
    [self.stockView reloadStockView];
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    
}

#pragma mark - Stock DataSource
//多少行
- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.isSearch == YES? self.searchResults.count : self.stocks.count;
}
//左侧显示什么名称
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    
    YYStockModel *model = self.isSearch == YES? self.searchResults[row] : self.stocks[row];
//    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text = [NSString stringWithFormat:@"%@/%@",model.bond_nm,model.price];
    
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
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * columnWidth, 0, columnWidth, 30)];
        
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
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
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
        //@"债价",@"债涨跌幅",@"股价", @"股涨跌幅"(统计个数) ,/@"股价偏离度",@"转股溢价率",@"回售(触发)价",@"转股价", @"强赎触发价"/  转股起始日 剩余规模
        //买入参考：@"评级-到期赎回价" @"S-K线图"; @"K线图";  @"公告";  @"主营业务";  @"概念";//
        //卖出参考： 强天数  剩余年限。。
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
    YYStockModel *stockModel = self.isSearch == YES? self.searchResults[row] : self.stocks[row];;
    YYBuyIntoViewController *buyIntoVC = [[YYBuyIntoViewController alloc] init];
    buyIntoVC.stockModel = stockModel;
    [self presentViewController:buyIntoVC animated:YES completion:nil];
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    if (self.isSearch) {
        
    }
    YYStockModel *m =self.isSearch? self.searchResults[sender.tag]:self.stocks[sender.tag];
    
    if ([sender.currentTitle hasPrefix:@"对比"]) {
        
        if (![self.watchPond containsObject:m]) {
            [self.watchPond addObject:m];
        }
        
        return;
    }
    
    if ([sender.currentTitle hasPrefix:@"债K"]) {
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        
        kWeb.bigPrice = [NSString stringWithFormat:@"上市日期%@---转股%@------强赎%@",m.list_dt,m.convert_dt,m.redeem_dt];
        kWeb.bondURL = m.bondURL;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"股价K"]){
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.stockURL = m.stockURL;
        kWeb.bigPrice = [NSString stringWithFormat:@"回售价%.2f-------下调价%.2f----%@天-----转股价%.2f--------强赎价%.2f,--------currentPrice%@",m.convert_price.floatValue * 0.7,m.convert_price.floatValue * 0.9,m.redeem_real_days,m.convert_price.floatValue,m.convert_price.floatValue * 1.3,m.full_price];;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"主营业务"]){
        
        YYKLineWebViewController *web = [[YYKLineWebViewController alloc] init];
        web.stockURL = m.stockMainBusinessURL;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
        return;
    }else if ([sender.currentTitle hasPrefix:@"公告"]){
        
        YYKLineWebViewController *web = [[YYKLineWebViewController alloc] init];
        web.stockURL = m.stockGongGaoURL;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
        return;
    }else if ([sender.currentTitle hasPrefix:@"概念"]){
        

        [self.loginIPView creatAltWithAltTile:@"concept" content:@"CP"];
        [self.view addSubview:self.loginIPView];
        [self.loginIPView show];
        self.loginIPView.modelIndex = sender.tag;
        self.loginIPView.backgroundColor = [UIColor orangeColor];
        
       
        
        return;
    }else if ([sender.currentTitle isEqualToString:@"BondHistory"]){
        
        NSDate *date = [NSDate date];
        NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
        
        {//https://www.jisilu.cn/data/cbnew/detail_hist/113539?___jsl=LST___t=1569814990739
            NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/cbnew/detail_hist/%@?___jsl=LST___t=1569814990739",[m.bond_id substringToIndex:6]];
            
            [[HWNetTools shareNetTools] POST:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"history ----%@",responseObject);
                
                NSDictionary *dictArray = responseObject[@"rows"];
                for (NSDictionary *dict in dictArray) {
                    YYSingleBondModel *bondM = [[YYSingleBondModel alloc] init];
                    [bondM setValuesForKeysWithDictionary:dict[@"cell"]];
                    bondM.bond_price = [NSString stringWithFormat:@"%.2f",(bondM.premium_rt.floatValue * 0.01 * bondM.convert_value.floatValue + bondM.convert_value.floatValue)];
                    NSLog(@"bond_price-----%@--------%f",bondM.bond_price,bondM.premium_rt.floatValue * 0.01 * bondM.convert_value.floatValue);
//                    dispatch_async(dispatch_get_main_queue(), ^{
                       BOOL isSucess =  [XMGSqliteModelTool saveOrUpdateModel:bondM uid:[dateStr stringByAppendingString:bondM.bond_id]];
                        NSLog(@"保存成功---%d",isSucess);
//                    });
                   
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }

    }
    //https://www.jisilu.cn/data/cbnew/delisted/?___jsl=LST___t=1569838061120
    [self.searchResults removeAllObjects];//数据何时删除 添加？ 更新？？？
    NSLog(@"%@",self.searchResults);
    
}

-(void)alertview:(id)altview clickbuttonIndex:(NSInteger)index withTextField:(NSString *)textField{
     YYStockModel *m =self.isSearch? self.searchResults[self.loginIPView.modelIndex]:self.stocks[self.loginIPView.modelIndex];
    if (index == 0) {
        [self.loginIPView hide];
        YYKLineWebViewController *web = [[YYKLineWebViewController alloc] init];
        web.stockURL = m.stockConceptURL;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
    }else{
        if (textField.length >= 0) {
            
            
            NSDate *date = [NSDate date];
            NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
            m.stockConcept = textField;
            [XMGSqliteModelTool saveOrUpdateModel:m uid:dateStr];
            
            {
                m.bond_id = [NSString stringWithFormat:@"%@-%@",m.bond_id,dateStr];
                m.saveDate = dateStr;
                [XMGSqliteModelTool saveOrUpdateModel:m uid:@"allBondData"];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:m.stockConcept forKey:m.stock_nm];
        }
        
        [self.loginIPView hide];
    }
}

-(void)sort:(UIButton *)btn{
    NSLog(@"%@",btn.currentTitle);
    
    if ([btn.currentTitle isEqualToString:@"债价"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.full_price.floatValue < obj2.full_price.floatValue;
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"债涨跌幅"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.increase_rt.floatValue < obj2.increase_rt.floatValue;
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"股涨跌幅"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.sincrease_rt.floatValue < obj2.sincrease_rt.floatValue;
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"转股起始日"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return [[YYDateUtil stringToDate:obj2.convert_dt dateFormat:@"yyyy-MM-dd"] compare:[YYDateUtil stringToDate:obj1.convert_dt dateFormat:@"yyyy-MM-dd"]];
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"转股价"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.convert_price.floatValue > obj2.convert_price.floatValue;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"强天数"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.redeem_real_days < obj2.redeem_real_days;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"弱天数"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.put_real_days < obj2.put_real_days;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"转股偏离度"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.ma20_SI < obj2.ma20_SI;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"转股溢价率"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.ratio < obj2.ratio;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"转股占比"]) {//大股东为了让市场容易炒作而故意转股的？  凯发？
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.convertToStockRatio < obj2.convertToStockRatio;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"剩余年限"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.year_left.floatValue < obj2.year_left.floatValue;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"剩余规模"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.curr_iss_amt.floatValue < obj2.curr_iss_amt.floatValue;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"活跃度"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return (obj1.volume.floatValue/obj1.curr_iss_amt.floatValue) < (obj2.volume.floatValue/obj2.curr_iss_amt.floatValue);
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"s活跃度"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return (obj1.svolume.floatValue/obj1.curr_iss_amt.floatValue) < (obj2.svolume.floatValue/obj2.curr_iss_amt.floatValue);
            
        }];
    }
    
    
    if ([btn.currentTitle isEqualToString:@"历史数据"]){
        
        NSDate *date = [NSDate date];
        NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
        
        {//https://www.jisilu.cn/data/cbnew/detail_hist/113539?___jsl=LST___t=1569814990739
            NSString *url = [NSString stringWithFormat:@"https://www.jisilu.cn/data/cbnew/delisted/?___jsl=LST___t=1569838061120"];
            
            [[HWNetTools shareNetTools] POST:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"history ----%@",responseObject);
                
                NSDictionary *dictArray = responseObject[@"rows"];
                for (NSDictionary *dict in dictArray) {
                    YYDueBondModel *bondM = [[YYDueBondModel alloc] init];
                    [bondM setValuesForKeysWithDictionary:dict[@"cell"]];
                    //                    dispatch_async(dispatch_get_main_queue(), ^{
                    BOOL isSucess =  [XMGSqliteModelTool saveOrUpdateModel:bondM uid:@"dueBonds"];
                    NSLog(@"保存成功---%d",isSucess);
                    //                    });
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
        
    }


    
    [self.stockView reloadStockView];
}

#pragma mark - Get

- (JJStockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [JJStockView new];
//    _stockView.backgroundColor = [UIColor orangeColor];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}


/**
 https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374
 
 */
- (void)requestData {
//    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/cb_list/?___jsl=LST___t=1550727503725"]];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/cb_list/?___jsl=LST___t=1550727503725"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//             http://money.finance.sina.com.cn/bond/quotes/(null)110030.html   NSLog(@"response -----%@",response);
        NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSDate *date = [NSDate date];
        NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
        
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableDictionary *dictToPlist = [NSMutableDictionary dictionary];
        NSMutableDictionary *allToPlist = [NSMutableDictionary dictionary];
        NSMutableDictionary *SIBigger10dictPlist = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in dict[@"rows"]) {
            
            YYStockModel *stockModel = [[YYStockModel alloc] init];
            
            YYActiveDegree *degree = [[YYActiveDegree alloc] init];
            [degree setValuesForKeysWithDictionary:dic[@"cell"]];
            
            NSDate *date = [NSDate date];
            NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
            degree.date = dateStr;
            
            NSString *pmURL = [NSString stringWithFormat:@"http://f10.eastmoney.com/PC_HSF10/IndustryAnalysis/IndustryAnalysisAjax?code=%@&icode=447",degree.stock_id];
            [[BaseNetManager defaultManager] GET:pmURL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@" paiming---%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                degree.ticai = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"json-----%@",json);
                NSMutableString *ticai;
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dict in json[@"gsgmjlr"]) {
                    if ([degree.stock_nm isEqualToString:dict[@"jc"]]) {
                        degree.gsgmjlr = dict[@"jlr"];
                        degree.gsgmzsz = dict[@"zsz"];
                        degree.gsgmltsz = dict[@"ltsz"];
                        degree.gsgmyysr = dict[@"yysr"];
                        degree.gsgmjlr_pm = dict[@"pm"];
                    }
                }
                
                for (NSDictionary *dict in json[@"gsgmyysr"]) {
                    if ([degree.stock_nm isEqualToString:dict[@"jc"]]) {
//                        degree.gsgmjlr = dict[@"jlr"];
//                        degree.gsgmzsz = dict[@"zsz"];
//                        degree.gsgmlgsz = dict[@"lgsz"];
//                        degree.gsgmyysr = dict[@"yysr"];
                        degree.gsgmyysr_pm = dict[@"pm"];
                    }
                }
                for (NSDictionary *dict in json[@"gsgmltsz"]) {
                    if ([degree.stock_nm isEqualToString:dict[@"jc"]]) {
//                        degree.gsgmjlr = dict[@"jlr"];
//                        degree.gsgmzsz = dict[@"zsz"];
//                        degree.gsgmltsz = dict[@"lgsz"];
//                        degree.gsgmyysr = dict[@"yysr"];
                        degree.gsgmltsz_pm = dict[@"pm"];
                    }
                }
                //如何纵向观察一个数组
                NSLog(@"jyscbm=%@,zqdm=%@,zqjc=%@,zqnm=%@",[[temp valueForKey:@"jyscbm"] componentsJoinedByString:@","],[[temp valueForKey:@"zqdm"] componentsJoinedByString:@","],[[temp valueForKey:@"zqjc"] componentsJoinedByString:@","],[[temp valueForKey:@"zqnm"] componentsJoinedByString:@","]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [XMGSqliteModelTool saveOrUpdateModel:degree uid:@"Degree"];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"ticai - 失败");
                
            }];

            
            NSString *ticaiUrl = [NSString stringWithFormat:@"http://f10.eastmoney.com/CoreConception/CoreConceptionAjax?code=%@",degree.stock_id];
//            degree.ticai
//            [self testAPIWithAFN];
//            dispatch_async(dispatch_get_main_queue(), ^{
            [[BaseNetManager defaultManager] GET:ticaiUrl parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"题材---%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
                degree.ticai = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                NSLog(@"json-----%@",json);
                NSMutableString *ticai;
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dict in json[@"hxtc"]) {
                    YYTicaiModel *ticaiModel = [[YYTicaiModel alloc] init];
                    [ticaiModel setValuesForKeysWithDictionary:dict];
                    
                    if ([ticaiModel.yd isEqualToString:@"1"]) {
                        degree.ssbk = ticaiModel.ydnr;
                    }
                    
                    [temp addObject:ticaiModel];
                }
                
                [temp valueForKey:@"ydnr"];
                degree.ticai = ticai;
                degree.ticaiNumbers = [[temp valueForKey:@"yd"] componentsJoinedByString:@","];
                degree.ticaiBrief = [[temp valueForKey:@"gjc"] componentsJoinedByString:@","];
                degree.ticaiDetail = [[temp valueForKey:@"ydnr"] componentsJoinedByString:@","];
                //如何纵向观察一个数组   
                NSLog(@"jyscbm=%@,zqdm=%@,zqjc=%@,zqnm=%@",[[temp valueForKey:@"jyscbm"] componentsJoinedByString:@","],[[temp valueForKey:@"zqdm"] componentsJoinedByString:@","],[[temp valueForKey:@"zqjc"] componentsJoinedByString:@","],[[temp valueForKey:@"zqnm"] componentsJoinedByString:@","]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [XMGSqliteModelTool saveOrUpdateModel:degree uid:@"Degree"];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"ticai - 失败");
                
            }];
//            });
            
            degree.bond_Degree = [NSString stringWithFormat:@"%f",degree.volume.floatValue/degree.curr_iss_amt.floatValue];
            
            degree.stock_Degree = [NSString stringWithFormat:@"%f",degree.svolume.floatValue/degree.curr_iss_amt.floatValue];
            
            degree.stock_id = [NSString stringWithFormat:@"%@-%@",degree.stock_id,dateStr];
            degree.currentEnergyFlow = [NSString stringWithFormat:@"%f",degree.volume.floatValue/degree.increase_rt.floatValue];
            degree.scurrentEnergyFlow = [NSString stringWithFormat:@"%f",degree.svolume.floatValue/degree.sincrease_rt.floatValue];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [XMGSqliteModelTool saveOrUpdateModel:degree uid:@"Degree"];
            });
            
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            float ratio = (stockModel.full_price.floatValue - stockModel.convert_value.floatValue)/stockModel.convert_value.floatValue;
            stockModel.ratio = ratio;
            stockModel.convertToStockRatio = stockModel.curr_iss_amt.floatValue / stockModel.orig_iss_amt.floatValue;
            
            stockModel.ma20_SI = stockModel.sprice.floatValue / stockModel.convert_price.floatValue;
            stockModel.ma20_BI = stockModel.full_price.floatValue / stockModel.convert_value.floatValue;
            
            
            float stockRatio= (stockModel.sprice.floatValue - stockModel.convert_price.floatValue)/stockModel.convert_price.floatValue;
            stockModel.stockRatio = stockRatio;
            
            stockModel.passConvert_dt_days = [NSString stringWithFormat:@"%ld",[YYDateUtil calculateToTodayDays:stockModel.convert_dt]]; ;
            
            stockModel.stockURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml",stockModel.stock_id];
            stockModel.stockConceptURL = [NSString stringWithFormat:@"http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_CorpOtherInfo/stockid/%@/menu_num/5.phtml",[stockModel.stock_id substringFromIndex:@"sh".length]];
            //
            stockModel.bondURL = [NSString stringWithFormat:@"http://money.finance.sina.com.cn/bond/quotes/%@.html",stockModel.pre_bond_id];
            stockModel.stockMainBusinessURL = [NSString stringWithFormat:@"http://stockpage.10jqka.com.cn/%@/operate/",[stockModel.stock_id substringFromIndex:@"sh".length]];
            //http://stockpage.10jqka.com.cn/300407/operate/
            stockModel.stockGongGaoURL = [NSString stringWithFormat:@"https://www.jisilu.cn/data/stock/%@",[stockModel.stock_id substringFromIndex:@"sh".length]];
            
            if ([self.holdingPonds containsObject:stockModel.bond_nm]) {
                NSString *keyElements = [NSString stringWithFormat:@"[m20_SI=%f/CP=%@/BP=%@]",stockModel.ma20_SI,stockModel.convert_price,stockModel.full_price];
                [dictToPlist setValue:keyElements forKey:stockModel.bond_nm];
            }
            
            NSString *keyElements = [NSString stringWithFormat:@"[m20_SI=%f/CP=%@/BP=%@]",stockModel.ma20_SI,stockModel.convert_price,stockModel.full_price];
            [allToPlist setValue:keyElements forKey:stockModel.bond_nm];
            if (stockModel.full_price.floatValue < 105) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self handleSingleStock:stockModel.stock_id];
                });
            }
            
            {
                NSString *url = [NSString stringWithFormat:@"http://stock.jrj.com.cn/action/gudong/getGudongDataByCode.jspa?vname=stockgudongData&stockcode=%@&_=1569474620679",[stockModel.stock_id substringFromIndex:2]];
                NSDate *date = [NSDate date];
                NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
                [BaseNetManager GET:url parameters:nil complationHandle:^(id responseObject, NSError *error) {
                    
                    NSString *holdCountStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSString *holdCountStrJson = [holdCountStr componentsSeparatedByString:@"="].lastObject;
                    //        id json =[NSJSONSerialization JSONObjectWithData:[houldCountStrJson dataUsingEncoding:NSUTF8StringEncoding] options:nil error:nil];
                    NSLog(@"houldCountStrJson---%@-stockid=%@",holdCountStrJson,stockModel.stock_id);
                    for (YYStockModel *m in self.stocks) {
                        if ([m.stock_id isEqualToString:stockModel.stock_id]) {
                            m.holdCountStrJson = holdCountStrJson;
                        }
//                        [XMGSqliteModelTool saveOrUpdateModel:m uid:dateStr];
                    }
                    [[NSUserDefaults standardUserDefaults] setValue:holdCountStrJson forKey:stockModel.stock_id];
                    
                }];
            }
            
             /*************************************日志管理********1.SI > 9************************************/
//            NSRange range = [stockModel.sincrease_rt rangeOfString:@"."];
//            float tempIncrease = [stockModel.sincrease_rt substringToIndex:range.location].floatValue;
//            if (tempIncrease > 5 && stockModel.full_price.floatValue < 115) {
//                [[SMLogManager sharedManager] Tool_logPlanName:@"SI大于5&BP<115" targetStockName:stockModel.stock_nm currentStockPrice:stockModel.sprice currentBondPrice:stockModel.full_price whenToVerify:@"一月内" comments:@" 不要追涨？  要高抛  行情启动or挖坑 115为蓝思"];
//            }
//
//            if (tempIncrease <= -5) {
//                [[SMLogManager sharedManager] Tool_logPlanName:@"SI小于负5&BP<110" targetStockName:stockModel.stock_nm currentStockPrice:stockModel.sprice currentBondPrice:stockModel.full_price whenToVerify:@"一月内" comments:@"过激反应？ 不要杀跌   要低吸 "];
//            }
//
//            if (tempIncrease >= 9 && stockModel.full_price.floatValue < 110) {
//                [[SMLogManager sharedManager] Tool_logPlanName:@"SI > 9 history" targetStockName:stockModel.stock_nm currentStockPrice:stockModel.sprice currentBondPrice:stockModel.price whenToVerify:@"两三天内回调" comments:@"两三天后回调低吸 华通and三力，即便诱多价也在110以下！ 三力-确实工业大麻很给力，老挝。  华通？确实有公告！ 二者在110以下都可以建仓，都是小盘，都很活跃！！！ 看到9.29！ 亚太、久其"];
//                //按照该策略，可以建仓亚太了！   股价涨停，有预期。-----内部有大的利好，还未公布而已！一月可期！ 而转债回调了第4天了。刚好回调到了30%。
//            }
//
//            if (tempIncrease >=9.00) {
//                NSString *keyInfo = [NSString stringWithFormat:@"BP=%@",stockModel.full_price];
//                [SIBigger10dictPlist setValue:keyInfo forKey:[stockModel.stock_nm stringByAppendingString:dateStr]];
//            }
//
//            if (tempIncrease >= 9.00 && stockModel.increase_rt.floatValue < 0.9) {//0.9即0.9%
//                YYMockBuyModel *mockBuy = [[YYMockBuyModel alloc] init];
//                mockBuy.bond_id = [stockModel.bond_id stringByAppendingString:dateStr];
//                mockBuy.buyPrice = stockModel.full_price;
//                mockBuy.buyCount = 100;
//                mockBuy.cost = mockBuy.buyPrice.floatValue * mockBuy.buyCount;
//                mockBuy.buyIntoTime = dateStr;
//
//                [XMGSqliteModelTool saveOrUpdateModel:mockBuy uid:@"mockExchange"];
//            }
           
            //股价涨幅  远大于 债涨幅  启动迹象！！！
            if (stockModel.sprice.floatValue - stockModel.convert_price.floatValue < 1.00
                && stockModel.sprice.floatValue - stockModel.convert_price.floatValue > 0
                && stockModel.full_price.floatValue < 110) {
                //               //无需及时
                //选债四步1：面值附近攻防兼备， 铁律：110以下！
                //第二步：转股价接近正股价，上涨给力！！
                //                第3步：一般都是2，3年，大股东会整很多概念！ 好多利好消息。
                //                第4步：小盘债比大盘债弹性大！！！相对确定！ 顶：公告+140     底部：100，110以下。    ------吉视
                //代码化
                [[SMLogManager sharedManager] Tool_logPlanName:@"0<SP-CP<1&BP<110" targetStockName:stockModel.stock_nm currentStockPrice:stockModel.sprice currentBondPrice:stockModel.full_price whenToVerify:@"一周内" comments:@"热点板块叠加！"];
            }
            
            
            /*************************************通知管理********************************************/
            if ([stockModel.bond_nm isEqualToString:@"G三峡EB"] && stockModel.full_price.intValue < 107) {
                [[LocalNotificationManager sharedNotificationManager] Tool_testLoaclNotification:@"三峡债"];//相近的价格，相类似的走势。过往走势
            }
            
            //监控利欧     周策略
            if ([stockModel.bond_nm isEqualToString:@"利欧转债"] && stockModel.full_price.intValue < 110) {
                [[LocalNotificationManager sharedNotificationManager] Tool_testLoaclNotification:@"利欧转债"];
            }
            
            //卖出通知
            if ([self.watchPond containsObject:stockModel.bond_nm] && stockModel.full_price.floatValue * stockModel.increase_rt.floatValue < -10) {
                [[LocalNotificationManager sharedNotificationManager] Tool_testLoaclNotification:[stockModel.bond_nm stringByAppendingString:@"%@---降幅大于了10"]];
            }
            
            NSArray *SIbigger9Array = [XMGSqliteModelTool queryModels:[YYSingleStockModel class] WithSql:@"select timeStamp,p_change from YYSingleStockModel where p_change > 9" uid:stockModel.stock_id];
            
            if (SIbigger9Array.count > 0) {
                 [[SMLogManager sharedManager] Tool_logPlanName:@"countOfSI>9" targetStockName:stockModel.stock_nm currentStockPrice:[[SIbigger9Array valueForKey:@"timestamp"] componentsJoinedByString:@"-"] currentBondPrice:[NSString stringWithFormat:@"%d个",SIbigger9Array.count] whenToVerify:[[SIbigger9Array valueForKey:@"p_change"] componentsJoinedByString:@"-"] comments:@"统计个数"];
                
                stockModel.SIBibber9Count = SIbigger9Array.count;
            }
           /*************************************通知管理********************************************/
            
           //日历
            
            //策略：非转股期的最高价？    当前的价格比较低的标的？？？    利尔？
            //数组中的对象如何存储？？？？      转股期
            //打新策略---非转股期-首日下午或者第二天卖出
            
            //价格比较低的才是价值投资？  6年？？？？？？
            //强者恒强 ----宁行和金农   而价格较低的必然是弱势的   三力
            //强赎里面选取强势的。。。才有动力。  也得看大盘的配合。但是至少能知道情况。
            //目标： 130~150，160    成本？？？
            //按照价格最低的思路去挑选标的，选到的总是最弱势的。。。
            
            
            //属于强赎的     -----确保了强势的！
            //价格最低的。。。 -----成本低。
            //回调到110，大盘比较弱 + 盈利预期不好？  大股东故意释放的利空消息？  道氏 利空，却涨停。
            
            
            [temp addObject:stockModel];
            
            
            //所有的数据存在一个库里
            {
                //主键的唯一性----------查询历史价格， 趋势， 比分库查询应该会好很多。特别是个股走势！
                stockModel.bond_id = [NSString stringWithFormat:@"%@-%@",stockModel.bond_id,dateStr];
                stockModel.saveDate = dateStr;
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"allBondData"];
            }
            
            //日期分库存储
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:dateStr];
                //
                
                
                NSArray *sqliteArray = @[@"2019-09-06",@"2019-09-02",@"2019-09-03",@"2019-09-04",@"2019-09-05",];
                
                //对既有的历史数据作一些统计----------耗时操作
//                for (NSString *uid in sqliteArray) {
//                    NSArray *uidArray = [XMGSqliteModelTool queryAllModels:[YYStockModel class] uid:uid];
//                    for (YYStockModel *m in uidArray) {
//                        if (m.sincrease_rt.floatValue > m.increase_rt.floatValue) {
//                            m.bond_id = [NSString stringWithFormat:@"%@-%@",m.bond_id,uid];
//                            [XMGSqliteModelTool saveOrUpdateModel:m uid:@"SIFasterBI"];
//                        }
//                    }
//                }
                
                if (stockModel.sincrease_rt.floatValue > stockModel.increase_rt.floatValue) {
                    stockModel.bond_id = [NSString stringWithFormat:@"%@-%@",stockModel.bond_id,dateStr];
                    [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"SIFasterBI"];
                }
                
            });
        }
        //http://stock.jrj.com.cn/action/gudong/getGudongDataByCode.jspa?vname=stockgudongData&stockcode=600519&_=1569474620679
        
        
        NSArray *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *holdingDirectory = [[libPath objectAtIndex:0] stringByAppendingPathComponent:@"FocusLog"];
        NSString *holdingFilePath = [holdingDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"holding.plist"]];
        [dictToPlist writeToFile:holdingFilePath atomically:YES];

        NSString *allFilePath = [holdingDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"all.plist"]];
        [allToPlist writeToFile:allFilePath atomically:YES];

        NSString *SIBigger10FilePath = [holdingDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SIBigger10.plist"]];
        [SIBigger10dictPlist writeToFile:SIBigger10FilePath atomically:YES];
        
        self.stocks = temp;
        
        
        [self.stockView reloadStockView];
    }];
}

- (void)handleMutilLine:(YYStockModel *) stockModel{//处理写入和读取导致的问题
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [documentPath stringByAppendingPathComponent:@"test2.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    if (![db isOpen]) {
        return;
    }
    BOOL result = [db executeUpdate:@"CREATE TABLE YYStockModel(stock_nm text,put_price text,stock_cd text,sqflg text,year_left text,stockURL text,bond_id text,repo_valid_from text,list_dt text,put_total_days text,full_price text,active_fl text,redeem_count_days text,ration_cd text,convert_cd text,put_count_days text,ratio real,qflag text,bondURL text,curr_iss_amt text,maturity_dt text,redeem_dt text,redeem_real_days text,volume text,btype text,put_inc_cpn_fl text,issue_dt text,next_put_dt text,force_redeem text,ration text,put_convert_price_ratio text,force_redeem_price text,price text,redeem_tc text,owned text,passConvert_dt_days text,pre_bond_id text,adq_rating text,stock_id text,put_real_days text,ytm_rt text,convert_price text,repo_cd text,ytm_rt_tax text,bond_nm text,noteDate text,repo_valid_to text,redeem_price_ratio text,convert_dt text,rating_cd text,stockRatio real,convert_amt_ratio text,cpn_desc text,left_put_year text,ration_rt text,guarantor text,redeem_total_days text,repo_discount_rt text,repo_valid text,put_tc text,redeem_price text,increase_rt text,premium_rt text,convert_value text,market text,price_tips text,adjust_tc text,pb text,real_force_redeem_price text,short_maturity_dt text,last_time text,stock_amt text,put_dt text,sincrease_rt text,stock_net_value text,pinyin text,sprice text,apply_cd text,orig_iss_amt text,online_offline_ratio text,redeem_inc_cpn_fl text,put_convert_price text, primary key(bond_id));"];
    if (!result) {
        return;
    }
    NSLog(@"create table = %@",[NSThread currentThread]);
    
    NSDate *date = [NSDate date];
    NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
    //测试开启多个线程操作数据库
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        
        stockModel.bond_id = [NSString stringWithFormat:@"%@-%@",stockModel.bond_id,dateStr];
        NSString *sql = [NSString stringWithFormat:@"select stockMostPrice,bondMostPrice from YYStockModel where bond_id = %@;",stockModel.bond_id];
        NSArray *mostPriceS = [XMGSqliteModelTool queryModels:[YYStockModel class] WithSql:sql uid:@"allData"];
        if (mostPriceS.count > 0 && [[[mostPriceS valueForKey:@"sprice"] firstObject] floatValue] < stockModel.sprice.floatValue) {
            stockModel.stockMostPrice = stockModel.sprice;
        }else{
            stockModel.stockMostPrice = stockModel.sprice;
        }
        
        [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"test2.db"];
        
//        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@10,@"name":@"10",@"age":@10}];
//        if (result) {
//            NSLog(@"在group insert 10 success");
//        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@11,@"name":@"11",@"age":@11}];
        if (result) {
            NSLog(@"在group insert 11 success");
        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_async(group, queue, ^{
        BOOL result = [db executeUpdate:@"insert into text3(ID,name,age) values(:ID,:name,:age)" withParameterDictionary:@{@"ID":@12,@"name":@"12",@"age":@12}];
        if (result) {
            NSLog(@"在group insert 12 success");
        }
        NSLog(@"current thread = %@",[NSThread currentThread]);
        
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
        NSLog(@"current thread = %@",[NSThread currentThread]);
        BOOL result = [db executeQuery:@"select * from text3 where ID = ?",@(10)];
        if (result) {
            NSLog(@"query 10 success");
        }
        BOOL result2 = [db executeQuery:@"select * from text3 where ID = ?",@(11)];
        if (result2) {
            NSLog(@"query 11 success");
        }
        BOOL result3 = [db executeQuery:@"select * from text3 where ID = ?",@(12)];
        if (result3) {
            NSLog(@"query 12 success");
        }
        
    });
    
}

//https://xian.newhouse.fang.com/sales/
//http://www.sse.com.cn/market/bonddata/convertible/
/**
 //http://query.sse.com.cn/commonQuery.do?jsonCallBack=jsonpCallback58699&isPagination=true&YEAR=&CVTBOND_CODE=&sqlId=COMMON_SSE_ZQ_TJSJ_ZXTJ_KZZZGTJ_L&pageHelp.pageSize=10&pageHelp.pageNo=1&pageHelp.beginPage=1&pageHelp.cacheSize=1&pageHelp.endPage=6&_=1553501700996
 */
-(void)testResultOfAPI{
    //https://xueqiu.com/snowman/S/SH600031/detail#/GDRS
    //https://xueqiu.com/snowman/S/SH600031/detail#/GDRS
    //http://www.sse.com.cn/market/bonddata/convertible/
    //http://finance.sina.com.cn/realstock/company/sh600031/nc.shtml?from=BaiduAladin
    //https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1554699154321
    //https://stock.xueqiu.com/v5/stock/f10/cn/holders.json?symbol=SH600031&extend=true&page=1&size=10  股东人数
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodeData?page=1&num=40&sort=symbol&asc=1&node=chgn_700234&symbol&_s_r_a=init"]];
    [request2 setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
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
//http://www.sse.com.cn/market/bonddata/convertible/
//http://vip.stock.finance.sina.com.cn/quotes_service/api/json_v2.php/Market_Center.getHQNodeData?page=1&num=40&sort=symbol&asc=1&node=chgn_700234&symbol&_s_r_a=init
-(void)testAPIWithAFN{
    //发行流程：董事会预案 → 股东大会批准 → 证监会受理 → 发审委通过 → 证监会核准批文 → 发行公告
    //https://www.jisilu.cn/data/cbnew/pre_list/?___jsl=LST___t=1566207894005
    //http://stock.jrj.com.cn/action/gudong/getGudongDataByCode.jspa?vname=stockgudongData&stockcode=600519&_=1569474620679
    [[BaseNetManager defaultManager] GET:@"http://f10.eastmoney.com/CoreConception/CoreConceptionAjax?code=sz002851" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFN ----responseObject----%@",responseObject);
        
        NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:nil]);
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:nil];
        str = [str substringFromIndex:@"IO.XSRV2.CallbackList['b4VIm$HArIJ1qfKO']".length];
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"()[]"];
        str = [str stringByTrimmingCharactersInSet:set];
        
        NSArray *strArray = [str componentsSeparatedByString:@"},{"];
        NSDate *date = [NSDate date];
        NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
        for (NSString *string in strArray) {
            NSString *formartStr;
            if ([string containsString:@"{"]) {
                
                formartStr = [NSString stringWithFormat:@"\@\"%@}\"",string];
                
            }else if ([string containsString:@"}"]){
                formartStr = [NSString stringWithFormat:@"\@\"{%@\"",string];
            }else{
                formartStr = [NSString stringWithFormat:@"\@\"{%@}\"",string];
            }
            
            NSArray *targetArray = [formartStr componentsSeparatedByString:@","];
            
            
            YYMarketValueAndTureOver *marketModel = [[YYMarketValueAndTureOver alloc] init];
            
            NSString *targetStr1 = [NSString stringWithFormat:@"%@",targetArray[1]];
            NSString *targetStr2 = [NSString stringWithFormat:@"%@",targetArray[2]];
            NSString *targetStr13 = [NSString stringWithFormat:@"%@",targetArray[13]];
            
            NSString *targetStr20 = [NSString stringWithFormat:@"%@",targetArray[20]];
            NSCharacterSet *set2 = [NSCharacterSet characterSetWithCharactersInString:@"\"\"\""];
            targetStr1 = [targetStr1 stringByTrimmingCharactersInSet:set2];
            targetStr2 = [targetStr2 stringByTrimmingCharactersInSet:set2];
            targetStr13 = [targetStr13 stringByTrimmingCharactersInSet:set2];
            targetStr20 = [targetStr20 stringByTrimmingCharactersInSet:set2];
            marketModel.code = [targetStr1 substringFromIndex:@"code:".length];
            marketModel.name = [targetStr2 substringFromIndex:@"name:".length];
            
            marketModel.amount = [targetStr13 substringFromIndex:@"amount:".length];
            marketModel.nmc = [targetStr20 substringFromIndex:@"nmc:".length];
            
            marketModel.date = dateStr;
            marketModel.symbol = [NSString stringWithFormat:@"%@-%@",marketModel.code,dateStr];
            
            [XMGSqliteModelTool saveOrUpdateModel:marketModel uid:@"marcketActive"];
            /*
        symbol:"sh601398",code:"601398",name:"¹¤ÉÌÒøÐÐ",trade:"5.910",pricechange:"0.000",changepercent:"0.000",buy:"5.900",sell:"5.910",settlement:"5.910",open:"5.950",high:"5.960",low:"5.880",volume:"137713429",amount:"813806686",ticktime:"15:00:06",per:7.207,per_d:6.8,nta:"6.7900",pb:0.87,mktcap:210636097.9396,nmc:159340817.61055,turnoverratio:0.05108
             */
            
        }
        
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"json-----%@",json);
        
        for (NSDictionary *dic in json[@"rows"]) {
            YYAnotherWatchPondStock *m = [[YYAnotherWatchPondStock alloc] init];
            [m setValuesForKeysWithDictionary:dic[@"cell"]];

            //中百 < 7建仓。     6.5 加仓2成。     6加仓 5成
            if ([m.stock_nm isEqualToString:@"中百集团"] && m.price.floatValue < 7.0) {
                [LocalNotificationManager addLocalNotification:[NSString stringWithFormat:@"中百 股价 到了 %@",m.price]];
            }
            [XMGSqliteModelTool saveOrUpdateModel:m uid:@"yaoyue"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error-----%@",error);
        }
    }];
    
}

-(void)p_checkSum{
    
//    [self.stocks insertObjects:self.watchPond atIndexes:0];
    
    [self.stocks removeObjectsInArray:self.watchPond];
    
    for (YYStockModel *m in self.watchPond) {
        [self.stocks insertObject:m atIndex:0];
    }
    [self.stockView reloadStockView];
}

-(void)p_redeem{
    
    YYSelfCollectViewController *collectVC = [[YYSelfCollectViewController alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"redeem_real_days > 0"];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:collectVC];
    [self presentViewController:nav animated:NO completion:nil];
    
}

-(void)p_refresh{
    if (self.isSearch) {
        self.isSearch = NO;
        [self.stockView reloadStockView];
    }
    
    [self.stocks addObjectsFromArray:self.watchPond];
    [self.stockView reloadStockView];
}

-(void)p_caledar{
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
//    web.targetUrl = @"https://www.jisilu.cn/data/calendar/";
//    web.bigPrice = @"下调转修会";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
}

-(void)p_calenar{
    
    YYHoldingViewController *holdingVC = [[YYHoldingViewController alloc] init];
    [self.navigationController pushViewController:holdingVC animated:YES];
//    WillBondViewController *web = [[WillBondViewController alloc] init];
//    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
}

-(void)p_saoYiSao{
    
}

-(void)handleSingleStock:(NSString *)stockid{
    ///Users/g/Documents/GitHub/python/02 StockData/01 IntradayCN
    
    NSString *stockPath = @"Users/g/Documents/GitHub/python/02 StockData/01 IntradayCN";
    
    NSString *readFilePath = [NSString stringWithFormat:@"%@/%@.csv",stockPath,[stockid substringFromIndex:@"sh".length]];
    NSLog(@"writing data to sqlite %@",readFilePath);
    NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:readFilePath];
    NSData *currentData = [readFile readDataToEndOfFile];
    NSString *currentStr = [[NSString alloc] initWithData:currentData encoding:NSUTF8StringEncoding];
//    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:currentData options:NSJSONReadingMutableContainers error:nil];
    NSArray *History = [currentStr componentsSeparatedByString:@"\n"];
    int p_changeCount = 0;
    YYSingleStockModel *singleM = [[YYSingleStockModel alloc] init];
    for (int i = 0; i< History.count ; i++) {
         NSArray *record = [History[i] componentsSeparatedByString:@","];
        if (record.count < 10) {
            continue;
        }
        for (int i = 0; i < record.count; i++) {
            if ([record[0] isEqualToString:@"timestamp"]) {
                continue;
            }
            singleM.timestamp = record[0];
            singleM.open = [record[1] floatValue];
            singleM.high = [record[2] floatValue];
            singleM.close = [record[3] floatValue];
            singleM.low = [record[4] floatValue];
            singleM.volume = [record[5] floatValue];
            
            singleM.price_change = [record[6] floatValue];
            singleM.p_change = [record[7] floatValue];
            singleM.ma5 = [record[8] floatValue];
            singleM.ma10 = [record[9] floatValue];
            singleM.ma20 = [record[10] floatValue];
            if (singleM.p_change > 9) {
                p_changeCount++;
            }
            
            singleM.v_ma5 = [record[11] floatValue];
            singleM.v_ma10 = [record[12] floatValue];
            singleM.v_ma20 = [record[13] floatValue];
            
//            singleM.turnover = [record[14] floatValue];
        }
       
        
        
        [XMGSqliteModelTool saveOrUpdateModel:singleM uid:stockid];
    }
    
//
}

#pragma mark - 根据传入的文件名称,拼接全路径并返回!
- (NSString *)filePathWithFileName:(NSString *)fileName {
    
    // 1.获取docPath
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    // 2.拼接
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    
    // 3.返回
    return filePath;
    
}


-(NSMutableArray *)watchPond{
    if (!_watchPond) {
        _watchPond = [NSMutableArray array];
    }
    return _watchPond;
}

-(NSMutableArray *)headMatchContents{
    if (!_headMatchContents) {
        _headMatchContents = [NSMutableArray array];
    }
    return _headMatchContents;
}


-(NSMutableArray *)holdingPonds{
    if (!_holdingPonds) {//下一个利欧 or 圣达  111
        _holdingPonds = [NSMutableArray arrayWithObjects:@"圣达转债",@"利欧转债",@"杭电转债",@"道氏转债", nil];
    }
    return _holdingPonds;
}

//@"债价",@"债涨跌幅",@"股价",@"股涨跌幅"(统计个数),/@"回售(触发)价",@"转股价",@"强赎触发价",,/
//@"卖出参考"：@"股价偏离度",@"转股溢价率",@"强天数",@"剩余年限",@"剩余规模",
//@"买入参考"：@"评级-到期赎回价-转股起始日"   /@"S-K线图",@"K线图",@"公告",@"主营业务",@"概念",/

-(NSArray *)headTitles{
    if (!_headTitles) {//单独的可排序
        _headTitles = [NSArray arrayWithObjects:@"债价/成本",@"债涨跌幅",@"股价",@"股涨跌幅",@"回售触发)价",@"转股价",@"强赎触发价",@"卖出参考:",@"股价偏离度",@"转股溢价率",@"转股占比",@"强天数",@"距转股天数",@"剩余年限",@"剩余规模",@"成交额",@"活跃度",@"s活跃度",@"买入参考:",@"评级-涨停个数",@"到期回售价",@"转股起始日",@"股价K线图",@"债K线图",@"公告",@"主营业务",@"概念",@"历史数据",nil];
    }
    return _headTitles;
}

-(NSMutableArray *)headMatchContent:(NSInteger)index{

    [self.headMatchContents removeAllObjects];
    YYStockModel *model = self.isSearch == YES? self.searchResults[index] : self.stocks[index];
    NSArray *mockArray = [XMGSqliteModelTool queryAllModels:[YYMockBuyModel class] uid:@"mockExchange"];
    for (YYMockBuyModel *mockModel in mockArray) {
        if ([[mockModel.bond_id substringToIndex:6] isEqualToString:[model.bond_id substringToIndex:6]]) {
            model.full_price = [NSString stringWithFormat:@"%@/%@",model.full_price,mockModel.buyPrice];
        };
    }
    [self.headMatchContents addObject:model.full_price];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@",model.increase_rt]];
    [self.headMatchContents addObject:model.sprice];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@",model.sincrease_rt]];
    [self.headMatchContents addObject:model.put_convert_price];
    
    [self.headMatchContents addObject:model.convert_price];
    [self.headMatchContents addObject:model.force_redeem_price];
    [self.headMatchContents addObject:@"对比"];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.ma20_SI]];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.ratio]];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.convertToStockRatio]];//
    
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@-%@",model.redeem_real_days,model.redeem_total_days,model.redeem_count_days]];
     [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@",model.passConvert_dt_days,model.convert_dt]];
    [self.headMatchContents addObject:model.year_left];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@/%@",model.curr_iss_amt,model.orig_iss_amt] ];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%@",model.volume] ];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.volume.floatValue/model.curr_iss_amt.floatValue] ];
    [self.headMatchContents addObject:[NSString stringWithFormat:@"%f",model.svolume.floatValue/model.curr_iss_amt.floatValue] ];
    
    
    [self.headMatchContents addObject:@""];
    [self.headMatchContents addObject:[model.rating_cd stringByAppendingFormat:@"%d个",model.SIBibber9Count]];
    [self.headMatchContents addObject:model.redeem_price];
     [self.headMatchContents addObject:model.convert_dt];
    
    [self.headMatchContents addObject:@"股价K线图"];
    [self.headMatchContents addObject:@"债K线图"];
    [self.headMatchContents addObject:@"公告"];
    [self.headMatchContents addObject:model.stockMainBusiness ?: @"主营业务"];
    if (!model.stockConcept) {
        model.stockConcept = [[NSUserDefaults standardUserDefaults] objectForKey:model.stock_nm];
    }
    [self.headMatchContents addObject:model.stockConcept ?: @"概念"];
    [self.headMatchContents addObject:@"BondHistory"];
//   return [NSMutableArray arrayWithObjects:model.full_price,model.increase_rt,model.sprice,model.sincrease_rt,model.put_convert_price,model.convert_price,model.force_redeem_price,@"",model.ma20_SI,model.redeem_count_days,model.year_left,model.curr_iss_amt,@"",[NSString stringWithFormat:@"%@-%@-%@",model.ration_cd,model.redeem_price,model.convert_dt],@"股价K线图",@"债K线图",@"公告",@"主营业务",@"概念", nil];
    
//        self.headMatchContents = [NSArray arrayWithObjects:model.full_price,model.increase_rt,model.sprice,model.sincrease_rt,model.put_convert_price,model.convert_price,model.force_redeem_price,@"",model.ma20_SI,model.redeem_count_days,model.year_left,model.curr_iss_amt,@"",[NSString stringWithFormat:@"%@-%@-%@",model.ration_cd,model.redeem_price,model.convert_dt],@"股价K线图",@"债K线图",@"公告",@"主营业务",@"概念", nil].mutableCopy;
//    }
//    return _headMatchContents;
    return  self.headMatchContents;
}

@end
