//
//  WillBondViewController.m
//  JJStockView
//
//  Created by smart-wift on 2019/8/31.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "WillBondViewController.h"
#import "JJStockView.h"
#import "YYBuyintoStockModel.h"
#import "HWNetTools.h"
#import "YYKLineWebViewController.h"
#import "YYDateUtil.h"
#import "XMGSqliteModelTool.h"
#import "YYStockModel.h"

#define columnCount 18

@interface WillBondViewController ()<StockViewDataSource,StockViewDelegate>


@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

@end

@implementation WillBondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自选池";
    
    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:self.stockView];
    
    [self requestWillBondData];
    
    [self.stockView reloadStockView];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(p_back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"查看沙盒" style:UIBarButtonItemStyleDone target:self action:@selector(p_checkSum)];
    
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(p_refresh)];
    
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStyleDone target:self action:@selector(p_calenar)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1,rightItem2];
    
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
    
    YYBuyintoStockModel *model = self.stocks[row];
    //    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text = [NSString stringWithFormat:@"%@",model.stock_nm];
    
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
        YYBuyintoStockModel *model = self.stocks[row];;
        NSString *btnTitle = nil;
        //        float ratio = (model.full_price.floatValue - model.convert_value.floatValue)/model.convert_value.floatValue;
        switch (i) {
            case 0:
            //                btnTitle = [NSString stringWithFormat:@"%.2f%%",ratio * 100];
            // btnTitle = model.noteDate?model.noteDate : @"2019-";//[NSString stringWithFormat:model.noteDate];
            
            
            btnTitle = model.progress_dt;
            
            break;
            case 1:
            btnTitle = model.stock_id;
            break;
            case 2:
            btnTitle = [NSString stringWithFormat:@"%@",model.passAndFuture];
            break;
            case 3:
            btnTitle = [NSString stringWithFormat:@"%@",model.price];
            break;
            case 4:
            btnTitle = [NSString stringWithFormat:@"%@",model.price];
            break;
            case 5:
            btnTitle = [NSString stringWithFormat:@"%.2f",model.convert_price.floatValue * 0.9];;//下调权    0.7回售义务
            break;
            case 6:
            btnTitle = model.price;//[NSString stringWithFormat:@"%.2f",model.convert_price.floatValue * 1.3];;//强赎权
            break;
            case 7:
            btnTitle = model.price;
            break;
            case 8:
            btnTitle = model.convert_price;// 0.9   1.3
            break;
            case 9:
            btnTitle = model.price;//日期转String
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

-(void)requestWillBondData{
    //发行流程：董事会预案 → 股东大会批准 → 证监会受理 → 发审委通过 → 证监会核准批文 → 发行公告
    //https://www.jisilu.cn/data/cbnew/redeem_list/?___jsl=LST___t=1565004937374
    [[HWNetTools shareNetTools] GET:@"https://www.jisilu.cn/data/cbnew/pre_list/?___jsl=LST___t=1566207894005" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSLog(@"responseObject----%@",responseObject);
        NSError *error = nil;
        NSDictionary *dict = responseObject;//[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        //        NSLog(@"dict-----%@",dict[@"rows"]);
        
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *categoriStock = [NSMutableArray array];
        NSMutableArray *ratioStock = [NSMutableArray array];
        
        NSDate *date = [NSDate date];
        //                NSLog(@"%@",[YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"]);
        NSString *dateStr = [YYDateUtil dateToString:date andFormate:@"yyyy-MM-dd"];
        NSArray *originArray = [XMGSqliteModelTool queryAllModels:[YYStockModel class] uid:dateStr];
        
        
        for (NSDictionary *dic in dict[@"rows"]) {
            
            YYBuyintoStockModel *stockModel = [[YYBuyintoStockModel alloc] init];
            
            [stockModel setValuesForKeysWithDictionary:dic[@"cell"]];
            
            if ([stockModel.stock_id hasPrefix:@"6"]) {
                stockModel.stock_id = [NSString stringWithFormat:@"sh%@",stockModel.stock_id];
            }else{// 0  3
                 stockModel.stock_id = [NSString stringWithFormat:@"sz%@",stockModel.stock_id];
            }
            
            stockModel.stockURL = [NSString stringWithFormat:@"http://finance.sina.com.cn/realstock/company/%@/nc.shtml",stockModel.stock_id];
            
            
            for (YYStockModel *m in originArray) {
                if ([m.stock_id containsString:stockModel.stock_id]) {
                    stockModel.stockURL = m.stockURL;
                    stockModel.passAndFuture = @"已发行";
                }
            }
            [temp addObject:stockModel];
            [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"willBond.sqlite"];
        }
        [temp sortUsingComparator:^NSComparisonResult(YYBuyintoStockModel * obj1, YYBuyintoStockModel * obj2) {
            return obj1.progress_dt.floatValue < obj2.progress_dt.floatValue;
        }];
        self.stocks = temp;
        [self.stockView reloadStockView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}






#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
    
    YYBuyintoStockModel *model = self.stocks[sender.tag];
    
    if ([sender.currentTitle hasPrefix:@"2019"]) {
        
        NSDateFormatter *minDateFormater = [[NSDateFormatter alloc] init];
        [minDateFormater setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *scrollToDate = [minDateFormater dateFromString:@"2019-08-01 11:11"];
        
        return;
    }
    
    if ([sender.currentTitle hasPrefix:@"K-"]) {
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.bondURL = model.stockURL;
        kWeb.stockID = [sender.currentTitle substringFromIndex:2];
        //        NSLog(@" 啥---%@",[self.stocks valueForKey:kWeb.stockID]);
        for (YYBuyintoStockModel *m in self.stocks) {
            if ([m.bond_id isEqualToString:kWeb.stockID]) {
//                kWeb.market = m.market;
//                kWeb.bigPrice = [NSString stringWithFormat:@"---转股%@------强赎%@",m.convert_dt,m.redeem_dt];
            }
        }
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SK-"]){
        YYKLineWebViewController *kWeb = [[YYKLineWebViewController alloc] init];
        kWeb.bondURL = model.stockURL;
        kWeb.stockID = [sender.currentTitle substringFromIndex:3];
        for (YYBuyintoStockModel *m in self.stocks) {
            if ([m.stock_id isEqualToString:kWeb.stockID]) {
//                kWeb.bigPrice = [NSString stringWithFormat:@"回售价%.2f-------下调价%.2f----%@天-----转股价%.2f--------强赎价%.2f,--------currentPrice%@",m.convert_price.floatValue * 0.7,m.convert_price.floatValue * 0.9,m.redeem_real_days,m.convert_price.floatValue,m.convert_price.floatValue * 1.3,m.full_price];;
            }
        }
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:kWeb] animated:YES completion:nil];
        
        return;
    }else if ([sender.currentTitle hasPrefix:@"SC-"]){
        NSMutableArray *temp = [NSMutableArray array];
        NSString *stockID = [sender.currentTitle substringFromIndex:3];
        //数组中的对象如何存储？？？？      转股期
        //打新策略---非转股期-首日下午或者第二天卖出
        
        
        //下调转修     一个利好     ------ 假设前提：大股东可以操作股价的！！！   ---6个月到2年。
        //强赎     --------------3个月到6个月   如果回调严重，可以加仓，至少有大股东在维持此标的。
        //这种假设前提下， 其实利好的季度公告是可以被大股东操作的。
        
        //道氏   在第14天的时候卖出。      特别低的就是有大股东在专门打压，专门回调。   心态取决于仓位。
        //数量大，仓位30%          真跌到110   加仓？？   所谓的环境又变了。。。
        return;
    }
    
    YYWebViewController *web = [[YYWebViewController alloc] init];
    web.stockID = sender.currentTitle;
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:web] animated:YES completion:nil];
}

-(void)sort:(UIButton *)btn{
    NSLog(@"%@",btn.currentTitle);
    
    [self.stockView reloadStockView];
}

-(void)p_refresh{
    [self.stockView reloadStockView];
}

-(void)p_back{
    //    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
