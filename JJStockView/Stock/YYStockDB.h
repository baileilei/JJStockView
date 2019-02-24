//
//  YYStockDB.h
//  JJStockView
//
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYStockModel.h"

@interface YYStockDB : NSObject

- (void)createStockTable;
- (BOOL)saveStockModel:(YYStockModel *)info;
- (void)saveStockModels:(NSArray *)array;
- (NSArray<YYStockModel *> *)queryAllStockModel;
- (BOOL)updateStockModel:(YYStockModel *)info;
- (BOOL)deleteStockModelWithUserID:(NSString *)userID;
- (BOOL)deleteStockModelWithCommID:(NSString *)commID;
- (BOOL)deleteAllStockModel;




@end
