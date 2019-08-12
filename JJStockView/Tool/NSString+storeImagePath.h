//
//  NSString+storeImagePath.h
//  JJStockView
//
//  Created by smart-wift on 2019/8/6.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (storeImagePath)

+ (NSString *)saveImg:(UIImage *)tempImg;

+ (NSString *)saveImg:(UIImage *)tempImg Name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
