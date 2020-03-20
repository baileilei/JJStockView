//
//  YYShareHoldersModel.h
//  JJStockView
//
//  Created by smart-wift on 2020/3/17.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class YYGgdrsModel,YYSdltgdModel,YYJjcgModel,YYZlccModel;

@interface YYShareHoldersModel : NSObject

@property (nonatomic,copy) NSString *stock_id;//主键

@property (nonatomic,copy) NSString *bond_nm;//债券代码

@property (nonatomic,strong)NSMutableArray <YYGgdrsModel *>*gdrs_List_json;

@property (nonatomic,strong)NSMutableArray <YYSdltgdModel *>*sdltgd_List_json;//个人  其他    证券投资基金？？？

@property (nonatomic,strong)NSMutableArray <YYJjcgModel *>*jjcc_List_json;//基金

@property (nonatomic,strong)NSMutableArray <YYZlccModel *>*zlcc_List_json;// 除其他机构外的：信托、社保基金、QFII、券商、保险、基金


@property (nonatomic,strong)NSString *gdrs_List_Str;

@property (nonatomic,strong)NSString *gdrs_jsqbh_Str;//都小于0就好*************************************************************************趋势

@property (nonatomic,strong)NSString *gdrs_rjltg_Str;

@property (nonatomic,strong)NSString *gdrs_rjltg_jsqbh_Str;//都大于0 就好********************************************************************趋势

@property (nonatomic,strong)NSString *gdrs_qsdltgdcghj_Str;



@property (nonatomic,copy) NSString *stock_qsdltgdcghj_jjcg_zltglbs;//十大流通股比例+机构持股占流通股比例gdrs_List_Str.first.floatValue + zlcc_List_str   关注>70%
//盈利能力
@property (nonatomic,copy) NSString *zyzb_abgq_mll;//主要指标-按报告期
//http://f10.eastmoney.com/PC_HSF10/NewFinanceAnalysis/MainTargetAjax?type=0&code=SH603822
@property (nonatomic,copy) NSString *zyzb_abgq_jll;//主要指标-按报告期
//成长能力
@property (nonatomic,copy) NSString *zyzb_yyzsr;//主要指标-按报告期
//http://f10.eastmoney.com/PC_HSF10/NewFinanceAnalysis/MainTargetAjax?type=0&code=SH603822
@property (nonatomic,copy) NSString *zyzb_mlr;//主要指标-按报告期  同行之间比较才有意义,  有的快消行业,低毛利率但是快周转率也可以取得不错的业绩.
//分红能力
@property (nonatomic,copy) NSString *zyzb_mgjzc;//主要指标-按报告期
@property (nonatomic,copy) NSString *zyzb_mggjj;//主要指标-按报告期
@property (nonatomic,copy) NSString *zyzb_mgwfply;//主要指标-按报告期
@property (nonatomic,copy) NSString *zyzb_mgjyxjl;//主要指标-按报告期

/*
每股净资产(元)    10.0555    10.0506    9.8666    9.7330    9.6624    9.6487    9.4884    9.4249    9.2549
每股公积金(元)    3.0975    3.3097    3.3097    3.3097    3.3097    3.4786    3.4785    3.4722    3.4206
每股未分配利润(元)    5.3954    5.1783    4.9943    4.8607    4.7901    4.6394    4.4791    4.4219    4.3035
每股经营现金流(元)    1.8030    1.2372    0.8830    0.5856    -0.7898    -0.0321    0.1380    -0.1063    2.1235
成长能力指标    19-12-31    19-09-30    19-06-30    19-03-31    18-12-31    18-09-30    18-06-30    18-03-31    17-12-31
营业总收入(元)    12.5亿    8.46亿    5.03亿    2.08亿    10.4亿    7.72亿    4.70亿    1.99亿    8.83亿
毛利润(元)    1.68亿    1.15亿    6507万    2303万    1.37亿    1.05亿    6244万    2423万    1.09亿
 */
@end

NS_ASSUME_NONNULL_END

@interface YYGgdrsModel : NSObject

@property (nonatomic,copy) NSString *rq;
@property (nonatomic,copy) NSString *gdrs;
@property (nonatomic,copy) NSString *gdrs_jsqbh;

@property (nonatomic,copy) NSString *rjltg;//人均流通股
@property (nonatomic,copy) NSString *rjltg_jsqbh;

@property (nonatomic,copy) NSString *cmjzd;//筹码集中度   平均持股数/公司流通股股数= 筹码集中度
@property (nonatomic,copy) NSString *gj;
@property (nonatomic,copy) NSString *rjcgje;//人均持股金额

@property (nonatomic,copy) NSString *qsdfdcfhj;//前十大股东持股合计
@property (nonatomic,copy) NSString *qsdltgdcghj;//前十大流通股东持股合计

@end


@interface YYSdltgdModel : NSObject

@property (nonatomic,copy) NSString *rq;
@property (nonatomic,copy) NSString *mc;
@property (nonatomic,copy) NSString *gdmc;

@property (nonatomic,copy) NSString *gdxz;//股东性质
@property (nonatomic,copy) NSString *gflx;//股份类型

@property (nonatomic,copy) NSString *cgs;//筹码集中度   平均持股数/公司流通股股数= 筹码集中度
@property (nonatomic,copy) NSString *zltgbcgbl;//占流通股本持股比例
@property (nonatomic,copy) NSString *bdbl;//变动比例

@end


@interface YYJjcgModel : NSObject

@property (nonatomic,copy) NSString *rq;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *jjdm;// 基金代码

@property (nonatomic,copy) NSString *jjmc;//股东性质
@property (nonatomic,copy) NSString *cgs;//股份类型

@property (nonatomic,copy) NSString *cgsz;//持股市值
@property (nonatomic,copy) NSString *zzgbb;//占总股本比例
@property (nonatomic,copy) NSString *zltb;//  占流通比


@end

@interface YYZlccModel : NSObject

@property (nonatomic,copy) NSString *rq;
@property (nonatomic,copy) NSString *jglx;// 基金 保险 券商 QFII 社保基金 信托     其他机构不算！

@property (nonatomic,copy) NSString *ccjs;//股东性质
@property (nonatomic,copy) NSString *ccgs;//股份类型

@property (nonatomic,copy) NSString *zltgbbl;//占总股本比例
@property (nonatomic,copy) NSString *zltgbl;//  占流通股比例

@end
