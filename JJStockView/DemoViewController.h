//
//  ViewController.h
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJStockView.h"


@interface DemoViewController : UIViewController

@property(nonatomic,readwrite,strong)JJStockView* stockView;

@property (nonatomic,strong) NSMutableArray *stocks;

@end

