//
//  TYPlayAnimationViewController.m
//  TYBlurImageExample
//
//  Created by 田奕焰 on 15/12/8.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "TYPlayAnimationViewController.h"
#import "UIImageView+BlurAnimation.h"

static CGFloat const kButtonHeight = 50.f;

static CGFloat const kFirstSliderMarginTop = 10.f;
static CGFloat const kSliderHeight = 20.f;
static CGFloat const kSliderMarginRight = 20.f;

static CGFloat const kLabelMarginLeft = 20.f;

static CGFloat const kLabelHeight = 30.f;
static CGFloat const kSwitchHeight = 30.f;

#define kTintColor [UIColor colorWithWhite:1.0 alpha:0.3]


@interface TYPlayAnimationViewController ()

@property (nonatomic, strong) UILabel *radiusLabel;
@property (nonatomic, strong) UILabel *framesCountLabel;
@property (nonatomic, strong) UILabel *tintColorLabel;
@property (nonatomic, strong) UILabel *repeatForeverLabel;

@property (nonatomic, strong) UISwitch *tintColorSwitch;
@property (nonatomic, strong) UISwitch *repeatForeverSwitch;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, assign) BOOL isNeedRegenerateBlurFrames;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UISlider *radiusSlider;
@property (nonatomic, strong) UISlider *framesCountSlider;

@property (nonatomic, strong) UILabel *radiusValueLabel;
@property (nonatomic, strong) UILabel *framesCountValueLabel;

@property (nonatomic, strong) UIButton *recreateButton;

@property (nonatomic, strong) UIButton *playAnimationButton;

@end

@implementation TYPlayAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_contentScrollView];
    
    _recreateButton = [[UIButton alloc] init];
    [_recreateButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_recreateButton addTarget:self action:@selector(onRecreateImageViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_recreateButton setTitle:@"Recreate ImageView" forState:UIControlStateNormal];
    [_contentScrollView addSubview:_recreateButton];
    
    _playAnimationButton = [[UIButton alloc] init];
    [_playAnimationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_playAnimationButton addTarget:self action:@selector(onPlayAnimationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_playAnimationButton setTitle:@"Play AnimationButton" forState:UIControlStateNormal];
    [_contentScrollView addSubview:_playAnimationButton];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lena.jpg"]];
    _imageView.animationRepeatCount = 1;
    [_contentScrollView addSubview:_imageView];
    
    _radiusSlider = [[UISlider alloc] init];
    _radiusSlider.maximumValue = 100;
    [_radiusSlider addTarget:self action:@selector(onRadiusSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_contentScrollView addSubview:_radiusSlider];
    
    _framesCountSlider = [[UISlider alloc] init];
    _framesCountSlider.maximumValue = 100;
    [_framesCountSlider addTarget:self action:@selector(onFramesCountSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_contentScrollView addSubview:_framesCountSlider];
    
    _tintColorSwitch = [[UISwitch alloc] init];
    [_contentScrollView addSubview:_tintColorSwitch];
    
    _repeatForeverSwitch = [[UISwitch alloc] init];
    [_contentScrollView addSubview:_repeatForeverSwitch];
    
    [self setupLabels];
}

#pragma mark - Setup

- (void)setupLabels
{
    _radiusLabel = [[UILabel alloc] init];
    _radiusLabel.text = @"Radius";
    [_contentScrollView addSubview:_radiusLabel];
    
    _framesCountLabel = [[UILabel alloc] init];
    _framesCountLabel.text = @"Frames Count";
    [_contentScrollView addSubview:_framesCountLabel];
    
    _radiusValueLabel = [[UILabel alloc] init];
    _radiusValueLabel.text = [NSString stringWithFormat:@"Radius: %.1f", _radiusSlider.value];
    _radiusValueLabel.textAlignment = NSTextAlignmentCenter;
    [_contentScrollView addSubview:_radiusValueLabel];
    
    _framesCountValueLabel = [[UILabel alloc] init];
    _framesCountValueLabel.text = [NSString stringWithFormat:@"Frames Count: %d", (NSInteger)_framesCountSlider.value];
    _framesCountValueLabel.textAlignment = NSTextAlignmentCenter;
    [_contentScrollView addSubview:_framesCountValueLabel];
    
    _tintColorLabel = [[UILabel alloc] init];
    _tintColorLabel.textAlignment = NSTextAlignmentCenter;
    _tintColorLabel.text = @"Use Tint Color";
    [_contentScrollView addSubview:_tintColorLabel];
    
    _repeatForeverLabel = [[UILabel alloc] init];
    _repeatForeverLabel.textAlignment = NSTextAlignmentCenter;
    _repeatForeverLabel.text = @"Repeat Forever";
    [_contentScrollView addSubview:_repeatForeverLabel];

}

#pragma mark - Layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [_radiusLabel sizeToFit];
    
    CGFloat fullWidth = CGRectGetWidth(self.view.bounds);
    
    _radiusLabel.frame = CGRectMake(kLabelMarginLeft, kFirstSliderMarginTop, CGRectGetWidth(_radiusLabel.bounds), CGRectGetHeight(_radiusLabel.bounds));
    
    [_framesCountLabel sizeToFit];
    _framesCountLabel.frame = CGRectMake(kLabelMarginLeft, CGRectGetMaxY(_radiusLabel.frame), CGRectGetWidth(_framesCountLabel.bounds), CGRectGetHeight(_framesCountLabel.bounds));
    
    CGFloat radiusLabelMaxX = CGRectGetMaxX(_radiusLabel.frame);
    CGFloat framesCountMaxX = CGRectGetMaxX(_framesCountLabel.frame);
    
    _radiusSlider.frame = CGRectMake(radiusLabelMaxX, kFirstSliderMarginTop, fullWidth - radiusLabelMaxX - kSliderMarginRight, kSliderHeight);
    
    _framesCountSlider.frame = CGRectMake(framesCountMaxX, CGRectGetMaxY(_radiusSlider.frame) + kFirstSliderMarginTop, fullWidth - framesCountMaxX - kSliderMarginRight, kSliderHeight);
    
    _tintColorLabel.frame = CGRectMake(0,
                                       CGRectGetMaxY(_framesCountSlider.frame),
                                       fullWidth / 2,
                                       kLabelHeight
                                       );
    _tintColorSwitch.frame = CGRectMake(CGRectGetMaxX(_tintColorLabel.frame),
                                        CGRectGetMaxY(_framesCountSlider.frame),
                                        fullWidth / 2 - CGRectGetWidth(_tintColorLabel.bounds),
                                        kSwitchHeight
                                        );
    
    _repeatForeverLabel.frame = CGRectMake(0,
                                           CGRectGetMaxY(_tintColorLabel.frame),
                                           fullWidth / 2,
                                           kLabelHeight
                                           );
    _repeatForeverSwitch.frame = CGRectMake(CGRectGetMaxX(_repeatForeverLabel.frame),
                                            CGRectGetMaxY(_tintColorSwitch.frame),
                                            fullWidth / 2,
                                            kSwitchHeight
                                            );
    
    _imageView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - CGRectGetWidth(_imageView.bounds) / 2,
                                  CGRectGetMaxY(_repeatForeverSwitch.frame),
                                  CGRectGetWidth(_imageView.bounds),
                                  CGRectGetHeight(_imageView.bounds)
                                  );
    
    CGFloat labelValueWidth = fullWidth / 2;
    
    _radiusValueLabel.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), labelValueWidth, kLabelHeight);
    
    _framesCountValueLabel.frame = CGRectMake(CGRectGetMaxX(_radiusValueLabel.frame), CGRectGetMaxY(_imageView.frame), labelValueWidth, kLabelHeight);
    
    [_recreateButton.titleLabel sizeToFit];
    _recreateButton.bounds = _recreateButton.titleLabel.bounds;
    _recreateButton.frame = CGRectMake((fullWidth - CGRectGetWidth(_recreateButton.bounds)) / 2,
                                       CGRectGetMaxY(_radiusValueLabel.frame),
                                       CGRectGetWidth(_recreateButton.bounds),
                                       kButtonHeight
                                       );
    
    [_playAnimationButton.titleLabel sizeToFit];
    _playAnimationButton.bounds = _playAnimationButton.titleLabel.bounds;
    _playAnimationButton.frame = CGRectMake((fullWidth - CGRectGetWidth(_playAnimationButton.bounds)) / 2,
                                            CGRectGetMaxY(_recreateButton.frame),
                                            CGRectGetWidth(_playAnimationButton.bounds),
                                            kButtonHeight
                                            );
    
    _contentScrollView.frame = CGRectMake(0, 0, fullWidth, CGRectGetHeight(self.view.bounds));
    _contentScrollView.contentSize = CGSizeMake(fullWidth, CGRectGetMaxY(_playAnimationButton.frame));
}

#pragma mark - Event Response

- (void)onRepeatForeverSwitchValueChanged:(UISwitch *)sender
{
    /**
     *  set animationRepeatCount need not generate frames
     */
    _imageView.animationRepeatCount = sender.isOn ? 0 : 1;
}

- (void)onTintColorSwitchValueChanged:(UISwitch *)sender
{
    _imageView.blurTintColor = sender.isOn ? kTintColor : nil;
    _isNeedRegenerateBlurFrames = YES;
}

- (void)onFramesCountSliderValueChanged:(UISlider *)sender
{
    _framesCountValueLabel.text = [NSString stringWithFormat:@"Frames Count: %d", (NSInteger)sender.value];
    _imageView.framesCount = (NSInteger)sender.value;
    _isNeedRegenerateBlurFrames = YES;
}

- (void)onRadiusSliderValueChanged:(UISlider *)sender
{
    _radiusValueLabel.text = [NSString stringWithFormat:@"Radius: %.1f", sender.value];
    _imageView.blurRadius = sender.value;
    _isNeedRegenerateBlurFrames = YES;
}

- (void)onRecreateImageViewButtonClicked:(UIButton *)sender
{
    [_imageView removeFromSuperview];
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lena.jpg"]];
    _imageView.animationRepeatCount = _repeatForeverSwitch.isOn ? 0 : 1;
    _imageView.blurRadius = _radiusSlider.value;
    _imageView.framesCount = (NSInteger)_framesCountSlider.value;
    _imageView.blurTintColor = _tintColorSwitch.isOn ? kTintColor : nil;
    [_imageView ty_blurInAnimationWithDuration:0.25f completion:^{
        NSLog(@"Animation End");
    }];
    [_contentScrollView addSubview:_imageView];
    _isNeedRegenerateBlurFrames = NO;
    [self layoutSubviews];
}

- (void)onPlayAnimationButtonClicked:(UIButton *)sender
{
    if (_isNeedRegenerateBlurFrames) {
        NSLog(@"radius or framesCount has changed. regenerate frames.");
        [_imageView ty_generateBlurFramesWithCompletion:^{
            NSLog(@"regenerate frames end.");
            _isNeedRegenerateBlurFrames = NO;
            [_imageView ty_blurInAnimationWithDuration:0.25f completion:^{
                NSLog(@"Animation End");
            }];
        }];
    } else {
        [_imageView ty_blurInAnimationWithDuration:0.25f completion:^{
            NSLog(@"Animation End");
        }];
    }
    
}

@end
