//
//  FirstViewController.m
//  BaseProduct
//
//  Created by zfxf on 2018/7/10.
//  Copyright © 2018年 袁海. All rights reserved.
//

#import "FirstViewController.h"
#import "NewPagedFlowView.h"

@interface FirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property (nonatomic, strong) UICollectionView *firstCollectionView;
@property (nonatomic, strong) NewPagedFlowView *bannerView;//轮播图
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigation];
}

#pragma mark - 设置导航
- (void)setUpNavigation {
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"股票/投顾/直播" forState:UIControlStateNormal];
    [searchButton setImage:nil forState:UIControlStateNormal];
    [searchButton setTitleColor:baseColor(0xff6905, 1) forState:UIControlStateNormal];
    searchButton.backgroundColor = [UIColor whiteColor];
    searchButton.frame = CGRectMake(0, 0, UISCREEN_WIDTH -110, 26);//120
    searchButton.titleLabel.font= [UIFont systemFontOfSize:14];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [searchButton addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    searchButton.layer.cornerRadius = 13;searchButton.clipsToBounds = YES;
    searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    self.navigationItem.titleView = searchButton;
    
    UIImageView *rightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    rightImgView.image = nil;
    UIView * _mssageView = [[UIView alloc] initWithFrame:CGRectMake(19, 0, 8, 8)];
    _mssageView.backgroundColor = [UIColor whiteColor];
    _mssageView.backgroundColor = [UIColor redColor];
    _mssageView.layer.cornerRadius = 4;
    _mssageView.layer.masksToBounds = YES;
    _mssageView.alpha = 0;
    [rightImgView addSubview:_mssageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushmessageView)];
    [rightImgView addGestureRecognizer:tap];
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithCustomView:rightImgView];
    UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    leftImgView.image = nil;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoSubscription)];
    [leftImgView addGestureRecognizer:tap2];
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithCustomView:leftImgView];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftBtn;
}

#pragma mark - banner delegate dataSource
- (void)didSelectFlowView:(NewPagedFlowView*)flowView WithCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex{
    
}
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeZero;
}

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return 0;
}
- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *banner = [flowView dequeueReusableCell];
    if (banner == nil) {
        banner = [[PGIndexBannerSubiew alloc] init];
        banner.tag = index;
    }
    return banner;
}

#pragma mark - collection delegate dataSource
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - collection 点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - lazy load
- (UICollectionView *)firstCollectionView{
    if (!_firstCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        _firstCollectionView = [[UICollectionView alloc] init];
        _firstCollectionView.delegate = self;
        _firstCollectionView.dataSource = self;
        _firstCollectionView.backgroundColor = [UIColor whiteColor];
        _firstCollectionView.alwaysBounceVertical = YES;
        if (@available(iOS 11.0, *)) {
            _firstCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _firstCollectionView;
}

- (NewPagedFlowView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[NewPagedFlowView alloc] initWithFrame:CGRectZero];
        _bannerView.delegate = self;
        _bannerView.dataSource = self;
        _bannerView.minimumPageAlpha = 0.5;
        _bannerView.isOpenAutoScroll = YES;
        _bannerView.leftRightMargin = 0;
        _bannerView.topBottomMargin = 0;
        _bannerView.backgroundColor = [UIColor whiteColor];
        _bannerView.orientation = NewPagedFlowViewOrientationHorizontal;
    }
    return _bannerView;
}
@end
