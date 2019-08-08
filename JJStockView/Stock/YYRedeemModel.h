//
//  YYRedeemModel.h
//  JJStockView
//
//  Created by smart-wift on 2019/8/5.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYRedeemModel : NSObject
/*
 "after_next_put_dt" = 0;
 "bond_id" = 128030;
 "bond_nm" = "\U5929\U5eb7\U8f6c\U503a";
 btype = C;
 "convert_dt" = "2018-06-28";
 "convert_price" = "8.05";
 "curr_iss_amt" = "6.568";
 "force_redeem" = "<null>";
 "force_redeem_price" = "10.46";
 "next_put_dt" = "2021-12-22";
 "orig_iss_amt" = "10.000";
 "real_force_redeem_price" = "-";
 "redeem_count" = "6/30";
 "redeem_count_days" = 15;
 "redeem_dt" = "<null>";
 "redeem_flag" = X;
 "redeem_icon" = "";
 "redeem_price" = "108.00";
 "redeem_price_ratio" = "130.000%";
 "redeem_real_days" = 6;
 "redeem_tc" = "\U5728\U8f6c\U80a1\U671f\U5185\Uff0c\U5982\U679c\U516c\U53f8\U80a1\U7968\U5728\U4efb\U4f55\U8fde\U7eed\U4e09\U5341\U4e2a\U4ea4\U6613\U65e5\U4e2d\U81f3\U5c11\U5341\U4e94\U4e2a\U4ea4\U6613\U65e5\U7684\U6536\U76d8\U4ef7\U683c\U4e0d\U4f4e\U4e8e\U5f53\U671f\U8f6c\U80a1\U4ef7\U683c\U7684 130%\Uff08\U542b 130%\Uff09";
 "redeem_total_days" = 30;
 sprice = "10.50";
 */



@property (nonatomic,strong) NSMutableArray *beiWangImagePaths;
@property (nonatomic,copy) NSString *noteDate;


@property (nonatomic,copy) NSString *bond_id;//代码
@property (nonatomic,copy) NSString *bond_nm;//名称
@property (nonatomic,copy) NSString *btype;

@property (nonatomic,copy) NSString *convert_dt;
@property (nonatomic,copy) NSString *convert_price;
@property (nonatomic,copy) NSString *curr_iss_amt;

@property (nonatomic,copy) NSString *force_redeem;
@property (nonatomic,copy) NSString *force_redeem_price;//强赎触发价
@property (nonatomic,copy) NSString *next_put_dt;

@property (nonatomic,copy) NSString *orig_iss_amt;
@property (nonatomic,copy) NSString *real_force_redeem_price;
@property (nonatomic,copy) NSString *redeem_count;

@property (nonatomic,copy) NSString *redeem_count_days;
@property (nonatomic,copy) NSString *redeem_dt;
@property (nonatomic,copy) NSString *redeem_flag;

@property (nonatomic,copy) NSString *redeem_price;
@property (nonatomic,copy) NSString *redeem_price_ratio;
@property (nonatomic,copy) NSString *redeem_real_days;

@property (nonatomic,copy) NSString *redeem_tc;
@property (nonatomic,copy) NSString *redeem_total_days;
//@property (nonatomic,copy) NSString *sprice;

@end

NS_ASSUME_NONNULL_END
