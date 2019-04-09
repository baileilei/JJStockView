//
//  YYSelfDefineCategoryStock.h
//  JJStockView
//
//  Created by g on 2019/4/9.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYStockModel;
@interface YYSelfDefineCategoryStock : NSObject
/**
 *  分类名称
 */
@property (copy, nonatomic) NSString *name;//强赎组     新组

/**
 *  分类里面所有的菜品
 */
@property (strong, nonatomic) NSArray<YYStockModel *> *spus;
@end
