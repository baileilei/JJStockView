//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "DemoViewController.h"
#import "YYStockModel.h"
#import "XMGSqliteModelTool.h"

#import "YYBuyIntoViewController.h"
#import "YYWebViewController.h"
#import "YYKLineWebViewController.h"

#import "XMGSessionManager.h"
#import "BaseNetManager.h"

#import "YYCheckWebViewController.h"

#import "YYDateUtil.h"

#import "YYSerachViewController.h"
#import "WSDatePickerView.h"
#import "LocalNotificationManager.h"
#import "YYSelfCollectViewController.h"

#import "HNNetworkFooterView.h"

#import "YYBuyintoStockModel.h"

#define columnCount 18
#define kYYCachePath @"/Users/g/Desktop"

#define oneHour 60 * 60

#define halfAnHour 60 * 30

#define everyTenMinutes 60 * 10

static int AllCount = 1;

@interface DemoViewController ()<StockViewDataSource,StockViewDelegate,UISearchBarDelegate>


@property (nonatomic,strong) NSMutableDictionary *collectDict;

@property (nonatomic, strong) NSMutableArray *searchResults;

@property (assign,nonatomic) BOOL isSearch;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DemoViewController

#pragma mark - 懒加载返回数据定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:halfAnHour target:self selector:@selector((onTimer:)) userInfo:nil repeats:YES];
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
    
//    [self p_testLoaclNotification];
//    [self testResultOfAPI];
//    [self testAPIWithAFN];
    self.searchResults = [NSMutableArray array];
    
    self.collectDict = [[NSMutableDictionary alloc] init];
    
    self.isSearch = NO;
    
    [self testAPIWithAFN];
    [self requestData];
    self.navigationItem.title = @"股票表格";
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入名称、代码";
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
    
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    HNNetworkFooterView *header = [[HNNetworkFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    //SELECT sprice - convert_price, bond_nm,full_price from YYStockModel where sprice - convert_price > 0 ORDER BY sprice - convert_price;
    //投资模型！   变量因子：时间，股价差。 目的：转债。
    header.titleLable.text = @"看板：圆通转债 9个月了  等待圣达回调 110。适当回调。 建立模型，125？估值？？？ 三峡？";
    self.stockView.jjStockTableView.tableHeaderView = header;
    [self.view addSubview:self.stockView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查看" style:UIBarButtonItemStyleDone target:self action:@selector(p_checkSum)];
    
     UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"强赎" style:UIBarButtonItemStyleDone target:self action:@selector(p_redeem)];
    
    NSString *resourceBundel = [[NSBundle mainBundle] pathForResource:@"Resource.bundle" ofType:nil];
    NSString *pathStr = [[NSBundle bundleWithPath:resourceBundel] pathForResource:@"更新.png" ofType:nil inDirectory:@"images"];
    NSLog(@"pathStr----%@",pathStr);
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:pathStr] style:UIBarButtonItemStyleDone target:self action:@selector(p_calenar)];
    //[[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStyleDone target:self action:@selector(p_calenar)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1,rightItem2];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(p_refresh)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.collectDict = [[NSMutableDictionary alloc] init];
    
    [self.timer setFireDate:[NSDate date]];
    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
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
    NSLog(@"%@",self.searchResults);
    
//    self.searchResults = [XMGSqliteModelTool queryModels:[YYStockModel class] columnName:@"full_price" relation:ColumnNameToValueRelationTypeEqual value:searchBar.text uid:@"Mystock"];
    
    [self.stockView reloadStockView];
    [self.view endEditing:YES];
    [searchBar resignFirstResponder];
    searchBar.text = nil;
}
//-searchbare

#pragma mark - Stock DataSource
//多少行
- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.isSearch == YES? self.searchResults.count : self.stocks.count;
}
//左侧显示什么名称
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    YYStockModel *model = self.isSearch == YES? self.searchResults[row] : self.stocks[row];
//    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text = [NSString stringWithFormat:@"%@",model.bond_nm];
    
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
//内容   尚荣 利欧   特一    bug跳转      
- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, columnCount * 100, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    for (int i = 0; i < columnCount; i++) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        YYStockModel *model = self.isSearch == YES? self.searchResults[row] : self.stocks[row];;
        NSString *btnTitle = nil;
        float ratio = (model.full_price.floatValue - model.convert_value.floatValue)/model.convert_value.floatValue;
        
        float stockRatio= (model.sprice.floatValue - model.convert_price.floatValue)/model.convert_price.floatValue;
        switch (i) {
            case 0:
//                btnTitle = [NSString stringWithFormat:@"%.2f%%",ratio * 100];
                btnTitle = model.noteDate?model.noteDate : @"2019-";//[NSString stringWithFormat:model.noteDate];
                
                break;
            case 1:
                btnTitle = model.full_price;
                break;
            case 2:
                btnTitle = [NSString stringWithFormat:@"%@",model.redeem_real_days];
                break;
            case 3:
                btnTitle = [NSString stringWithFormat:@"%@",model.curr_iss_amt];
                break;
            case 4:
                btnTitle = [NSString stringWithFormat:@"%@",model.year_left];
                break;
            case 5:
                btnTitle = [NSString stringWithFormat:@"%.2f",model.convert_price.floatValue * 0.9];;//下调权    0.7回售义务
                break;
            case 6:
                btnTitle = model.force_redeem_price;//[NSString stringWithFormat:@"%.2f",model.convert_price.floatValue * 1.3];;//强赎权
                break;
            case 7:
                btnTitle = model.convert_value;
                break;
            case 8:
                btnTitle = model.convert_price;// 0.9   1.3
                break;
            case 9:
                btnTitle = model.convert_dt;//日期转String
                break;
            case 10:
                btnTitle = model.sprice;//输入框？
                break;
            case 11:
                btnTitle = model.issue_dt;
                break;
            case 12:
                btnTitle = model.list_dt.length > 0 ? model.list_dt : model.price_tips;//@"买入策略";//输入框？
                break;
            case 13:
                btnTitle = [NSString stringWithFormat:@"K-%@",model.bond_id];
                break;
            case 14:
                btnTitle = model.stock_id;
                break;
            case 15:
                btnTitle = [NSString stringWithFormat:@"SK-%@",model.stock_id];
                break;
                
            case 16:
                btnTitle = [NSString stringWithFormat:@"SC-%@",model.stock_id];;
                break;
            
            default:
                break;
        }
        
        [button setTitle:[NSString stringWithFormat:@"%@",btnTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.tag = row;
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        label.text = [NSString stringWithFormat:@"%@",btnTitle];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
        if ([btnTitle isEqualToString:model.stock_id] || [btnTitle isEqualToString:[NSString stringWithFormat:@"K-%@",model.bond_id]] ||  [btnTitle isEqualToString:[NSString stringWithFormat:@"SK-%@",model.stock_id]] || [btnTitle isEqualToString:[NSString stringWithFormat:@"SC-%@",model.stock_id]] || [btnTitle hasPrefix:@"2019"]) {
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
        if (ABS(model.full_price.integerValue - 100) < 10 ) {//关注&& model.full_price.integerValue != 100
//            label.backgroundColor = [UIColor orangeColor];
        }
        
        if ([YYDateUtil toCurrentLessThan8Days:model.list_dt]) {//上市八天内的
//            label.backgroundColor = [UIColor purpleColor];
        }
        
        if (model.convert_dt && [YYDateUtil toCurrentLessThan8Days:model.convert_dt]) {//临近转股期的   
            label.backgroundColor = [UIColor purpleColor];
        }
        
//        if (model.sprice.floatValue > model.convert_price.floatValue && ABS(model.full_price.integerValue - 100) < 10 && model.full_price.integerValue != 100) {//入场点
//            label.backgroundColor = [UIColor redColor];
//        }
       
        
        
//        策略2-----经济整体周期进入了衰退期   债券和黄金为主要标的  所以可以放宽一点  从周期把握趋势
        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 10) {//特别关注
//            label.backgroundColor = [UIColor magentaColor];
        }
         
        //策略1--------------非转股期
        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 8 && model.full_price.integerValue != 100) {
//            label.backgroundColor = [UIColor orangeColor];//特别关注
        }
        
        //必然进入转股期的    触发了强赎价的     短暂回调的至115的     
        if (model.redeem_real_days.integerValue > 0 && model.full_price.integerValue < 115) {
            label.backgroundColor = [UIColor orangeColor];
            [self p_testLoaclNotification:model.bond_nm];
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
//                label.text = @"溢价率";
                label.text = @"添加通知";
                break;
            case 1:
                label.text = @"现价";
                break;
            case 2:
                label.text = @"强天数";
                break;
            case 3:
                label.text = @"剩余规模";
                break;
            case 4:
                label.text = @"剩余年限";
                break;
            case 5:
                label.text = @"最底价";
                break;
            case 6:
                label.text = @"最高价";
                break;
            case 7:
                label.text = @"转股价值";
                break;
            case 8:
                label.text = @"转股价";
                break;
            case 9:
                label.text = @"转股起始日";
                break;
            case 10:
                label.text = @"股价";
                break;
            case 11:
                label.text = @"可申购日期";
                break;
            case 12:
                label.text = @"上市日期";//@"买入策略";//输入框？
                break;
            case 13:
                label.text = @"K线图";
                break;
            case 14:
                label.text = @"公告";
                break;
            case 15:
                label.text = @"S-K线图";
                break;
            case 16:
                label.text = @"收藏";
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
    YYStockModel *stockModel = self.isSearch == YES? self.searchResults[row] : self.stocks[row];;
    YYBuyIntoViewController *buyIntoVC = [[YYBuyIntoViewController alloc] init];
    buyIntoVC.stockModel = stockModel;
    [self presentViewController:buyIntoVC animated:YES completion:nil];
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    
    if ([sender.currentTitle hasPrefix:@"2019"]) {
        
        NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
        [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *scrollToDate = [minDateFormater dateFromString:@"2019-08-01 11:11"];
        
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
            
            
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            NSLog(@"选择的日期：%@",date);

            [sender setTitle:@"" forState:UIControlStateNormal];
            [sender setTitle:date forState:UIControlStateNormal];
            
            YYStockModel *model = self.stocks[sender.tag];
            
            model.noteDate = date;
            // 在数据更改之前先取消之前的通知
            [LocalNotificationManager cancelLocalNotification:model.noteDate];
            
            NSDate *currentDate = [NSDate date];
            NSString *dateStr = [YYDateUtil dateToString:currentDate andFormate:@"yyyy-MM-dd"];
            [XMGSqliteModelTool saveOrUpdateModel:model uid:dateStr];
            
            [LocalNotificationManager addLocalNotification:date withName:model.bond_nm];
            
//            // 刷新 Cell 中的数据模型存储的时间 （因为 Cell中的数据模型是引用 dataArray 里的数据模型，所以Cell 中的数据模型存储的时间更改后，即更改了数据列表中存储的时间）
//            strongCell.dmData.time = date;
//            DLog(@"%@", strongSelf.dataArray[cell.tag].time);
//
//            // 数据列表中时间更改后，马上缓存到本地
//            [strongSelf storageData];
//
//            // 添加到通知列表中
//            MMHDrinkWaterDMData *dmData = [MMHDrinkWaterDMData new];
//            dmData.time = date;
//            dmData.isTurnOn = [kTurnOn integerValue];
//            [MMHDrinkWaterNotifyManager addLocalNotification:dmData];
        }];
        //    datepicker.dateLabelColor = RGB(65, 188, 241);//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        //    datepicker.doneButtonColor = RGB(65, 188, 241);//确定按钮的颜色
        datepicker.yearLabelColor = [UIColor clearColor];//大号年份字体颜色
        [datepicker show];
        
        return;
    }
    
    if ([sender.currentTitle hasPrefix:@"K-"]) {
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.stockID = [sender.currentTitle substringFromIndex:2];
//        NSLog(@" 啥---%@",[self.stocks valueForKey:kWeb.stockID]);
        for (YYStockModel *m in self.stocks) {
            if ([m.bond_id isEqualToString:kWeb.stockID]) {
                kWeb.market = m.market;
                kWeb.bigPrice = [NSString stringWithFormat:@"%@---转股%@------强赎%@",m.list_dt,m.convert_dt,m.redeem_dt];
            }
        }
        kWeb.bondURL = [self.stocks[sender.tag] valueForKey:@"bondURL"];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SK-"]){
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.stockID = [sender.currentTitle substringFromIndex:3];
        for (YYStockModel *m in self.stocks) {
            if ([m.stock_id isEqualToString:kWeb.stockID]) {
                kWeb.bigPrice = [NSString stringWithFormat:@"回售价%.2f-------下调价%.2f----%@天-----转股价%.2f--------强赎价%.2f,--------currentPrice%@",m.convert_price.floatValue * 0.7,m.convert_price.floatValue * 0.9,m.redeem_real_days,m.convert_price.floatValue,m.convert_price.floatValue * 1.3,m.full_price];;
            }
        }
        NSLog(@" 啥------%@",kWeb.stockID);
        for (YYStockModel *m in self.stocks) {
            if ([m.bond_id isEqualToString:kWeb.stockID]) {
                kWeb.market = m.market;
            }
        }
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SC-"]){
        NSMutableArray *temp = [NSMutableArray array];
        NSString *stockID = [sender.currentTitle substringFromIndex:3];
        for (YYStockModel *m in self.stocks) {
            if ([m.stock_id isEqualToString:stockID]) {
                if (m.redeem_real_days >0) {
                    [temp addObject:m.stock_id];
                    [self.collectDict setObject:temp.copy forKey:@"强赎期"];
                }
                
                if ([YYDateUtil toCurrentLessThan8Days:m.convert_dt]) {
                    [self.collectDict setObject:temp.copy forKey:@"转股临近期"];
                }
            }
        }
        //数组中的对象如何存储？？？？      转股期
        //打新策略---非转股期-首日下午或者第二天卖出
        
        
        //下调转修     一个利好     ------ 假设前提：大股东可以操作股价的！！！   ---6个月到2年。
        //强赎     --------------3个月到6个月   如果回调严重，可以加仓，至少有大股东在维持此标的。
        
        //这种假设前提下， 其实利好的季度公告是可以被大股东操作的。
        
        //道氏   在第14天的时候卖出。      特别低的就是有大股东在专门打压，专门回调。   心态取决于仓位。
        
        //数量大，仓位30%          真跌到110   加仓？？   所谓的环境又变了。。。
        
        
        NSString *path = [kYYCachePath stringByAppendingPathComponent:@"collect.plist"];

        
        [self.collectDict writeToFile:[self filePathWithFileName:@"collect.plist"] atomically:YES];
        [self.collectDict writeToFile:path atomically:YES];
        
        
        
        return;
    }
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
    web.stockID = sender.currentTitle;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
}

-(void)sort:(UIButton *)btn{
    NSLog(@"%@",btn.currentTitle);
    
    if ([btn.currentTitle isEqualToString:@"现价"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.full_price.floatValue < obj2.full_price.floatValue;
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"上市日期"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return [[YYDateUtil stringToDate:obj2.issue_dt dateFormat:@"yyyy-MM-dd"] compare:[YYDateUtil stringToDate:obj1.issue_dt dateFormat:@"yyyy-MM-dd"]];
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"溢价率"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.ratio > obj2.ratio;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"强天数"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.redeem_real_days < obj2.redeem_real_days;
            
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
 https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374
 
 */
- (void)requestData {
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/cbnew/cb_list/?___jsl=LST___t=1550727503725"]];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//             http://money.finance.sina.com.cn/bond/quotes/(null)110030.html   NSLog(@"response -----%@",response);
//        NSLog(@"data ----%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *categoriStock = [NSMutableArray array];
        NSMutableArray *ratioStock = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"rows"]) {
            
            YYStockModel *stockModel = [[YYStockModel alloc] init];
            
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            float ratio = (stockModel.full_price.floatValue - stockModel.convert_value.floatValue)/stockModel.convert_value.floatValue;
            stockModel.ratio = ratio;
            
            float stockRatio= (stockModel.sprice.floatValue - stockModel.convert_price.floatValue)/stockModel.convert_price.floatValue;
            stockModel.stockRatio = stockRatio;
            

             stockModel.stockURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml",stockModel.stock_id];
            stockModel.bondURL = [NSString stringWithFormat:@"http://money.finance.sina.com.cn/bond/quotes/%@.html",stockModel.pre_bond_id];
            
            
            stockModel.passConvert_dt_days = [NSString stringWithFormat:@"%ld",[YYDateUtil calculateToTodayDays:stockModel.convert_dt]]; ;
           
            if ([stockModel.bond_nm isEqualToString:@"G三峡EB"] && stockModel.full_price.intValue < 107) {
                [self p_testLoaclNotification:@"三峡债"];//相近的价格，相类似的走势。过往走势
            }//蒙电 linglu
            
            if ([stockModel.bond_nm isEqualToString:@"平银转债"] && stockModel.full_price.intValue < 123) {
                [self p_testLoaclNotification:@"平银转债"];
            }
            
            NSMutableArray *tempC = [NSMutableArray array];

            if (stockModel.redeem_real_days >0) {
                [tempC addObject:stockModel.stock_id];
                [self.collectDict setObject:tempC.copy forKey:@"强赎期"];
            }
            
            if ([YYDateUtil toCurrentLessThan8Days:stockModel.convert_dt]) {
                [self.collectDict setObject:tempC.copy forKey:@"转股临近期"];
            }//日历
            
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
            
            
            
            NSString *path = [kYYCachePath stringByAppendingPathComponent:@"collect.plist"];
            
            [self.collectDict writeToFile:[self filePathWithFileName:@"collect.plist"] atomically:YES];
            [self.collectDict writeToFile:path atomically:YES];
            
            
            [temp addObject:stockModel];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSDate *date = [NSDate date];
//                NSLog(@"%@",[YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"]);
                NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:dateStr];
                
                
//                if ([dateStr isEqualToString:@"2019-04-19"]) {//逆转？
//                    [self p_testLoaclNotification:@"视觉中国"];
//                }
                
                if ([stockModel.bond_nm isEqualToString:@"平银转债"] && stockModel.full_price.integerValue < 115) {
                    [self p_testLoaclNotification:@"平银转债"];//
                }
//                if (stockModel.full_price.integerValue < 110) {
//                        [self p_testLoaclNotification:@"全仓"];
//                    }
                
                if ([dateStr isEqualToString:@"2019-07-25"] ) {
                    [self p_testLoaclNotification:@"平银转债"];
                }
                //伊力策略-----一旦低于110就加仓   甚至重仓
                
                //
                
                if ([YYDateUtil toCurrentLessThan8Days:stockModel.convert_dt]) {
                    NSString *sql = [NSString stringWithFormat:@"select full_price from YYStockModel where bond_id = %@;",stockModel.bond_id];
                    NSArray *nearConvertArray = [XMGSqliteModelTool queryModels:[YYStockModel class] WithSql:sql uid:stockModel.convert_dt];
//                    NSArray *nearConvertArray = [XMGSqliteModelTool queryModels:[YYStockModel class] WithSql:sql uid:dateStr];//测试用
                    if (nearConvertArray.count > 0) {
                        [self p_testLoaclNotification:stockModel.stock_nm];
                    }
                }
            });
        }
        
        self.stocks = temp;
        
        
        [self.stockView reloadStockView];
    }];
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
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jisilu.cn/data/calendar/"]];
    [request2 setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    //    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //如何快速测试一个网络请求
    [NSURLConnection sendAsynchronousRequest:request2 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"response -----%@",response);
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
-(void)testAPIWithAFN{
    //发行流程：董事会预案 → 股东大会批准 → 证监会受理 → 发审委通过 → 证监会核准批文 → 发行公告
    [[BaseNetManager defaultManager] GET:@"https://www.jisilu.cn/data/cbnew/pre_list/?___jsl=LST___t=1566207894005" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"AFN ----responseObject----%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"rows"]) {
            YYBuyintoStockModel *m = [[YYBuyintoStockModel alloc] init];
            [m setValuesForKeysWithDictionary:dic];
            
            if (m.convert_price.floatValue < m.price.floatValue) {
                [LocalNotificationManager addLocalNotification:m.progress_dt withModel:m];
            }
//            [XMGSqliteModelTool saveOrUpdateModel:m uid:<#(NSString *)#>];
        }
        
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

-(void)p_testLoaclNotification:(NSString *)modelName{
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |UIUserNotificationTypeSound categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    UILocalNotification *localNote = [[UILocalNotification alloc] init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNote.alertBody = [NSString stringWithFormat:@"%@,来信息了",modelName];//@"八戒，来信息了";
    //设置其他信息
//    localNote.userInfo = @{@"content": modelName, @"type": @1};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
}

-(void)p_redeem{
    
    YYSelfCollectViewController *collectVC = [[YYSelfCollectViewController alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"redeem_real_days > 0"];
    
    
//    [XMGSqliteModelTool saveOrUpdateModel:<#(id)#> uid:<#(NSString *)#>];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:collectVC];
    [self presentViewController:nav animated:NO completion:nil];
    
}

-(void)p_refresh{
    if (self.isSearch) {
        self.isSearch = NO;
        [self.stockView reloadStockView];
    }
}

-(void)p_caledar{
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
    web.targetUrl = @"https://www.jisilu.cn/data/calendar/";
    web.bigPrice = @"下调转修会";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
}

-(void)p_calenar{
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
    web.targetUrl = @"https://www.jisilu.cn/data/calendar/";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
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



@end
