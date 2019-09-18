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
//increase_rt  sincrease_rt  volume
//重点指标：year_left。stockURL  bondURL  convert_dt passConvert_dt_days  convert_price  convert_value force_redeem_price full_price put_convert_price sprice volume

//强赎区  突破区。 建仓区


@property (nonatomic,copy) NSString *noteDate;

@property (nonatomic,assign) float ratio;
@property (nonatomic,assign) float stockRatio;

@property (nonatomic,copy) NSString *stockURL;
@property (nonatomic,copy) NSString *stockConceptURL;//http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_CorpOtherInfo/stockid/002822/menu_num/5.phtml
//http://www.aichagu.com/zy/603915.html
@property (nonatomic,copy) NSString *stockMainBusinessURL;
@property (nonatomic,copy) NSString *bondURL;

@property (nonatomic,assign) float ma20_SI;//Sprice /convert_price

@property (nonatomic,copy) NSString *stockMostPrice;//总库
@property (nonatomic,copy) NSString *bondMostPrice;//总库 但是。  SIFasteBI的主键好像没起作用???

@property (nonatomic,copy) NSString *saveDate;//总表用


@property (nonatomic,copy) NSString *active_fl;
@property (nonatomic,copy) NSString *adjust_tc;//条件
@property (nonatomic,copy) NSString *adq_rating;
@property (nonatomic,copy) NSString *apply_cd;
@property (nonatomic,copy) NSString *bond_id;//债券代码
@property (nonatomic,copy) NSString *bond_nm;//债券名称
@property (nonatomic,copy) NSString *btype;//债券类型？
@property (nonatomic,copy) NSString *convert_amt_ratio;//转债占比    转债余额/总市值   👀

@property (nonatomic,copy) NSString *convert_cd;//转股代码------即过了转股起始期之后才会有的  //未到转股期
@property (nonatomic,copy) NSString *convert_dt;//转股起始期
@property (nonatomic,copy) NSString *passConvert_dt_days;//转股起始期
@property (nonatomic,copy) NSString *convert_price;//转股价
@property (nonatomic,copy) NSString *convert_value;//转股价值
@property (nonatomic,copy) NSString *cpn_desc;//债券利息
@property (nonatomic,copy) NSString *curr_iss_amt;//当前规模
@property (nonatomic,copy) NSString *force_redeem;
@property (nonatomic,copy) NSString *force_redeem_price;//强赎触发价！！！！

@property (nonatomic,copy) NSString *full_price;//债券现价
@property (nonatomic,copy) NSString *guarantor;//无担保
@property (nonatomic,copy) NSString *increase_rt;//债券涨跌幅   单日
@property (nonatomic,copy) NSString *issue_dt;//发布日期
@property (nonatomic,copy) NSString *last_time;
@property (nonatomic,copy) NSString *left_put_year;
@property (nonatomic,copy) NSString *list_dt;//上市日期
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
@property (nonatomic,copy) NSString *price_tips;//
@property (nonatomic,copy) NSString *put_convert_price;//回售触发价！！！！
@property (nonatomic,copy) NSString *put_convert_price_ratio;
@property (nonatomic,copy) NSString *put_count_days;
@property (nonatomic,copy) NSString *put_dt;//回售日期
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
@property (nonatomic,copy) NSString *redeem_dt;//强赎日期
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
@property (nonatomic,copy) NSString *short_maturity_dt;//到期日期简写
@property (nonatomic,copy) NSString *sincrease_rt;//股票涨跌幅    单日



@property (nonatomic,copy) NSString *sprice;//股价
@property (nonatomic,copy) NSString *sqflg;
@property (nonatomic,copy) NSString *stock_amt;//62668.4700
@property (nonatomic,copy) NSString *stock_cd;
@property (nonatomic,copy) NSString *stock_id;//股票代码
@property (nonatomic,copy) NSString *stock_net_value;//PB ------纯债价值？ 期权价值？
@property (nonatomic,copy) NSString *stock_nm;//股票名称
@property (nonatomic,copy) NSString *volume;//成交额   ------Y

@property (nonatomic,copy) NSString *year_left;//剩余年限
@property (nonatomic,copy) NSString *ytm_rt;//到期税前收益
@property (nonatomic,copy) NSString *ytm_rt_tax;//到期税后收益

@property (nonatomic,copy) NSString *pinyin;
@end
/*
 {"pb":"6.95""bond_id":"128068","bond_nm":"和而转债","stock_id":"sz002402","stock_nm":"和而泰","convert_price":"9.090","convert_dt":"2019-12-11","maturity_dt":"2025-06-04","next_put_dt":"2023-06-05","put_dt":null,"put_notes":null,"put_price":"100.000","put_inc_cpn_fl":"y","put_convert_price_ratio":"43.55","put_count_days":30,"put_total_days":30,"put_real_days":0,"repo_discount_rt":"0.00","repo_valid_from":null,"repo_valid_to":null,"redeem_price":"108.000","redeem_inc_cpn_fl":"n","redeem_price_ratio":"130.000","redeem_count_days":15,"redeem_total_days":30,"redeem_real_days":0,"redeem_dt":null,"redeem_flag":"X","orig_iss_amt":"5.470","curr_iss_amt":"5.470","rating_cd":"AA-","issuer_rating_cd":"AA-","guarantor":"无担保","force_redeem":null,"real_force_redeem_price":null,"convert_cd":"未到转股期","repo_cd":null,"ration":null,"ration_cd":"082402","apply_cd":"072402","online_offline_ratio":null,"qflag":"N","qflag2":"N","ration_rt":"37.700","fund_rt":"buy","pb":"6.95","total_shares":"855435396.0","sqflg":"Y","sprice":"14.61","svolume":"49327.49","sincrease_rt":"1.32%","qstatus":"00","last_time":"15:00:03","convert_value":"160.73","premium_rt":"-12.77%","year_left":"5.732","ytm_rt":"-3.71%","ytm_rt_tax":"-4.11%","price":"140.200","full_price":"140.200","increase_rt":"0.53%","volume":"5447.98","adj_scnt":0,"adj_cnt":0,"redeem_icon":"","redeem_style":"Y","owned":0,"noted":0,"ref_yield_info":"","adjust_tip":"","left_put_year":"-","short_maturity_dt":"25-06-04","force_redeem_price":"11.82","put_convert_price":"6.36","convert_amt_ratio":"4.4%","stock_net_value":"0.00","stock_cd":"002402","pre_bond_id":"sz128068","repo_valid":"有效期：-","convert_cd_tip":"未到转股期；2019-12-11 开始转股","price_tips":"全价：140.200 最后更新：15:00:03"}
 
 */
