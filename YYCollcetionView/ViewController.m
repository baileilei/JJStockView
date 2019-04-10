//
//  ViewController.m
//  YYCollcetionView
//
//  Created by g on 2019/4/10.
//  Copyright © 2019 Jezz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *StockCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
//    self.StockCollectionView
    self.StockCollectionView.contentSize = CGSizeMake(100 * 14, 45 * 31);
   
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}



@end
