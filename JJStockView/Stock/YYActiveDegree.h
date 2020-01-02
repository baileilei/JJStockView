//
//  YYActiveDegree.h
//  JJStockView
//
//  Created by smart-wift on 2020/1/2.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYActiveDegree : NSObject


@property (nonatomic,copy) NSString *stock_id;//主键

@property (nonatomic,copy) NSString *stock_amt;//62668.4700

@property (nonatomic,copy) NSString *svolume;

@property (nonatomic,copy) NSString *bond_id;//债券代码

@property (nonatomic,copy) NSString *curr_iss_amt;//当前规模

@property (nonatomic,copy) NSString *volume;//成交额   ------Y

@property (nonatomic,copy)NSString *date;

@property (nonatomic,copy) NSString *full_price;//债券现价

@property (nonatomic,copy)NSString *bond_Degree;

@property (nonatomic,copy)NSString *stock_Degree;


//SELECT svolume,volume,full_price FROM YYActiveDegree WHERE svolume * 100 < volume * 100;
/*                               到期收益率         日线特征      剩余年限/剩余规模 转债占比=转债余额/总市值
1579.89    11109.57    111.916       -0.49%       异常？
8856.79    19671.75    116.610     未到转股期 -0.21%
4278.28    6123.82    122.980         -1.57%
12445.07    22801.11    120.210    未到转股期
2427.46    2919.88    92.670       5.49%        跳空高开——初期     5.063/7.5    41%(压力系数)
3256.47    7651.87    97.426       5.41%        跳空高开——第一个    2.573/12      29.4%
 
 -----------
 8263.44    1607.80    113.050                跳空高开-连续          3.989/3.042      4.9%
 3984.91    469.05     103.750                 节节阳线              4.175/7.5       19.5%
 */

@end

NS_ASSUME_NONNULL_END
