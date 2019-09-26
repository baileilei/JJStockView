//
//  YYSingleStockModel.h
//  JJStockView
//
//  Created by g on 2019/9/21.
//  Copyright © 2019 Jezz. All rights reserved.
//
/*
 CREATE TABLE "StockAndBond_stockID" (
 "date" TEXT(255),
 "sOpen" TEXT(255),
 "sHign" TEXT(255),
 "sClose" TEXT(255),
 "sLow" TEXT(255),
 "sPrice" TEXT(255),
 "sP_change" TEXT(255),
 "sVoluemCount" TEXT(255),
 "sVolumeTotal" TEXT(255),
 "sDealCount" TEXT(255),
 "bOpen" TEXT(255),
 "bHign" TEXT(255),
 "bClose" TEXT(255),
 "bP_change" TEXT(255),
 "bLow" TEXT(255),
 "bPrice" TEXT(255),
 "bVoluemCount" TEXT(255),
 "bVolumeTotal" TEXT(255),
 "bDealCount" TEXT(255)
 );
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYSingleStockModel : NSObject
//timestamp,open,high,close,low,volume,price_change,p_change,ma5,ma10,ma20,v_ma5,v_ma10,v_ma20,turnover
@property (nonatomic,copy) NSString *timestamp;

@property (nonatomic,copy) NSString *stockId;

@property (nonatomic,assign) float open;

@property (nonatomic,assign) float high;
@property (nonatomic,assign) float close;
@property (nonatomic,assign) float low;
@property (nonatomic,assign) float volume;
@property (nonatomic,assign) float price_change;

@property (nonatomic,assign) float p_change;// Sp_change    Bp_change
@property (nonatomic,assign) float ma5;


@property (nonatomic,assign) float ma10;
@property (nonatomic,assign) float ma20;

@property (nonatomic,assign) float v_ma5;
@property (nonatomic,assign) float v_ma10;

@property (nonatomic,assign) float v_ma20;

@property (nonatomic,assign) float turnover;
@end

NS_ASSUME_NONNULL_END
//http://stock.jrj.com.cn/share,600519,gdhs.shtml?to=pc。 有历史记录
//http://stock.jrj.com.cn/action/gudong/getGudongDataByCode.jspa?vname=stockgudongData&stockcode=600519&_=1569474620679 //检查确认筹码的是否进一步集中？？？
//http://data.eastmoney.com/DataCenter_V3/gdhs/GetList.ashx?reportdate=&market=&changerate==&range==&pagesize=50&page=1&sortRule=-1&sortType=NoticeDate&js=var%20rVmEnXFO&param=&rt=52315653  -----
/*
 {"SecurityCode":"300627",
 "HolderNum":"17734.0",
 "PreviousHolderNum":"17061.0",
 
 "SecurityName":"华测导航",
 "LatestPrice":"18.8",
 "PriceChangeRate":"-3.98",
 "HolderNumChange":"673.0",
 "HolderNumChangeRate":"3.9447",
 "RangeChangeRate":"0.55",
 "EndDate":"2019-09-20T00:00:00",
 "PreviousEndDate":"2019-09-10T00:00:00",
 "HolderAvgCapitalisation":"274767.271884516",
 "HolderAvgStockQuantity":"13752.12",
 "TotalCapitalisation":"4872722799.6",
 "CapitalStock":"243880020.0",
 "NoticeDate":"2019-09-26T00:00:00"}
 */
