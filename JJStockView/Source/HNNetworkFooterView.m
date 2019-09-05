//
//  HNNetworkFooterView.m
//  HomeNetwork
//
//  Created by chinasoftinc on 2018/9/22.
//  Copyright © 2018年 HUAWEI. All rights reserved.
//

#import "HNNetworkFooterView.h"
#import "HNRecommendToolCell.h"
#import "HMTMasonry/HMTMasonry.h"
//#import "HNToolModel.h"
//#import "HNAppService.h"

//  屏幕宽度
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define WIDTH_PROPORTION (SCREEN_WIDTH / 540.0)

@interface HNNetworkFooterView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSMutableArray *icons;

@property(nonatomic, strong) NSMutableArray *titles;

@property(nonatomic, weak) UICollectionView *collectionView;

@end

@implementation HNNetworkFooterView

static NSString *const FooterViewCellID = @"FooterViewCellID";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置背景颜色
        self.backgroundColor = [UIColor whiteColor];
        //初始化数据
//        [self initlizedDataWithNetworkFooterView];
        //创建子控件
        [self creatChildViewToNetworkFooterView];
    }
    return self;
}



#pragma mark - 创建子控件
- (void)creatChildViewToNetworkFooterView {
    //1.创建标题lable
    UILabel *titleLable = [[UILabel alloc] init];
    [self addSubview:titleLable];
    [titleLable mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(32 * WIDTH_PROPORTION);
        make.leading.equalTo(self.mas_leading).offset(36 * WIDTH_PROPORTION);
        make.width.equalTo(self);
    }];
    titleLable.font = [UIFont systemFontOfSize:24 * WIDTH_PROPORTION];
//    titleLable.textColor = [UIColor CustomColorByStr:@"#212121"];
    titleLable.numberOfLines = 0;
    titleLable.text = @"快捷功能";
    self.titleLable = titleLable;
    
    //2.创建collectionView
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    [self addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(HMTMASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom);
        make.leading.trailing.equalTo(self);
        make.bottom.equalTo(self);
    }];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    [collectionView registerClass:[HNRecommendToolCell class] forCellWithReuseIdentifier:FooterViewCellID];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNRecommendToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FooterViewCellID forIndexPath:indexPath];
    
    cell.nameLabel.text = @"智能组网";
    cell.iconImage.image = [UIImage imageNamed:@"home_zhinengwangzu"];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH / 4 - 1, 170 * WIDTH_PROPORTION);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    HNToolModel *model = self.tools[indexPath.row];
    if (_toolButtonClick) {
        self.toolButtonClick(nil);
    }
}




@end
