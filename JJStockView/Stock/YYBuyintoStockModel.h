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

@property (nonatomic,copy) NSString *bond_id;//债券代码
@property (nonatomic,copy) NSString *bond_nm;//债券名称

// buyTime   buyDecisionComment   TargetPrice  buyPrice  buyCount sellTime     sellDecisionComment
@property (nonatomic,copy) NSDate *buyTime;
@property (nonatomic,copy) NSString *buyDecisionComment;
@property (nonatomic,copy) NSString *TargetPrice;//
@property (nonatomic,copy) NSString *buyPrice;//
@property (nonatomic,copy) NSString *buyCount;//
@property (nonatomic,copy) NSDate *preSellTime;//
@end
