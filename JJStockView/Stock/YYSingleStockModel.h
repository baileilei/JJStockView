//
//  YYSingleStockModel.h
//  JJStockView
//
//  Created by g on 2019/9/21.
//  Copyright © 2019 Jezz. All rights reserved.
//

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

@property (nonatomic,assign) float p_change;
@property (nonatomic,assign) float ma5;


@property (nonatomic,assign) float ma10;
@property (nonatomic,assign) float ma20;

@property (nonatomic,assign) float v_ma5;
@property (nonatomic,assign) float v_ma10;

@property (nonatomic,assign) float v_ma20;

@property (nonatomic,assign) float turnover;
@end

NS_ASSUME_NONNULL_END
