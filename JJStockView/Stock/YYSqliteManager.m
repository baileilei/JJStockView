//
//  YYSqliteManager.m
//  JJStockView
//
//  Created by pactera on 2018/1/29.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "YYSqliteManager.h"
//#import <FMDB.h>

@interface YYSqliteManager()

//@property (nonatomic,strong) FMDatabaseQueue *queue;


@end

@implementation YYSqliteManager

+(instancetype)shareManager{
    static YYSqliteManager *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[YYSqliteManager alloc] init];
        }
    });
    return _instance;
}

-(instancetype)init{
    
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"db.sql" ofType:nil];
        NSString *sql = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
//
//            BOOL isSuccess = [db executeStatements:sql];
//            if (isSuccess) {
//                NSLog(@"创表成功");
//            }else{
//                NSLog(@"创表失败");
//            }
//        }];
    }
    return self;
}

-(void)insertModels:(NSArray *)models{
    for (YYStockModel *model in models) {
        [self insertModel:model];
    }
}

-(void)insertModel:(YYStockModel *)model{
    NSString *sql = @"insert into T_stock(stock_id,stock_name,ytm_rt,ytm_rt_tax,stock_net_value,bond_name,bond_id,convert_price,convert_value,ration_cd,issue_dt,maturity_dt,year_left,put_price,redeem_price,full_price,repo_valid,convert_amt_ratio,sprice) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
//    NSLog(@"sql----%@",sql);
//    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
//        [db executeUpdate:sql values:@[model.stock_id?:@"",model.stock_nm?:@"",model.ytm_rt?:@"",model.ytm_rt_tax?:@"",model.stock_net_value?:@"",model.bond_nm?:@"",model.bond_id?:@"",model.convert_price?:@"",model.convert_value?:@"",model.ration_cd?:@"",model.issue_dt?:@"",model.maturity_dt?:@"",model.year_left?:@"",model.put_price?:@"",model.redeem_price?:@"",model.full_price?:@"",model.repo_valid?:@"",model.convert_amt_ratio?:@"",model.sprice?:@""] error:nil];
//    }];
    
}


#pragma  mark -getter
//-(FMDatabaseQueue *)queue{
//
//    if (!_queue) {
//        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//        path = [path stringByAppendingPathComponent:@"stock.db"];
//        NSLog(@"path---%@",path);
//        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
//    }
//    return _queue;
//}

@end
