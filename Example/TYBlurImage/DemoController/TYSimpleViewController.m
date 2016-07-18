//
//  TYSimpleViewController.m
//  TYBlurImage
//
//  Created by luckytianyiyan on 16/7/17.
//  Copyright © 2016年 luckytianyiyan. All rights reserved.
//

#import "TYSimpleViewController.h"
#import <Masonry.h>
#import <UIImageView+BlurAnimation.h>
#import "TYMenuTableViewController.h"

static CGFloat const kAnimationDuration = .5f;

@interface TYSimpleViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) MASConstraint *moreButtonBottomStartConstraint;
@property (nonatomic, strong) MASConstraint *reloadButtonCenterShowConstraint;
@property (nonatomic, strong) MASConstraint *reloadButtonTopHideConstraint;

@end

@implementation TYSimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:@"dota2.jpg"];
    [self.view addSubview:_imageView];
    
    _imageView.blurTintColor = [UIColor colorWithWhite:0.4f alpha:0.3f];
    _imageView.blurRadius = 20;
    _imageView.framesCount = 20;
    _imageView.animationRepeatCount = 1;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _reloadButton = [[UIButton alloc] init];
    [_reloadButton setTitle:@"Reload" forState:UIControlStateNormal];
    [self.view addSubview:_reloadButton];
    
    [_reloadButton addTarget:self action:@selector(onReloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _moreButton = [[UIButton alloc] init];
    [_moreButton setTitle:@"More" forState:UIControlStateNormal];
    [self.view addSubview:_moreButton];
    
    [_moreButton addTarget:self action:@selector(onMoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    }];
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reloadButton.mas_bottom).offset(25);
        self.moreButtonBottomStartConstraint = make.bottom.equalTo(self.view.mas_top).priorityHigh();
        make.centerX.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self runAnimation];
}

- (void)onReloadButtonClicked:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [_imageView ty_blurOutAnimationWithDuration:kAnimationDuration];
    [weakSelf.reloadButton mas_updateConstraints:^(MASConstraintMaker *make) {
        [weakSelf.reloadButtonCenterShowConstraint uninstall];
        [weakSelf.moreButtonBottomStartConstraint install];
    }];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        sleep(1.f);
        [weakSelf runAnimation];
    }];
}

- (void)onMoreButtonClicked:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [_imageView ty_blurOutAnimationWithDuration:kAnimationDuration];
    [weakSelf.reloadButton mas_updateConstraints:^(MASConstraintMaker *make) {
        [weakSelf.reloadButtonCenterShowConstraint uninstall];
        weakSelf.reloadButtonTopHideConstraint = make.top.equalTo(self.view.mas_bottom);
    }];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        TYMenuTableViewController *viewController = [[TYMenuTableViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [UIApplication sharedApplication].keyWindow.rootViewController = navController;
    }];
}

- (void)runAnimation
{
    __weak typeof(self) weakSelf = self;
    [_imageView ty_blurInAnimationWithDuration:kAnimationDuration completion:^{
        [weakSelf.reloadButton mas_updateConstraints:^(MASConstraintMaker *make) {
            [weakSelf.moreButtonBottomStartConstraint uninstall];
            weakSelf.reloadButtonCenterShowConstraint = make.bottom.equalTo(self.view.mas_centerY);
        }];
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [weakSelf.view layoutIfNeeded];
        }];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
