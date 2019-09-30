//
//  YYDueBondModel.h
//  JJStockView
//
//  Created by smart-wift on 2019/9/30.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYDueBondModel : NSObject

@property (nonatomic,copy) NSString *bond_id;
@property (nonatomic,copy) NSString *bond_nm;
@property (nonatomic,copy) NSString *price;

@property (nonatomic,copy) NSString *stock_id;
@property (nonatomic,copy) NSString *stock_nm;

@property (nonatomic,copy) NSString *orig_iss_amt;
@property (nonatomic,copy) NSString *put_iss_amt;
@property (nonatomic,copy) NSString *curr_iss_amt;

@property (nonatomic,copy) NSString *issue_dt;
@property (nonatomic,copy) NSString *delist_dt;
@property (nonatomic,copy) NSString *maturity_dt;

@property (nonatomic,copy) NSString *listed_years;
@property (nonatomic,copy) NSString *delist_notes;


@end

NS_ASSUME_NONNULL_END
/*{"bond_id":"110009","bond_nm":"双良转债","price":"93.820","stock_id":"600481","stock_nm":"双良节能","orig_iss_amt":"7.200","put_iss_amt":"6.938","curr_iss_amt":"0.261","issue_dt":"2010-05-04","delist_dt":"2011-12-14","maturity_dt":"2015-05-04","listed_years":"1.6","delist_notes":"不足3000万"}*/
