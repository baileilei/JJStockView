//
//  YYMarketValueAndTureOver.h
//  JJStockView
//
//  Created by smart-wift on 2020/1/9.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYMarketValueAndTureOver : NSObject

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *symbol;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *trade;//收盘价


@property (nonatomic,copy) NSString *pricechange;
@property (nonatomic,copy) NSString *changepercent;

@property (nonatomic,copy) NSString *buy;
@property (nonatomic,copy) NSString *sell;

@property (nonatomic,copy) NSString *settlement;
@property (nonatomic,copy) NSString *turnoverratio;//换手率

@property (nonatomic,copy) NSString *volume;//成交量 股
@property (nonatomic,copy) NSString *amount;//成交额

@property (nonatomic,copy) NSString *mktcap;//总市值
 @property (nonatomic,copy) NSString *nmc;//流通市值

@property (nonatomic,copy)NSString *date;

/*
 {symbol:"sh601398",code:"601398",name:"工商银行",trade:"5.910",pricechange:"0.000",changepercent:"0.000",buy:"5.900",sell:"5.910",settlement:"5.910",open:"5.950",high:"5.960",low:"5.880",volume:"137713429",amount:"813806686",ticktime:"15:00:06",per:7.207,per_d:6.8,nta:"6.7900",pb:0.87,mktcap:210636097.9396,nmc:159340817.61055,turnoverratio:0.05108}
 */

@end

NS_ASSUME_NONNULL_END
