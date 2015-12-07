//
//  TYViewController.m
//  TyBlureImage
//
//  Created by 田奕焰 on 15/12/7.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "TYViewController.h"
#import "UIImageEffects.h"
#import "UIImageView+BlurAnimation.h"

static CGFloat const kButtonHeight = 30;
static CGFloat const kSliderHeight = 20;
static CGFloat const kSliderMarginHorizontal = 50;

@interface TYViewController ()
{
    UIButton *_currentButton;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *sourceImage;

@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation TYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sourceImage = [UIImage imageNamed:@"lena.jpg"];
    
    _imageView = [[UIImageView alloc] initWithImage:_sourceImage];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(kSliderMarginHorizontal, CGRectGetHeight(self.view.bounds) - 3 * kButtonHeight - kSliderHeight, CGRectGetWidth(self.view.bounds) - 2 * kSliderMarginHorizontal, kSliderHeight)];
    [slider addTarget:self action:@selector(onSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.maximumValue = 100;
    [self.view addSubview:slider];
    
    _valueLabel = [[UILabel alloc] init];
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    [_valueLabel sizeToFit];
    _valueLabel.frame = CGRectMake(self.view.center.x - CGRectGetWidth(_valueLabel.bounds) / 2, CGRectGetMinY(slider.frame) - CGRectGetHeight(_valueLabel.bounds), CGRectGetWidth(_valueLabel.bounds), CGRectGetHeight(_valueLabel.bounds));
    [self.view addSubview:_valueLabel];
    
    [self setupButtons];
}

#pragma mark - Setup

- (void)setupButtons
{
    NSArray *buttonTitles = @[@"Source", @"Play Animation", @"Dark Bulr", @"Light Bulr", @"Extra Light Bulr", @"Tint Blur"];
    NSDictionary *attributesDictionary = @{@"Source": @"onSourceButtonClicked:",
                                           @"Play Animation": @"onPlayAnimationButtonClicked:",
                                           @"Dark Bulr": @"onDarkBlurButtonClicked:",
                                           @"Light Bulr": @"onLightBlurButtonClicked:",
                                           @"Extra Light Bulr": @"onExtraLightBlurButtonClicked:",
                                           @"Tint Blur": @"onTintBlurButtonClicked:"
                                           };

    CGFloat buttonWidth = CGRectGetWidth(self.view.bounds) / 2;
    CGRect firstButtonFrame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 3 * kButtonHeight,
                                         CGRectGetWidth(self.view.bounds) / 2, kButtonHeight);
    
    [buttonTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectOffset(firstButtonFrame, (idx % 2) * buttonWidth, (idx / 2) * kButtonHeight)];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(attributesDictionary[title]) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        [self.view addSubview:button];
    }];
}

#pragma mark - Event Response

- (void)onPlayAnimationButtonClicked:(UIButton *)sender
{
    _imageView.blurRadius = 20;
    _imageView.framesCount = 20;
    _imageView.blurTintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    [_imageView ty_blurInAnimationWithDuration:0.25f completion:^{
        NSLog(@"Animation End");
    }];
}

- (void)onSliderValueChanged:(UISlider *)sender
{
    _valueLabel.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [_valueLabel sizeToFit];
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    _imageView.image = [UIImageEffects imageByApplyingBlurToImage:_sourceImage withRadius:sender.value tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (void)onSourceButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = _sourceImage;
}
- (void)onLightBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImageEffects imageByApplyingLightEffectToImage:_sourceImage];
}
- (void)onExtraLightBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImageEffects imageByApplyingExtraLightEffectToImage:_sourceImage];
}
- (void)onDarkBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImageEffects imageByApplyingDarkEffectToImage:_sourceImage];
}
- (void)onTintBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImageEffects imageByApplyingTintEffectWithColor:[UIColor blueColor] toImage:_sourceImage];
}

@end
