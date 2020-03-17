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

@property (nonatomic,strong)NSString *gdrs_jsqbh_Str;//都小于0就好

@property (nonatomic,strong)NSString *gdrs_rjltg_Str;

@property (nonatomic,strong)NSString *gdrs_rjltg_jsqbh_Str;//都大于0 就好

@property (nonatomic,strong)NSString *gdrs_qsdltgdcghj_Str;



@property (nonatomic,copy) NSString *stock_qsdltgdcghj_jjcg_zltglbs;//十大流通股比例+机构持股占流通股比例gdrs_List_Str.first.floatValue + zlcc_List_str   关注>70%


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
