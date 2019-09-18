//
//  YYAnotherWatchPondStock.h
//  JJStockView
//
//  Created by smart-wift on 2019/9/18.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYAnotherWatchPondStock : NSObject

@property (nonatomic,copy) NSString *stock_nm;
@property (nonatomic,copy) NSString *stock_id;


@property (nonatomic,copy) NSString *safe_price; //现金选择权
@property (nonatomic,copy) NSString *discount_rt;//选择权溢价

@property (nonatomic,copy) NSString *choose_price;//现金选择权
@property (nonatomic,copy) NSString *choose_discount_rt;//换股溢价

@property (nonatomic,copy) NSString *money_type;//
@property (nonatomic,copy) NSString *price;//现价

@property (nonatomic,copy) NSString *last_time;
@property (nonatomic,copy) NSString *increase_rt;//涨幅

@property (nonatomic,copy) NSString *type_cd;//换股吸收合并 部分要约收购 全面要约收购
@property (nonatomic,copy) NSString *descr;//说明
@property (nonatomic,copy) NSString *question_id;//涨幅

@property (nonatomic,copy) NSString *full_id;//"sh600081"

@property (nonatomic,copy) NSString *yaoyue_url;
@property (nonatomic,copy) NSString *disclosure_url;//涨幅

@end

/*
 "active_flg" : "Y",
 "choose_discount_rt" : "-9.51%",
 "choose_price" : "8.10",
 "descr" : "永辉超市拟收购中百集团最多10.14%股权，本次要约收购股份数量不超过 69,055,581 股。若预受要约股份的数量少于 34,051,075 股（占中百集团总股本的5.00%），则本次要约收购自始不生效。",
 "disclosure_url" : "disclosure.szse.cn\/m\/drgg000759.htm",
 "discount_rt" : "-",
 "full_id" : "sz000759",
 "increase_rt" : "0.55%",
 "last_time" : "15:00:03",
 "money_type" : "人民币",
 "price" : "7.33",
 "question_id" : "309008",
 "safe_price" : "-",
 "stock_id" : "000759",
 "stock_nm" : "中百集团",
 "type_cd" : "部分要约收购",
 "yaoyue_url" : "www.cninfo.com.cn\/new\/disclosure\/detail?plate=szse&stockCode=000759&announcementId=1205954368&announcementTime=2019-03-29"
 */
NS_ASSUME_NONNULL_END
