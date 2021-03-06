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
#import "JJStockView.h"

#import "WSDatePickerView.h"
#import "LocalNotificationManager.h"
#import "YYKLineWebViewController.h"

#import "YYDateUtil.h"
#import "YYStockModel.h"
#import "NSString+storeImagePath.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SYCacheFileViewController.h"
#import "SYCacheFileManager.h"
#import "SYCacheFileModel.h"

#define columnCount 18

#define oneDay 24 * 60 * 60
#define oneHour 60 * 60
static int count = 1;


@interface YYSelfCollectViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

@property (nonatomic,strong) NSMutableArray *firstGroupRedeemDays;

@property (nonatomic,strong) NSMutableArray *secondGroupOneToSixMonths;


@property (nonatomic,strong) NSMutableArray *thirdGroupSixMonthToDoubleSix;


@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic,strong) YYRedeemModel *currentModel;

@property (nonatomic,strong) NSArray *list;

@end

@implementation YYSelfCollectViewController{
    JJStockView * _stockView;
}
//梳理所有转债的热点--------是否有重合，特别是关注的几只转债的热点概念！
-(NSMutableArray *)firstGroupRedeemDays{
    if (!_firstGroupRedeemDays) {
        _firstGroupRedeemDays = [NSMutableArray arrayWithObjects:@"久其转债",@"亚太转债", nil];
    }
    return _firstGroupRedeemDays;
}

-(NSMutableArray *)secondGroupOneToSixMonths{
    if (!_secondGroupOneToSixMonths) {//兄弟  岱勒    中环环保      圣达
        _secondGroupOneToSixMonths = [NSMutableArray arrayWithObjects:@"道氏转债",@"杭电转债",@"长城转债",@"创维转债", nil];
    }
    return _secondGroupOneToSixMonths;
}

-(NSMutableArray *)thirdGroupSixMonthToDoubleSix{
    if (!_thirdGroupSixMonthToDoubleSix) {
        _thirdGroupSixMonthToDoubleSix = [NSMutableArray arrayWithObjects:@"圣达转债", nil];
    }
    return _thirdGroupSixMonthToDoubleSix;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自选池";
    
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
    
    [self requestRedeemData];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(p_back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查看沙盒" style:UIBarButtonItemStyleDone target:self action:@selector(p_checkSum)];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(p_refresh)];
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStyleDone target:self action:@selector(p_calenar)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1,rightItem2];
    
    
    [self.timer setFireDate:[NSDate date]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toHandleImage) name:@"GetPicPath" object:nil];
   
}

-(void)toHandleImage{
    
}

#pragma mark - Stock DataSource
//多少行
- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return self.stocks.count;
}
//左侧显示什么名称
- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    YYRedeemModel *model = self.stocks[row];
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
        YYRedeemModel *model = self.stocks[row];;
        NSString *btnTitle = nil;
//        float ratio = (model.full_price.floatValue - model.convert_value.floatValue)/model.convert_value.floatValue;
        switch (i) {
            case 0:
                //                btnTitle = [NSString stringWithFormat:@"%.2f%%",ratio * 100];
                // btnTitle = model.noteDate?model.noteDate : @"2019-";//[NSString stringWithFormat:model.noteDate];


                btnTitle = model.sincrease_rt;
                
                break;
            case 1:
                 btnTitle = model.increase_rt;
                break;
            case 2:
                btnTitle = [NSString stringWithFormat:@"%@",model.full_price];
                break;
            case 3:
                btnTitle = [NSString stringWithFormat:@"%@",model.redeem_real_days];
                break;
            case 4:
                btnTitle = [NSString stringWithFormat:@"%@-%@",model.year_left,model.curr_iss_amt];
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
//                btnTitle = model.sprice;//输入框？
                break;
            case 11:
                btnTitle = @"查看图片";
                break;
            case 12:
//                btnTitle = model.list_dt.length > 0 ? model.list_dt : model.price_tips;//@"买入策略";//输入框？
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
        if ([btnTitle isEqualToString:model.stock_id] || [btnTitle isEqualToString:[NSString stringWithFormat:@"K-%@",model.bond_id]] ||  [btnTitle isEqualToString:[NSString stringWithFormat:@"SK-%@",model.stock_id]] || [btnTitle isEqualToString:[NSString stringWithFormat:@"SC-%@",model.stock_id]] || [btnTitle hasPrefix:@"2019"]|| [btnTitle isEqualToString:@"添加图片"] || [btnTitle isEqualToString:@"查看图片"]) {

            [bg addSubview:button];
        }
        
        //        if (model.sprice.floatValue > model.convert_price.floatValue && ABS(model.full_price.integerValue - 100) < 10 && model.full_price.integerValue != 100) {//入场点
        //            label.backgroundColor = [UIColor redColor];
        //        }
        
        
        
        //        策略2-----经济整体周期进入了衰退期   债券和黄金为主要标的  所以可以放宽一点  从周期把握趋势
//        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 10) {//特别关注
//            //            label.backgroundColor = [UIColor magentaColor];
//        }
        
        //策略1--------------非转股期
//        if (ratio < 0 && ABS(model.full_price.integerValue - 100) < 8 && model.full_price.integerValue != 100) {
//            //            label.backgroundColor = [UIColor orangeColor];//特别关注
//        }
//
//        //必然进入转股期的    触发了强赎价的     短暂回调的至115的
//        if (model.redeem_real_days.integerValue > 0 && model.full_price.integerValue < 115) {
//            label.backgroundColor = [UIColor orangeColor];
//            [self p_testLoaclNotification:model.bond_nm];
//        }
        
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
                //                label.text = @"溢价率";   指标？？？
                label.text = @"SI";
                break;
            case 1:
                label.text = @"BI";
                break;
            case 2:
                label.text = @"现价";
                break;
            case 3:
                label.text = @"强天数";
                break;
            case 4:
                label.text = @"剩余年限-规模";
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
                label.text = @"相关概念";
                break;
                
            default:
                break;
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [button setTitle:label.text forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sort:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:button];
    }
    return bg;
}

- (CGFloat)heightForHeadTitle:(JJStockView*)stockView{
    return 40.0f;
}

- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"DidSelect Row:%ld",row);
   
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

#pragma mark - 懒加载返回数据定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:oneHour target:self selector:@selector((onTimer:)) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)onTimer:(NSTimer *)timer{
    NSLog(@"%d",count++);
    
    // 保存的次数
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"count"];
    
    [self requestRedeemData];
}

-(void)requestRedeemData{

    //https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374
    [[HWNetTools shareNetTools] GET:@"https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSLog(@"responseObject----%@",responseObject);
        NSError *error = nil;
        NSDictionary *dict = responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        //        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *categoriStock = [NSMutableArray array];
        NSMutableArray *ratioStock = [NSMutableArray array];
        for (NSDictionary *dic in dict[@"rows"]) {
            
            YYRedeemModel *stockModel = [[YYRedeemModel alloc] init];
            
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            NSDate *date = [NSDate date];
            NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
            NSArray *originArray = [XMGSqliteModelTool queryAllModels:[YYStockModel class] uid:dateStr];
            for (YYStockModel *m in originArray) {
                if ([m.bond_id isEqualToString:stockModel.bond_id]) {
                    stockModel.full_price = m.full_price;
                    stockModel.convert_value = m.convert_value;
                    stockModel.year_left = m.year_left;
                    stockModel.stock_id = m.stock_id;

                    stockModel.market = m.market;
                    
                    stockModel.bondURL = m.bondURL;
                    stockModel.stockURL = m.stockURL;
                    stockModel.sincrease_rt = m.sincrease_rt;
                    stockModel.increase_rt = m.increase_rt;

                }
            }
            

            //第一梯队。（1个月）     第二梯队（1个月到6个月）。  第三梯队（6个月～12个月）
            if (stockModel.redeem_real_days.integerValue > 0 || [self.firstGroupRedeemDays containsObject:stockModel.bond_nm] || [self.secondGroupOneToSixMonths containsObject:stockModel.bond_nm]||  [stockModel.bond_nm isEqualToString:@"长城转债"]||  [stockModel.bond_nm isEqualToString:@"创维转债"]) {
                [temp addObject:stockModel];
                [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"myFocus"];
                
            }
            
            
            
        }

        
        self.stocks = temp;
        [self.stockView reloadStockView];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}






#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    
    YYStockModel *m = self.stocks[sender.tag];
    if ([sender.currentTitle isEqualToString:@"查看图片"]) {
        // 打开相册
        self.currentModel = self.stocks[sender.tag];
        
       
        
        return;
    }else if ([sender.currentTitle isEqualToString:@"添加图片"]) {
        // 打开相册
        self.currentModel = self.stocks[sender.tag];
        [self setImageLimit];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"2019"]) {
        
        NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
        [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *scrollToDate = [minDateFormater dateFromString:@"2019-08-01 11:11"];
        
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute scrollToDate:scrollToDate CompleteBlock:^(NSDate *selectDate) {
            
            
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
            NSLog(@"选择的日期：%@",date);
            
            [sender setTitle:@"" forState:UIControlStateNormal];
            [sender setTitle:date forState:UIControlStateNormal];
            
            YYStockModel *model = self.stocks[sender.tag];
            
            model.noteDate = date;//保存该属性
            // 在数据更改之前先取消之前的通知
            [LocalNotificationManager cancelLocalNotification:model.noteDate];
            
            [XMGSqliteModelTool saveOrUpdateModel:model uid:@"myFocus"];
            
            [LocalNotificationManager addLocalNotification:date withName:model.bond_nm];
            
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
        kWeb.bondURL = m.bondURL;
        kWeb.bigPrice = [NSString stringWithFormat:@"---转股%@------强赎%@",m.convert_dt,m.redeem_dt];
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SK-"]){
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.stockURL = m.stockURL;
        kWeb.bigPrice = [NSString stringWithFormat:@"回售价%.2f-------下调价%.2f----%@天-----转股价%.2f--------强赎价%.2f,--------currentPrice%@",m.convert_price.floatValue * 0.7,m.convert_price.floatValue * 0.9,m.redeem_real_days,m.convert_price.floatValue,m.convert_price.floatValue * 1.3,m.full_price];;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SC-"]){
        //下调转修     一个利好     ------ 假设前提：大股东可以操作股价的！！！   ---6个月到2年。
        //强赎     --------------3个月到6个月   如果回调严重，可以加仓，至少有大股东在维持此标的。
        //这种假设前提下， 其实利好的季度公告是可以被大股东操作的。
        
        //道氏   在第14天的时候卖出。      特别低的就是有大股东在专门打压，专门回调。   心态取决于仓位。
        //数量大，仓位30%          真跌到110   加仓？？   所谓的环境又变了。。。
        YYKLineWebViewController *web = [[YYKLineWebViewController alloc] init];
        web.bondURL =[NSString stringWithFormat:@"http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_CorpOtherInfo/stockid/%@/menu_num/5.phtml",m.stock_id]; ;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
        return;
        return;
    }
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
            return obj1.year_left.floatValue > obj2.year_left.floatValue;
            
        }];
    }
    
    if ([btn.currentTitle isEqualToString:@"剩余规模"]) {
        [self.stocks sortUsingComparator:^NSComparisonResult(YYStockModel * obj1, YYStockModel * _Nonnull obj2) {
            return obj1.curr_iss_amt.floatValue < obj2.curr_iss_amt.floatValue;
            
        }];
    }
    
    
    [self.stockView reloadStockView];
}

-(void)p_refresh{
    [self.stockView reloadStockView];
}

-(void)p_back{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)p_checkSum{
    SYCacheFileViewController *cacheVC = [[SYCacheFileViewController alloc] init];

    //    // 指定文件格式
    [SYCacheFileManager shareManager].cacheDocumentTypes = @[@".pages", @"wps", @".xls", @".pdf", @".rar",@".jpg",@".sqlite",@".plist"];
//
//    // 指定目录，或默认目录
    NSString *path = [SYCacheFileManager libraryDirectoryPath];
    NSString *imgPath = [path stringByAppendingString:@"/PlugImage"];
    NSArray *array = [[SYCacheFileManager shareManager] fileModelsWithFilePath:path];
    
//    cacheVC.cacheArray = [self handleDATA:array].mutableCopy;
    
    cacheVC.cacheArray = array.mutableCopy;//[NSMutableArray arrayWithArray:array];

    // 标题
    cacheVC.cacheTitle = @"我的缓存文件";

    // 单图或多图浏览
    [SYCacheFileManager shareManager].showImageShuffling = YES;

    // 文件浏览方式
    [SYCacheFileManager shareManager].showDoucumentUI = YES;

    // 列表，或九宫格显示
//    cacheVC.showType = 1;
    
    //
    [self.navigationController pushViewController:cacheVC animated:YES];
}

-(NSArray *)list{
    if (!_list) {
        NSArray *array = @[@2,@2,@4,@3,@5,@6,@3,@6,@5,@4];
        _list = array;
    }
    return _list;
}

-(NSArray *)handleDATA:(NSArray *)array{
    
    NSLog(@"array-------%@",array);
    NSMutableArray *All = [NSMutableArray array];
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    NSMutableSet *tempSet = [NSMutableSet set];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (SYCacheFileModel *image in array) {
        NSLog(@"image-----%@",image);
        
        if ([image.fileName substringFromIndex:[image.fileName rangeOfString:@"-"].location]) {
            [tempSet addObject:image.fileName];
        }
    }
    
    [tempSet enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fileName CONTAINS %@", obj];//创建谓词筛选器
        NSArray *group = [array filteredArrayUsingPredicate:predicate];//用数组的过滤方法得到新的数组,在添加的最终的数组_slices中<br>         [_slices addObject:group];<br>    }];
        
        NSLog(@"group-----%@",group);
        [tempArray addObject:group];
    }];
    
    if (tempArray.count) {
        [tempDict setObject:tempArray forKey:tempArray.firstObject];
        
        [All addObject:tempDict];
    }
    
    return  All;
}


//相册权限
- (void)setImageLimit {
    __weak typeof (self)weakSelf = self;
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {//用户第一次访问
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){//允许
                [weakSelf chooseImages];
            } else {//拒绝
                
            }
        }];
    }
    else if (status == PHAuthorizationStatusAuthorized) {
        [weakSelf chooseImages];
    }
    else {//用户拒绝授权
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"notice" message:@"tip_photoFail" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf chooseImages];
            
        }];
        [alertC addAction:sureAction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
}

// 图片选择
- (void)chooseImages {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //  获取主框架的背景颜色
        picker.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        //  获取主框架非title外的颜色
        picker.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        //  获取主框架的title颜色
        [picker.navigationBar setTitleTextAttributes:self.navigationController.navigationBar.titleTextAttributes];
        //设置当前控制器为picker对象的代理
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - 选取图片的具体方法
/**
 *  从相册获取图片的方法
 */
- (void)selectFromPhotoAlbumWithUIImagePickerController:(UIImagePickerController *)imgPicker{
    //  从现有的照片库取照片
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

#pragma mark UIImagePickerController的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
    // 压缩图片
    //    UIImage *afterScalImg = [self imageWithImageSimple:img scaledToSize:CGSizeMake(210.0, 210.0)];
    // 保存图片
    NSString *imgPath = [NSString saveImg:img Name:self.currentModel.bond_nm];
    
    [self.currentModel.beiWangImagePaths addObject:imgPath];
    
    [XMGSqliteModelTool saveOrUpdateModel:self.currentModel uid:@"myFocus"];
    
    //  退出
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetPicPath" object:imgPath];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)img scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [img drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
