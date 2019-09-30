//
//  YYSingleBondModel.h
//  JJStockView
//
//  Created by smart-wift on 2019/9/30.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYSingleBondModel : NSObject

@property (nonatomic,copy,nonnull) NSString *bond_id;

@property (nonatomic,copy) NSString *convert_value;

@property (nonatomic,copy) NSString *bond_price;// 

@property (nonatomic,copy) NSString *last_chg_dt;

@property (nonatomic,copy) NSString *premium_rt;

@property (nonatomic,copy) NSString *ytm_rt;
@end

NS_ASSUME_NONNULL_END

/*
 "bond_id" : "113539",
 "convert_value" : "116.71",
 "last_chg_dt" : "2019-07-29",
 "premium_rt" : "-7.81%",
 "ytm_rt" : "2.13%"
 */
