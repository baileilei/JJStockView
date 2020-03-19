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

@property (nonatomic,copy) NSString *real_force_redeem_price;// 真实强赎价
@property (nonatomic,copy) NSString *redeem_count_days;
@property (nonatomic,copy) NSString *redeem_dt;//强赎日期
@property (nonatomic,copy) NSString *redeem_flag;//强赎标志

@property (nonatomic,copy) NSString *stock_id;//主键

@property (nonatomic,copy) NSString *stock_nm;//主键

@property (nonatomic,copy) NSString *stock_amt;//62668.4700

@property (nonatomic,copy) NSString *svolume;

@property (nonatomic,copy) NSString *bond_id;//债券代码

@property (nonatomic,copy) NSString *bond_nm;//债券代码

@property (nonatomic,copy) NSString *volume;//成交额   ------Y

@property (nonatomic,copy)NSString *date;

@property (nonatomic,copy) NSString *full_price;//债券现价

@property (nonatomic,copy) NSString *convert_price;//转股价

@property (nonatomic,copy) NSString *force_redeem_price;//强赎触发价！！！！
//@property (nonatomic,copy) NSString *premium_rt;
@property (nonatomic,copy) NSString *put_convert_price;//回售触发价！！！！
@property (nonatomic,copy) NSString *sprice;//股价

@property (nonatomic,copy) NSString *year_left;//剩余年限

@property (nonatomic,copy)NSString *bond_Degree;// 成交额(万)/cur_amt(亿)

@property (nonatomic,copy)NSString *bond_Degree_pm_date;

@property (nonatomic,copy)NSString *stock_Degree_pm_date;

@property (nonatomic,copy)NSString *stock_Degree; //=成交量/(已流通股份-前十大股东-主力持仓)


@property (nonatomic,copy) NSString *premium_rt;

@property (nonatomic,copy) NSString *convert_amt_ratio;


/***********************************择时指标********************************************/
//会随着日期发生变化的标的


@property (nonatomic,copy) NSString *increase_rt;//债券涨跌幅   单日   7日的所有加起来即7日振幅

@property (nonatomic,copy) NSString *sincrease_rt;//股票涨跌幅    单日


@property (nonatomic,copy) NSString *currentEnergyFlow;//量能 

@property (nonatomic,copy) NSString *scurrentEnergyFlow;//量能


/***********************************基本面********************************************/
//三月之内不会有大变化的指标
//基本面是压舱石!!!   是择股的标准.     择时指标 回调建仓?
//
@property (nonatomic,copy) NSString *cpbd_dstx;//大事提醒

@property (nonatomic,copy) NSString *cpbd_xsjj;//解禁
@property (nonatomic,copy) NSString *cpbd_xsjj_jjsj;//解禁时间
@property (nonatomic,copy) NSString *cpbd_xsjj_jjsl;//解禁数量
@property (nonatomic,copy) NSString *cpbd_xsjj_jjgzzgbbl;//解禁股占总股本比例
@property (nonatomic,copy) NSString *cpbd_xsjj_jjgzltgbbl;//解禁股占流通股比例
@property (nonatomic,copy) NSString *cpbd_xsjj_gplx;//解禁类型

@property (nonatomic,copy) NSString *cpbd_hxtc;//核心题材
@property (nonatomic,copy) NSString *cpbd_hxtc_gjc;//核心题材-关键词 hxtc.gjc
@property (nonatomic,copy) NSString *cpbd_hxtc_ydnr;//核心题材-要点内容 hxtc.ydnr


@property (nonatomic,copy) NSString *cpbd_ggxx;//公告讯息
@property (nonatomic,copy) NSString *cpbd_ggxx_title;//公告讯息
@property (nonatomic,copy) NSString *cpbd_ggxx_summary;//公告讯息
@property (nonatomic,copy) NSString *cpbd_ggxx_uniqueUrl;//公告讯息
@property (nonatomic,copy) NSString *cpbd_ggxx_url;//公告讯息

@property (nonatomic,copy) NSString *cpbd_gggg;//公司公告
@property (nonatomic,copy) NSString *cpbd_gggg_title;//公司公告gggg.data.items.title
@property (nonatomic,copy) NSString *cpbd_gggg_url;//公司公告???gggg.data.items.title

@property (nonatomic,copy) NSString *cpbd_dzjy;//大宗交易
@property (nonatomic,copy) NSString *cpbd_jyrq;//大宗交易-交易日期
@property (nonatomic,copy) NSString *cpbd_cjj;//大宗交易-成交价
@property (nonatomic,copy) NSString *cpbd_cjl;//大宗交易-成交量
@property (nonatomic,copy) NSString *cpbd_cjje;//大宗交易-成交金额
@property (nonatomic,copy) NSString *cpbd_mryyb;//大宗交易-买入营业部
@property (nonatomic,copy) NSString *cpbd_mcyyb;//大宗交易-卖出营业部。 思路:模塑/通用之类的标的,哪些营业部有提前买入?  追踪营业部的净买入

@property (nonatomic,copy) NSString *cpbd_lhbd;//龙虎榜单 当日涨幅偏离值达7%的证券

@property (nonatomic,copy) NSString *cpbd_lhbd_title;//当日涨幅偏离值达7%的证券
@property (nonatomic,copy) NSString *cpbd_lhbd_rq;//当日涨幅偏离值达7%的证券
@property (nonatomic,copy) NSString *cpbd_lhbd_zl;//当日涨幅偏离值达7%的证券
@property (nonatomic,copy) NSString *cpbd_lhbd_mrzj;//买入总计
@property (nonatomic,copy) NSString *cpbd_lhbd_mrzjzjeb;//买入总计占金额比
@property (nonatomic,copy) NSString *cpbd_lhbd_mczj;//卖出总计占金额比
@property (nonatomic,copy) NSString *cpbd_lhbd_mczjzjeb;//卖出总计占金额比

@property (nonatomic,copy) NSString *cpbd_lhbd_group_mr_yybmc;//营业部名称-买入组
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mr_mrje;//营业部名称-买入金额
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mr_zjeb_mr;//营业部名称-买入金额-占金额比
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mr_mcje;//营业部名称-卖出金额
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mr_zjeb_mc;//营业部名称-卖出金额-占金额比

@property (nonatomic,copy) NSString *cpbd_lhbd_group_mc_yybmc;//营业部名称-买出组
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mc_mrje;//营业部名称-买入金额
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mc_zjeb_mr;//营业部名称-买入金额-占金额比
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mc_mcje;//营业部名称-卖出金额
@property (nonatomic,copy) NSString *cpbd_lhbd_group_mc_zjeb_mc;//营业部名称-卖出金额-占金额比





@property (nonatomic,copy) NSString *cpbd_rzrq;//融资融券

@property (nonatomic,copy) NSString *cpbd_gdrs;//股东人数
@property (nonatomic,copy) NSString *cpbd_gdrs_rq;//股东人数
@property (nonatomic,copy) NSString *cpbd_gdrs_gdrs;//股东人数
@property (nonatomic,copy) NSString *cpbd_gdrs_gdrs_jsqbh;//股东人数
@property (nonatomic,copy) NSString *cpbd_gdrs_rjltg_jsqbh;//股东人数
@property (nonatomic,copy) NSString *cpbd_gdrs_qsdltgdcghj;//前十大流通股东持股合计

@property (nonatomic,copy) NSString *cpbd_zyzb_abgq;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_rq;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_jbmgsy;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_kfmgsy;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_xsmgsy;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_gsjlr;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_mll;//主要指标-按报告期
@property (nonatomic,copy) NSString *cpbd_zyzb_abgq_ysk;//主要指标-按报告期

@property (nonatomic,copy) NSString *cpbd_zyzb_and;//主要指标-按年度

@property (nonatomic,copy) NSString *cpbd_zyzb_adjd;//主要指标-按单季度

@property (nonatomic,copy) NSString *cpbd_jgyc;//机构预测

@property (nonatomic,copy) NSString *cpbd_ggyb;//研报
@property (nonatomic,copy) NSString *cpbd_ggyb_title;//研报






@property (nonatomic,copy) NSString *ticai;

@property (nonatomic,copy) NSArray *ticaiList;

// 前十大股东   除其他以外的机构：基金/保险、券商、QFII，社保基金、信托。
/****解禁***RptRestrictedBanList*/
//http://f10.eastmoney.com/PC_HSF10/CapitalStockStructure/Index?type=soft&code=SH603822#
@property (nonatomic,copy)NSString *stock_jjsj;//解禁时间
@property (nonatomic,copy)NSString *stock_jjsl;//数量
@property (nonatomic,copy)NSString *stock_jjzgbl;//解禁总股比例
@property (nonatomic,copy)NSString *stock_jjltbl;//解禁流通比例

/****股本结构***CapitalStockStructureDetail*/
@property (nonatomic,copy)NSString *stock_ltsxgf;//流通受限股份
@property (nonatomic,copy)NSString *stock_ltsxgfzb;//流通受限股份占比
@property (nonatomic,copy)NSString *stock_yltgf;//已流通股份
@property (nonatomic,copy)NSString *stock_yltgfzb;//已流通股份占比
@property (nonatomic,copy)NSString *stock_zgb;//总股本
@property (nonatomic,copy)NSString *stock_zgbzb;//总股本占比

//http://f10.eastmoney.com/PC_HSF10/ShareholderResearch/Index?type=soft&code=SH603822#
/***sdltgd****十大流通股东*/
@property (nonatomic,copy)NSString *stock_sdlggdList;//十大股东List
//@property (nonatomic,copy)NSString *stock_sdltgd_mc;//名次
//@property (nonatomic,copy)NSString *stock_sdltgd_gdmc;//股东名称
//@property (nonatomic,copy)NSString *stock_sdltgd_gdxz;//股东性质
//@property (nonatomic,copy)NSString *stock_sdltgd_gflx;//股份类型
//@property (nonatomic,copy)NSString *stock_sdltgd_cgs_List;//持股数(股)
//@property (nonatomic,copy)NSString *stock_sdltgd_zltgbcgbl;//占总流通 股本持股比例
//@property (nonatomic,copy)NSString *stock_sdltgd_zj;//增减
//@property (nonatomic,copy)NSString *stock_sdltgd_bdbl;//变动比例

/***sdltgdbd****十大流通股东持股变动*/
@property (nonatomic,copy)NSString *stock_sdlggdbdList;//十大股东变动List

/***sdltgd_chart****十大流通股东持股变动*/    //集中度!!!
@property (nonatomic,copy)NSString *stock_sdlggdcg;//十大流通股东持股
@property (nonatomic,copy)NSString *stock_ltsxgf1;//流通受限股份
@property (nonatomic,copy)NSString *stock_qtltgf;//其余流通股份

/***zlcc****主力持仓-----基金/保险/券商/QFII/社保基金/信托/其他机构*/
@property (nonatomic,copy)NSString *stock_zlcc_List;//主力持仓
@property (nonatomic,copy)NSString *stock_zlcc_jglx;//机构类型
@property (nonatomic,copy)NSString *stock_zlcc_ccjs;//持仓家数
@property (nonatomic,copy)NSString *stock_zlcc_ccgs;//持仓股数
@property (nonatomic,copy)NSString *stock_zlcc_zltgbl;//占流通股比例
@property (nonatomic,copy)NSString *stock_zlcc_zltgbbl;//占总股本比例

/***jjcg****基金持股*/
//@property (nonatomic,copy)NSString *stock_jjcgList;//十大股东List
//@property (nonatomic,copy)NSString *stock_jjcg_jjdm;//基金代码
//@property (nonatomic,copy)NSString *stock_jjcg_jjmc;//基金名称
//@property (nonatomic,copy)NSString *stock_jjcg_cgs;//持股数(股)
//@property (nonatomic,copy)NSString *stock_jjcg_cgsz;//持股市值
//@property (nonatomic,copy)NSString *stock_jjcg_zzgbb;//占总股本比
//
//@property (nonatomic,copy)NSString *stock_jjcg_zltb;//占流通比
//@property (nonatomic,copy)NSString *stock_jjcg_zjzb;//占净值比
//@property (nonatomic,copy)NSString *stock_jjcg_order;//购买

/******可炒作性*****/

@property (nonatomic,copy) NSString *total_shares;//大小盘

@property (nonatomic,copy) NSString *curr_iss_amt;//大小盘

@property (nonatomic,copy) NSString *ssbk;//所属板块

@property (nonatomic,copy) NSString *ticaiNumbers;//所属板块

@property (nonatomic,copy) NSString *ticaiBrief;//经营范围

@property (nonatomic,copy) NSString *ticaiDetail;//其他项目

/*************股东意愿*********限售，商誉，减持？增持？锁定？****/

@property (nonatomic,copy) NSString *adj_scnt;//

@property (nonatomic,copy) NSString *adj_cnt;//下调次数


/******行业排名*****/
@property (nonatomic,copy) NSString *gsgmzsz;
@property (nonatomic,copy) NSString *gsgmltsz;

@property (nonatomic,copy) NSString *gsgmyysr;
@property (nonatomic,copy) NSString *gsgmjlr;

@property (nonatomic,copy) NSString *gsgmzsz_pm;
@property (nonatomic,copy) NSString *gsgmltsz_pm;

@property (nonatomic,copy) NSString *gsgmyysr_pm;
@property (nonatomic,copy) NSString *gsgmjlr_pm;

//xmlist
@property (nonatomic,copy) NSString *xmList;
@property (nonatomic,copy) NSString *xmListBrief;

@property (nonatomic,copy) NSString *zygcList;
@property (nonatomic,copy) NSString *zygcListBrief;

//缩量滞跌,缩量上涨---局部 (买入)   放量滞涨  放量下跌 ，一周为宜   

//SELECT svolume,volume,full_price FROM YYActiveDegree WHERE svolume * 100 < volume * 100;
/*                               到期收益率         日线特征      剩余年限/剩余规模 转债占比=转债余额/总市值
1579.89    11109.57    111.916       -0.49%       异常？-----今天就涨了6%！
8856.79    19671.75    116.610     未到转股期 -0.21%
4278.28    6123.82    122.980         -1.57%
12445.07    22801.11    120.210    未到转股期
2427.46    2919.88    92.670（92-100）    5.49%    跳空高开——初期     5.063/7.5    41%(压力系数)
3256.47    7651.87    97.426（97-100）    5.41%    跳空高开——第一个    2.573/12      29.4%
 
 -----------
 8263.44    1607.80    113.050                跳空高开-连续          3.989/3.042      4.9%
 3984.91    469.05     103.750                 节节阳线              4.175/7.5       19.5%
 
 http://data.eastmoney.com/gdhs/  股东户数查询
 */

@end

NS_ASSUME_NONNULL_END

/*
 {
 "hxtc" : [
 {
 "gjc" : "所属板块",
 "jyscbm" : "--",
 "yd" : "1",
 "ydnr" : "OLED 创业板综 电子元件 独角兽 广东板块 华为概念 深圳特区 转债标的",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "经营范围",
 "jyscbm" : "--",
 "yd" : "2",
 "ydnr" : "电子半导体工业自动化设备;光电平板显示(LCD\/LCM\/TP\/OLED\/PDP)工业自动化设备、检测设备、其他自动化非标专业设备,设施、工装夹具、工控软件的研发、设计、销售和技术服务;货物及技术进出口。(法律、行政法规、国务院决定规定在登记前须批准的项目除外)。普通货运;光电平板显示(LCD\/LCM\/TP\/OLED\/PDP)工业自动化设备、检测设备、其他自动化非标专业设备,设施、工装夹具、工控软件的生产。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "平板显示器件及相关零组件生产设备的研发、制造、销售和服务",
 "jyscbm" : "--",
 "yd" : "3",
 "ydnr" : "公司主要致力于平板显示模组组装设备的研发、生产和销售,主要产品包括邦定设备及贴合设备。公司所产设备可广泛应用于平板显示器件中显示模组,主要是TFT-LCD显示模组,以及触摸屏等相关零组件的模组组装生产过程。借助模组组装设备生产的平板显示器件及相关零组件,是包括智能手机、移动电脑、平板电视、液晶显示器在内的新兴消费类电子产品和其他需要显示功能的终端产品中不可或缺的组成部分。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "电子专用设备行业",
 "jyscbm" : "--",
 "yd" : "4",
 "ydnr" : "公司生产的设备运用于实现平板显示模组及触摸屏的组装工序,借助模组组装设备生产的平板显示器件及相关零组件,是包括智能手机、移动电脑、平板电视、液晶显示器在内的新兴消费类电子产品和其他需要显示功能的终端产品中不可或缺的组成部分。电子消费类行业具有周期性,其发展受到宏观经济的制约。经济发展良好时,人们在电子产品上的支出会增加,该行业也能得到较好的发展。而当经济低迷时,人们缩减开支,减少在电子产品上的支出,电子消费类行业的收入会因而受到影响。电子消费类产品的需求变动对面板厂商的投资意向有重要作用,进一步影响设备厂商的生产与销售。因此,平板显示器件生产设备制造行业也具备周期性的特点。而且,平板显示器件生产设备制造行业的周期性变化具有滞后性,这是因为面板厂商对电子需求变动作出反应需要一定的时间,同时面板厂商产线建设、设备厂商设备研发生产具有较长的时间跨度。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "行业经验优势",
 "jyscbm" : "--",
 "yd" : "6",
 "ydnr" : "公司于2002年开始从事平板显示器件及相关零组件生产设备制造,是我国较早进入平板显示器件及相关零组件生产设备行业的企业。十余年来,公司经历了平板显示产业的多种技术变革,对平板显示产业各种知识体系和生产工艺进行了持续的深入钻研和探索,通过多年的技术沉淀和积累实现了平板显示产业各种技术之间的掌握和融合,积累了丰富的平板显示器件及相关零组件生产设备制造经验,具备了良好的产品研发设计能力和制造工艺水平,使公司的产品研发设计能力、产品质量性能均处于行业前列,为公司的可持续发展奠定了良好的基础。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "质量和品牌优势",
 "jyscbm" : "--",
 "yd" : "7",
 "ydnr" : "公司自成立以来,一直专注于电子专用设备的研发与生产,产品质量和生产技术在行业内处于先进水平。随着技术和服务水平的不断提升、品牌的不断深化以及市场的不断开拓,公司逐步确立了国内平板显示器件及相关零组件生产设备制造领域的优势地位,并凭借优异的产品质量和多年来积累的核心技术优势在业内树立了良好的口碑。目前,公司已经拥有一批具有长期稳定合作关系的客户,产品已服务于全球领先的知名平板显示产品生产企业,在平板显示器件及相关零组件生产设备领域确立了较高的品牌知名度,为公司的持续发展和市场开拓奠定了良好的基础。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "平板显示自动化专业设备生产基地建设项目",
 "jyscbm" : "--",
 "yd" : "8",
 "ydnr" : "平板显示自动化专业设备生产基地建设项目包含热压设备、贴合设备及其他模组组装设备等三大类,产品技术可达国际同类产品标准。伴随智能手机、平板电脑等新兴消费类电子产品市场的扩张,平板显示行业迅速发展,广泛应用于平板显示领域的显示器件及相关零组件及生产设备领域市场需求扩大。通过本项目的实施,公司将建设国内领先的平板显示自动化专业设备生产基地,以满足日益发展的平板显示行业对该类设备的需求,解决市场需求旺盛与公司产能不足的矛盾,打破现有产能限制并为公司提供良好的投资回报和经济效益。建设期为2年,本项目投资金额18,088.59万元,其中建筑工程投资7,275.51万元,设备投资7,332.30万元,铺底流动资金3,480.78万元。其中使用募集资金9,018.54万元。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 },
 {
 "gjc" : "税收优惠",
 "jyscbm" : "--",
 "yd" : "15",
 "ydnr" : "2017年8月17日,本公司高新技术企业资格的相关复审已获通过,取得了GR201744200826号《高新技术企业证书》,有效期3年,根据高新技术企业税收优惠政策,企业所得税率按15%征收,即2017-2019年实际执行税率为15%。",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"
 }
 ]
 }

 */
