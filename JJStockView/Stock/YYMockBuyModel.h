//
//  YYMockBuyModel.h
//  JJStockView
//
//  Created by smart-wift on 2019/9/6.
//  Copyright © 2019 Jezz. All rights reserved.
// ：buyIntoTime     cost=buyPrice   nowprice       holding  totalMarketPrice    updateTime  buyDesitionComment      bond_id

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYMockBuyModel : NSObject

@property (nonatomic,copy) NSString *bond_id;
@property (nonatomic,copy) NSString *bond_nm;

@property (nonatomic,assign) float holding;
@property (nonatomic,assign) float totalMarketPrice;

@property (nonatomic,assign) float buyCount;//100的倍数
@property (nonatomic,assign) float cost;//100的倍数
@property (nonatomic,copy) NSString *buyIntoTime;
@property (nonatomic,copy) NSString *buyPrice;




@property (nonatomic,copy) NSString *buyDecesionElements; //
@property (nonatomic,copy) NSString *fupan; //。

@property (nonatomic,copy) NSString *nowprice;
@property (nonatomic,copy) NSString *updateTime;




@property (nonatomic,copy) NSString *buyDesitionComment;

@end

NS_ASSUME_NONNULL_END
