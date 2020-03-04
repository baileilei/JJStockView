//
//  YYTicaiModel.h
//  JJStockView
//
//  Created by smart-wift on 2020/1/19.
//  Copyright © 2020 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYTicaiModel : NSObject

@property (nonatomic,copy) NSString *gjc;

@property (nonatomic,copy) NSString *jyscbm;

@property (nonatomic,copy) NSString *yd;

@property (nonatomic,copy) NSString *ydnr;

@property (nonatomic,copy) NSString *zqdm;

@property (nonatomic,copy) NSString *zqjc;

@property (nonatomic,copy) NSString *zqnm;

/*
 "gjc" : "所属板块",
 "jyscbm" : "--",
 "yd" : "1",
 "ydnr" : "OLED 创业板综 电子元件 独角兽 广东板块 华为概念 深圳特区 转债标的",
 "zqdm" : "300545.SZ",
 "zqjc" : "--",
 "zqnm" : "--"*/

@end

NS_ASSUME_NONNULL_END
