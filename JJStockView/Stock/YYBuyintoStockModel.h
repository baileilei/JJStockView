//
//  YYBuyintoStockModel.h
//  JJStockView
//
//  Created by g on 2019/2/24.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGModelProtocol.h"

@interface YYBuyintoStockModel : NSObject<XMGModelProtocol>

@property (nonatomic,copy) NSString *stockURL;
@property (nonatomic,copy) NSString *passAndFuture;//已发行且将要发行




@property (nonatomic,copy) NSString *bond_id;//
@property (nonatomic,copy) NSString *bond_nm;//

// buyTime   buyDecisionComment   TargetPrice  buyPrice  buyCount sellTime     sellDecisionComment
@property (nonatomic,copy) NSString *stock_nm;
@property (nonatomic,copy) NSString *stock_id;
@property (nonatomic,copy) NSString *ma20_price;//
@property (nonatomic,copy) NSString *progress_nm;//
@property (nonatomic,copy) NSString *price;// *********************
@property (nonatomic,copy) NSString *cb_type;//

@property (nonatomic,copy) NSString *jsl_advise_text;//
@property (nonatomic,copy) NSString *convert_price;//**********************
@property (nonatomic,copy) NSString *progress_dt;

/**
 
 
 "id" : "603833",
 "cell" : {
 "status_cd" : "ON",
 "valid_apply" : "63.62",
 "apply_cd" : "754833",
 "stock_nm" : "欧派家居",
 "list_date" : <null>,
 "cb_amount" : "3.18",
 "stock_id" : "603833",
 "online_amount" : "3.55",
 "ration_rt" : "76.240",
 "offline_limit" : <null>,
 "ma20_price" : "101.36",
 "ap_flag" : "C",
 "increase_rt" : "5.75",
 "offline_draw" : <null>,
 "progress_dt" : "-",
 "progress_nm" : "2019-08-16申购<br>申购代码754833",
 "underwriter_rt" : <null>,
 "price" : "111.78",
 "cb_type" : "可转债",
 "cp_flag" : "Y",
 "jsl_advise_text" : "建议申购",
 "individual_limit" : 10000,
 "apply_tips" : "申购代码：754833；配售代码：753833；",
 "rating_cd" : "AA",
 "single_draw" : "0.5580",
 "bond_id" : "113543",
 "rid" : 309,
 "lucky_draw_rt" : "0.0558",
 "offline_accounts" : <null>,
 "bond_nm" : "欧派转债",
 "pma_rt" : "110.17",
 "apply_date" : "2019-08-16",
 "convert_price" : "101.46",
 "ration_cd" : "753833",
 "amount" : "14.95"
 }
 
 */
@end
