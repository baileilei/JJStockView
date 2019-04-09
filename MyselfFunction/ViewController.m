//
//  ViewController.m
//  MyselfFunction
//
//  Created by g on 2019/4/9.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "ViewController.h"
#import "YYSelfDefineCategoryStock.h"
#import "Masonry.h"
#import "MTCategoryCell.h"
#import "MTStockHeaderView.h"
#import "YYStockViewCell.h"

// cell的重用标识符
static NSString *cellId = @"cellId";
// header的重用标识符
static NSString *headerId = @"headerId";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/**
 *  分类列表
 */
@property (weak, nonatomic) UITableView *tvCategory;  // 两个tableview  左右联动       抽屉为上下的方式      也有QQ好友为组的方式

/**
 *  菜品列表
 */
@property (weak, nonatomic) UITableView *tvStock;

@end

@implementation ViewController{
     NSArray<YYSelfDefineCategoryStock *> *_categoryList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setupUI];
}

#pragma mark - 代理方法
// 选中的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 选中了分类里面的cell!
    if (tableView == _tvCategory) {
        
        // 需要让 菜品 列表进行滚动!
        // 选中分类的行 => 菜品列表对应的组!
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        // 让列表视图滚动!
        [_tvStock scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        return;
    }
    
    // 选中了菜品里面的cell
    NSLog(@"food === cell");
    
}

// 将要显示cell的代理方法 -> 将要显示某一行cell时,调用的方法!
// Display 显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.如果是分类,直接返回
    if (tableView == _tvCategory) {
        return;
    }
    
    // 如果不是用户滚动的菜品,不做操作!
    if (!(_tvStock.isDragging || _tvStock.isDecelerating || _tvStock.isTracking)) {
        return;
    }
    
    // 2.菜品列表在滚动的时候,会显示下面的cell!
    NSLog(@"显示cell");
    
    // 计算需要选中的索引信息
    NSInteger row = indexPath.section;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    
    
    // 让分类列表选中行
    [_tvCategory selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionTop];
    
}


#pragma mark - 数据源方法
// 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // 判断列表是谁?
    // 分类列表
    if (tableView == _tvCategory) {
        
        return 1;
    }
    
    // 菜品列表 -> 有几个分类,就有几组菜品!
    return _categoryList.count;
}

// 行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 分类列表
    if (tableView == _tvCategory) {
        
        return _categoryList.count;
    }
    
    // 菜品列表 -> 得知道是哪组?
    // 获取组内所有数据
    NSArray *foodsArr = _categoryList[section].spus;
    
    return foodsArr.count;
    
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // 1.1 分类的cell
    if (tableView == _tvCategory) {
        
        // 1.1.1 设置分类的数据
        ((MTCategoryCell *)cell).categoryModel = _categoryList[indexPath.row];
        
        // 1.1.2 返回cell!
        return cell;
    }
    // 1.2 菜品的cell
    YYStockModel * model = _categoryList[indexPath.section].spus[indexPath.row];
//    YYStockViewCell *stockCell = (YYStockViewCell *)cell;
//    stockCell.smodel = model;
//    stockCell.
//    stockCell.smodel = model;
    cell.textLabel.text = @"test";
    
    // 3.返回cell!
    return cell;
    
}


- (void)loadData {
    
    // 1.url    数据结构的组织形式决定了联动方式
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil];
    // 2.data
    NSData *totalData = [NSData dataWithContentsOfURL:url];
    // 3.反序列化
    NSDictionary *totalDict = [NSJSONSerialization JSONObjectWithData:totalData options:0 error:nil];
    // 4.取出想要的数据
    NSArray<NSDictionary *> *categoryDictArr = totalDict[@"data"][@"food_spu_tags"];
    
    // 5.遍历转模型
    NSMutableArray *biggerM = [NSMutableArray array];
    
    [categoryDictArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // obj 代表的是分类的字典!
        YYSelfDefineCategoryStock *categoryModel = [[YYSelfDefineCategoryStock alloc] init];
        [categoryModel setValuesForKeysWithDictionary:obj];

        [biggerM addObject:categoryModel];
        
        
    }];
    
    // 6.赋值
    _categoryList = biggerM.copy;
    
    
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // MARK: - 1.左侧的分类列表视图
    UITableView *tvCategory = [[UITableView alloc] init];
    tvCategory.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tvCategory];
    
    [tvCategory mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.equalTo(self.view);
        make.width.mas_equalTo(86);
        make.bottom.equalTo(self.view).offset(-46);
        
    }];
    
    
    // MARK: - 2.右侧的菜品列表视图
    UITableView *tvStock = [[UITableView alloc] init];
    
    [self.view addSubview:tvStock];
    
    [tvStock mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.equalTo(tvCategory);
        make.right.equalTo(self.view);
        make.left.equalTo(tvCategory.mas_right);
        
    }];
    
    // MARK: -----设置列表的属性-------
    // 1.设置数据源和代理对象
    tvCategory.dataSource = self;
    tvCategory.delegate = self;
    
    tvStock.dataSource = self;
    tvStock.delegate = self;
    
    // 2.注册cell
    [tvCategory registerClass:[MTCategoryCell class] forCellReuseIdentifier:cellId];
//    [tvStock registerClass:[YYStockViewCell class] forCellReuseIdentifier:cellId];
    
    // 注册header! -> 负责注册tableView的组标题视图的!
    // 类型-> 继承自UITaleViewHeaderFooterView!
//    [tvStock registerClass:[MTFoodHeaderView class] forHeaderFooterViewReuseIdentifier:headerId];
#warning - 一定要设置这个属性,才会调用对应的代理方法
    tvStock.sectionHeaderHeight = 23;
    
    // 3.不显示多余的行
    tvCategory.tableFooterView = [[UIView alloc] init];
    tvStock.tableFooterView = [[UIView alloc] init];
    
    // 4.隐藏指示条子
    tvCategory.showsVerticalScrollIndicator = NO;
    tvStock.showsVerticalScrollIndicator = NO;
    
    // 5.设置行高
    tvCategory.rowHeight = 55;
    
    // MARK: ----设置预估行高!
    tvStock.estimatedRowHeight = 120;
    tvStock.rowHeight = UITableViewAutomaticDimension;
    
    
    // 6.取消分割线
    tvCategory.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    // MARK: - 3.底部的购物占位视图
    UIView *carV = [[UIView alloc] init];
    carV.backgroundColor = [UIColor magentaColor];
    
    [self.view addSubview:carV];
    
    [carV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(tvCategory.mas_bottom);
        make.left.equalTo(tvCategory);
        make.right.equalTo(tvStock);
        make.bottom.equalTo(self.view);
        
    }];
    
    // MARK: - 4.记录成员变量
    _tvStock = tvStock;
    _tvCategory = tvCategory;
    
}

@end
