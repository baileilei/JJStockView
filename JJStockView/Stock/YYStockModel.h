//
//  YYStockModel.h
//  HandleStockJson
//https://www.jisilu.cn/data/cbnew/detail_pic/?display=premium_rt&bond_id=113539。 bondPricHistory
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 pactera. All rights reserved.
//即将出下修？
// 交易系统。。。  1.买卖什么（标的）。2.买卖多少。3.何时买。4.止损条件。5.离市---何时出仓！  6.策略：如何买卖
//。            SI》10。        一成。      回撤时！BP<100         债券急涨的时候！（100以上的时候，BI>6 时建仓！一成 回调时加仓。） 130以上（BI回调时减2成仓）。  一个SI一成

//没有确定的交易系统，即便是大涨了也是焦虑的！  大族？ 是为了发行下个转债做准备！！！
//统计套利！ 统计SI（count）
//思路错了量化也救不了你」。    黄金 思路？？？       凯发 130的时候，我竟然不敢卖！！！  总是焦虑！！！

#import <Foundation/Foundation.h>
#import "XMGModelProtocol.h"

@interface YYStockModel : NSObject<XMGModelProtocol>
//increase_rt  sincrease_rt  volume
//重点指标：year_left。stockURL  bondURL  convert_dt passConvert_dt_days  convert_price  convert_value force_redeem_price full_price put_convert_price sprice volume

//强赎区  突破区。 建仓区
//炒作的参考点：convertToStockRatio 概念/主营业务 

@property (nonatomic,copy) NSString *noteDate;

@property (nonatomic,assign) float ratio;// BRatio   = ma20_BI - 1 转股溢价率
@property (nonatomic,assign) float stockRatio; // = ma20_SI -1; //股票初始溢价率

@property (nonatomic,copy) NSString *stockURL;// wande --------自动化， 深入学习？？？
//目的是拿到个股的历史数据----------
//xinlang sina
@property (nonatomic,copy) NSString *stockConceptURL;//http://vip.stock.finance.sina.com.cn/corp/go.php/vCI_CorpOtherInfo/stockid/002822/menu_num/5.phtml
//http://www.aichagu.com/zy/603915.html
@property (nonatomic,copy) NSString *stockMainBusinessURL;//tonghuashun
//https://www.jisilu.cn/data/stock/002402
@property (nonatomic,copy) NSString *stockGongGaoURL;//jisilu
@property (nonatomic,copy) NSString *bondURL;

@property (nonatomic,copy) NSString *stockConcept;
@property (nonatomic,copy) NSString *stockMainBusiness;

@property (nonatomic,copy) NSString *holdCountStrJson;

@property (nonatomic,assign) int SIBibber9Count;
@property (nonatomic,assign) float convertToStockRatio;

@property (nonatomic,assign) float ma20_SI;//Sprice /convert_price------- 股价距离标准的波动程度  0.97+热点
@property (nonatomic,assign) float ma20_BI;

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
@property (nonatomic,copy) NSString *convert_amt_ratio;//转债占比    转债余额/总市值   convertToStockRatio？

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


@property (nonatomic,copy) NSString *real_force_redeem_price;// 真实强赎价
@property (nonatomic,copy) NSString *redeem_count_days;
@property (nonatomic,copy) NSString *redeem_dt;//强赎日期
@property (nonatomic,copy) NSString *redeem_inc_cpn_fl;
@property (nonatomic,copy) NSString *redeem_price;//到期赎回价格
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
@property (nonatomic,copy) NSString *svolume;
@property (nonatomic,copy) NSString *volume;//成交额   ------Y

@property (nonatomic,copy) NSString *year_left;//剩余年限
@property (nonatomic,copy) NSString *ytm_rt;//到期税前收益
@property (nonatomic,copy) NSString *ytm_rt_tax;//到期税后收益

@property (nonatomic,copy) NSString *pinyin;

@property (nonatomic,copy) NSString *ticai;


@end
/*
 {"pb":"6.95""bond_id":"128068","bond_nm":"和而转债","stock_id":"sz002402","stock_nm":"和而泰","convert_price":"9.090","convert_dt":"2019-12-11","maturity_dt":"2025-06-04","next_put_dt":"2023-06-05","put_dt":null,"put_notes":null,"put_price":"100.000","put_inc_cpn_fl":"y","put_convert_price_ratio":"43.55","put_count_days":30,"put_total_days":30,"put_real_days":0,"repo_discount_rt":"0.00","repo_valid_from":null,"repo_valid_to":null,"redeem_price":"108.000","redeem_inc_cpn_fl":"n","redeem_price_ratio":"130.000","redeem_count_days":15,"redeem_total_days":30,"redeem_real_days":0,"redeem_dt":null,"redeem_flag":"X","orig_iss_amt":"5.470","curr_iss_amt":"5.470","rating_cd":"AA-","issuer_rating_cd":"AA-","guarantor":"无担保","force_redeem":null,"real_force_redeem_price":null,"convert_cd":"未到转股期","repo_cd":null,"ration":null,"ration_cd":"082402","apply_cd":"072402","online_offline_ratio":null,"qflag":"N","qflag2":"N","ration_rt":"37.700","fund_rt":"buy","pb":"6.95","total_shares":"855435396.0","sqflg":"Y","sprice":"14.61","svolume":"49327.49","sincrease_rt":"1.32%","qstatus":"00","last_time":"15:00:03","convert_value":"160.73","premium_rt":"-12.77%","year_left":"5.732","ytm_rt":"-3.71%","ytm_rt_tax":"-4.11%","price":"140.200","full_price":"140.200","increase_rt":"0.53%","volume":"5447.98","adj_scnt":0,"adj_cnt":0,"redeem_icon":"","redeem_style":"Y","owned":0,"noted":0,"ref_yield_info":"","adjust_tip":"","left_put_year":"-","short_maturity_dt":"25-06-04","force_redeem_price":"11.82","put_convert_price":"6.36","convert_amt_ratio":"4.4%","stock_net_value":"0.00","stock_cd":"002402","pre_bond_id":"sz128068","repo_valid":"有效期：-","convert_cd_tip":"未到转股期；2019-12-11 开始转股","price_tips":"全价：140.200 最后更新：15:00:03"}
 
 "adj_cnt" : 0,
 "adj_scnt" : 0,
 "adjust_tip" : "",
 "apply_cd" : "754089",
 "bond_id" : "113561",
 "bond_nm" : "正裕转债",
 "convert_amt_ratio" : "12.6%",
 "convert_cd" : "未到转股期",
 "convert_cd_tip" : "未到转股期；2020-07-07 开始转股",
 "convert_dt" : "2020-07-07",
 "convert_price" : "14.210",
 "convert_price_valid" : "Y",
 "convert_price_valid_from" : null,
 "convert_value" : "104.50",
 "curr_iss_amt" : "2.900",
 "force_redeem" : null,
 "force_redeem_price" : "18.47",
 "full_price" : "100.000",
 "fund_rt" : "buy",
 "guarantor" : "股票质押的担保",
 "increase_rt" : "0.00%",
 "issuer_rating_cd" : "A+",
 "last_time" : null,
 "left_put_year" : "-",
 "margin_flg" : "",
 "maturity_dt" : "2025-12-30",
 "next_put_dt" : "2023-12-29",
 "noted" : 0,
 "online_offline_ratio" : null,
 "orig_iss_amt" : "2.900",
 "owned" : 0,
 "pb" : "2.79",
 "pre_bond_id" : "sh113561",
 "premium_rt" : "-4.31%",
 "price" : "100.000",
 "price_tips" : "待上市",
 "put_convert_price" : "9.95",
 "put_convert_price_ratio" : "66.98",
 "put_count_days" : 30,
 "put_dt" : null,
 "put_inc_cpn_fl" : "y",
 "put_notes" : null,
 "put_price" : "100.000",
 "put_real_days" : 0,
 "put_total_days" : 30,
 "qflag" : "N",
 "qflag2" : "N",
 "qstatus" : "00",
 "rating_cd" : "A+",
 "ration" : null,
 "ration_cd" : "753089",
 "ration_rt" : "33.460",
 "real_force_redeem_price" : null,
 "redeem_count_days" : 15,
 "redeem_dt" : null,
 "redeem_flag" : "X",
 "redeem_icon" : "",
 "redeem_inc_cpn_fl" : "n",
 "redeem_price" : "112.000",
 "redeem_price_ratio" : "130.000",
 "redeem_real_days" : 0,
 "redeem_style" : "Y",
 "redeem_total_days" : 30,
 "ref_yield_info" : "",
 "repo_cd" : null,
 "repo_discount_rt" : "0.00",
 "repo_valid" : "有效期：-",
 "repo_valid_from" : null,
 "repo_valid_to" : null,
 "short_maturity_dt" : "25-12-30",
 "sincrease_rt" : "-1.07%",
 "sprice" : "14.85",
 "sqflg" : "Y",
 "stock_cd" : "603089",
 "stock_id" : "sh603089",
 "stock_net_value" : "0.00",
 "stock_nm" : "正裕工业",
 "svolume" : "1390.76",
 "total_shares" : "154671500.0",
 "volume" : "0.00",
 "year_left" : "5.959",
 "ytm_rt" : "2.96%",
 "ytm_rt_tax" : "2.39%"
 
 */
