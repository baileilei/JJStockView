//
//  YYStockModel.h
//  HandleStockJson
//
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGModelProtocol.h"

@interface YYStockModel : NSObject<XMGModelProtocol>

@property (nonatomic,copy) NSString *active_fl;
@property (nonatomic,copy) NSString *adjust_tc;//条件
@property (nonatomic,copy) NSString *adq_rating;
@property (nonatomic,copy) NSString *apply_cd;
@property (nonatomic,copy) NSString *bond_id;//债券代码
@property (nonatomic,copy) NSString *bond_nm;//债券名称
@property (nonatomic,copy) NSString *btype;//债券类型？
@property (nonatomic,copy) NSString *convert_amt_ratio;//转债占比

@property (nonatomic,copy) NSString *convert_cd;//转股代码------即过了转股起始期之后才会有的  //未到转股期
@property (nonatomic,copy) NSString *convert_dt;//转股起始期
@property (nonatomic,copy) NSString *convert_price;//转股价
@property (nonatomic,copy) NSString *convert_value;//转股价值
@property (nonatomic,copy) NSString *cpn_desc;//债券利息
@property (nonatomic,copy) NSString *curr_iss_amt;
@property (nonatomic,copy) NSString *force_redeem;
@property (nonatomic,copy) NSString *force_redeem_price;//强赎触发价

@property (nonatomic,copy) NSString *full_price;//债券现价
@property (nonatomic,copy) NSString *guarantor;//无担保
@property (nonatomic,copy) NSString *increase_rt;
@property (nonatomic,copy) NSString *issue_dt;//发布日期
@property (nonatomic,copy) NSString *last_time;
@property (nonatomic,copy) NSString *left_put_year;
@property (nonatomic,copy) NSString *list_dt;
@property (nonatomic,copy) NSString *market;// sz

@property (nonatomic,copy) NSString *maturity_dt;//到期时间
@property (nonatomic,copy) NSString *next_put_dt;//下个利息发放期
@property (nonatomic,copy) NSString *online_offline_ratio;
@property (nonatomic,copy) NSString *orig_iss_amt;
@property (nonatomic,copy) NSString *owned;
@property (nonatomic,copy) NSString *pb;
@property (nonatomic,copy) NSString *pre_bond_id;//转债代码
@property (nonatomic,copy) NSString *premium_rt;


@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *price_tips;
@property (nonatomic,copy) NSString *put_convert_price;//回售触发价
@property (nonatomic,copy) NSString *put_convert_price_ratio;
@property (nonatomic,copy) NSString *put_count_days;
@property (nonatomic,copy) NSString *put_dt;
@property (nonatomic,copy) NSString *put_inc_cpn_fl;
@property (nonatomic,copy) NSString *put_price;//债券回售价



@property (nonatomic,copy) NSString *put_real_days;
@property (nonatomic,copy) NSString *put_tc;
@property (nonatomic,copy) NSString *put_total_days;
@property (nonatomic,copy) NSString *qflag;
@property (nonatomic,copy) NSString *rating_cd;
@property (nonatomic,copy) NSString *ration;
@property (nonatomic,copy) NSString *ration_cd;//债券评级
@property (nonatomic,copy) NSString *ration_rt;


@property (nonatomic,copy) NSString *real_force_redeem_price;
@property (nonatomic,copy) NSString *redeem_count_days;
@property (nonatomic,copy) NSString *redeem_dt;
@property (nonatomic,copy) NSString *redeem_inc_cpn_fl;
@property (nonatomic,copy) NSString *redeem_price;//赎回价格
@property (nonatomic,copy) NSString *redeem_price_ratio;//130
@property (nonatomic,copy) NSString *redeem_real_days;
@property (nonatomic,copy) NSString *redeem_tc;//赎回条件

@property (nonatomic,copy) NSString *redeem_total_days;
@property (nonatomic,copy) NSString *repo_cd;
@property (nonatomic,copy) NSString *repo_discount_rt;//折算率
@property (nonatomic,copy) NSString *repo_valid;//有效期
@property (nonatomic,copy) NSString *repo_valid_from;
@property (nonatomic,copy) NSString *repo_valid_to;
@property (nonatomic,copy) NSString *short_maturity_dt;
@property (nonatomic,copy) NSString *sincrease_rt;



@property (nonatomic,copy) NSString *sprice;
@property (nonatomic,copy) NSString *sqflg;
@property (nonatomic,copy) NSString *stock_amt;//62668.4700
@property (nonatomic,copy) NSString *stock_cd;
@property (nonatomic,copy) NSString *stock_id;//股票代码
@property (nonatomic,copy) NSString *stock_net_value;//PB
@property (nonatomic,copy) NSString *stock_nm;//股票名称
@property (nonatomic,copy) NSString *volume;//成交额

@property (nonatomic,copy) NSString *year_left;//剩余年限
@property (nonatomic,copy) NSString *ytm_rt;//到期税前收益
@property (nonatomic,copy) NSString *ytm_rt_tax;//到期税后收益

@property (nonatomic,copy) NSString *pinyin;
@end
