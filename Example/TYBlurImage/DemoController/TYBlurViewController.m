//
//  TYBlurViewController.m
//  TyBlureImage
//
//  Copyright (c) 2015 luckytianyiyan (http://tianyiyan.com/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TYBlurViewController.h"
#import "UIImage+BlurEffects.h"
#import "UIImageView+BlurAnimation.h"
#import "TYDemoSwitch.h"
#import "TYDemoSlider.h"
#import <Masonry.h>

static CGFloat const kButtonHeight = 30.f;
static CGFloat const kSliderHeight = 40.f;
static CGFloat const kSwitchHeight = 30.f;

static CGFloat const kResetToSourceButtonCornerRadius = 5.f;

static CGFloat const kResetToSourceButtonTitleMarginVertical = 10.f;

#define kTiniColor [UIColor colorWithWhite:1.0 alpha:0.3]


@interface TYBlurViewController ()
{
    UIButton *_currentButton;
}

@property (nonatomic, strong) NSMutableArray *controlButtons;

@property (nonatomic, strong) TYDemoSlider *radiusSlider;
@property (nonatomic, strong) TYDemoSlider *saturationSlider;

@property (nonatomic, strong) TYDemoSwitch *tintColorSwitch;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIImage *sourceImage;

@property (nonatomic, strong) UILabel *radiusValueLabel;
@property (nonatomic, strong) UILabel *saturationValueLabel;

@property (nonatomic, strong) UILabel *defaultEffectsLabel;

@property (nonatomic, strong) UIButton *resetToSourceButton;

@end

@implementation TYBlurViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _contentScrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_contentScrollView];
    
    _sourceImage = [UIImage imageNamed:@"lena.jpg"];
    
    _radiusSlider = [[TYDemoSlider alloc] init];
    _radiusSlider.title = @"Radius";
    [_radiusSlider.slider addTarget:self action:@selector(onRadiusSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _radiusSlider.slider.maximumValue = 100;
    [_contentScrollView addSubview:_radiusSlider];
    
    _saturationSlider = [[TYDemoSlider alloc] init];
    _saturationSlider.title = @"Saturation";
    [_saturationSlider.slider addTarget:self action:@selector(onSaturationSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _saturationSlider.slider.value = 1;
    _saturationSlider.slider.maximumValue = 10;
    [_contentScrollView addSubview:_saturationSlider];
    
    _tintColorSwitch = [[TYDemoSwitch alloc] init];
    [_tintColorSwitch.contentSwitch addTarget:self action:@selector(onTintColorSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    _tintColorSwitch.title = @"Use Tint Color";
    [_contentScrollView addSubview:_tintColorSwitch];
    
    _radiusValueLabel = [[UILabel alloc] init];
    _radiusValueLabel.textAlignment = NSTextAlignmentCenter;
    _radiusValueLabel.text = [NSString stringWithFormat:@"Radius: %.0f", _radiusSlider.value];
    [_contentScrollView addSubview:_radiusValueLabel];
    
    _saturationValueLabel = [[UILabel alloc] init];
    _saturationValueLabel.textAlignment = NSTextAlignmentCenter;
    _saturationValueLabel.text = [NSString stringWithFormat:@"Saturation: %.0f", _saturationSlider.value];
    [_contentScrollView addSubview:_saturationValueLabel];
    
    _imageView = [[UIImageView alloc] initWithImage:_sourceImage];
    [_contentScrollView addSubview:_imageView];
    
    _defaultEffectsLabel = [[UILabel alloc] init];
    _defaultEffectsLabel.textAlignment = NSTextAlignmentCenter;
    _defaultEffectsLabel.text = @"Default Effects";
    [_contentScrollView addSubview:_defaultEffectsLabel];
    
    _resetToSourceButton = [[UIButton alloc] init];
    _resetToSourceButton.backgroundColor = [UIColor grayColor];
    _resetToSourceButton.layer.cornerRadius = kResetToSourceButtonCornerRadius;
    [_resetToSourceButton setTitle:@"Reset to source image" forState:UIControlStateNormal];
    [_resetToSourceButton addTarget:self action:@selector(onSourceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_contentScrollView addSubview:_resetToSourceButton];
    
    [self setupButtons];
    
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_radiusSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentScrollView);
        make.height.equalTo(@(kSliderHeight));
        make.width.equalTo(self.contentScrollView);
    }];
    
    [_saturationSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.radiusSlider.mas_bottom);
        make.width.height.equalTo(self.radiusSlider);
        make.left.equalTo(self.contentScrollView);
    }];
    
    [_tintColorSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.saturationSlider.mas_bottom);
        make.width.equalTo(self.contentScrollView);
        make.height.equalTo(@(kSwitchHeight));
    }];
    
    [_radiusValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tintColorSwitch.mas_bottom);
        make.left.equalTo(self.contentScrollView);
        make.width.equalTo(self.contentScrollView).multipliedBy(.5f);
    }];
    
    [_saturationValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tintColorSwitch.mas_bottom);
        make.left.equalTo(self.radiusValueLabel.mas_right);
        make.width.equalTo(self.radiusValueLabel);
    }];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentScrollView);
        make.top.equalTo(self.saturationValueLabel.mas_bottom);
    }];
    
    [_resetToSourceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(kResetToSourceButtonTitleMarginVertical);
        make.centerX.equalTo(self.contentScrollView);
        make.height.equalTo(@(kButtonHeight));
    }];
    
    [_defaultEffectsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetToSourceButton.mas_bottom).offset(kResetToSourceButtonTitleMarginVertical);
        make.width.equalTo(self.contentScrollView);
        make.left.equalTo(self.contentScrollView);
    }];
}

#pragma mark - Setup

- (void)setupButtons
{
    NSArray *buttonTitles = @[@"Dark Blur", @"Light Blur", @"Extra Light Blur", @"Tint Blur"];
    NSDictionary *attributesDictionary = @{@"Dark Blur": @"onDarkBlurButtonClicked:",
                                           @"Light Blur": @"onLightBlurButtonClicked:",
                                           @"Extra Light Blur": @"onExtraLightBlurButtonClicked:",
                                           @"Tint Blur": @"onTintBlurButtonClicked:"
                                           };
    _controlButtons = [NSMutableArray arrayWithCapacity:buttonTitles.count];
    
    [buttonTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(attributesDictionary[title]) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        [_contentScrollView addSubview:button];
        [_controlButtons addObject:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx % 2 == 0) {
                make.left.equalTo(self.contentScrollView);
            } else {
                make.left.equalTo(((UIView *)self.controlButtons[idx - 1]).mas_right);
            }
            
            if (idx / 2 == 0) {
                make.top.equalTo(self.defaultEffectsLabel.mas_bottom);
            } else {
                make.top.equalTo(((UIView *)self.controlButtons[idx - 2]).mas_bottom);
                make.bottom.equalTo(self.contentScrollView);
            }
            make.width.equalTo(self.contentScrollView).multipliedBy(.5f);
        }];
    }];
    
}

#pragma mark - Event Response

- (void)onTintColorSwitchValueChanged:(UISwitch *)sender
{
    UIColor *tintColor = _tintColorSwitch.isOn ? kTiniColor : [UIColor clearColor];
    _imageView.image = [UIImage ty_imageByApplyingBlurToImage:_sourceImage withRadius:_radiusSlider.value tintColor:tintColor saturationDeltaFactor:_saturationSlider.value maskImage:nil];
}

- (void)onRadiusSliderValueChanged:(UISlider *)sender
{
    _radiusValueLabel.text = [NSString stringWithFormat:@"Radius: %.1f", sender.value];
    UIColor *tintColor = _tintColorSwitch.isOn ? kTiniColor : nil;
    _imageView.image = [UIImage ty_imageByApplyingBlurToImage:_sourceImage withRadius:sender.value tintColor:tintColor saturationDeltaFactor:_saturationSlider.value maskImage:nil];
}

- (void)onSaturationSliderValueChanged:(UISlider *)sender
{
    _saturationValueLabel.text = [NSString stringWithFormat:@"Radius: %.1f", sender.value];
    UIColor *tintColor = _tintColorSwitch.isOn ? kTiniColor : nil;
    _imageView.image = [UIImage ty_imageByApplyingBlurToImage:_sourceImage withRadius:sender.value tintColor:tintColor saturationDeltaFactor:_saturationSlider.value maskImage:nil];
}

- (void)onSourceButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _saturationSlider.slider.value = 1;
    _radiusSlider.slider.value = 0;
    _tintColorSwitch.on = NO;
    _imageView.image = _sourceImage;
}
- (void)onLightBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImage ty_imageByApplyingLightEffectToImage:_sourceImage];
}
- (void)onExtraLightBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImage ty_imageByApplyingExtraLightEffectToImage:_sourceImage];
}
- (void)onDarkBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImage ty_imageByApplyingDarkEffectToImage:_sourceImage];
}
- (void)onTintBlurButtonClicked:(UIButton *)sender
{
    _currentButton = sender;
    _imageView.image = [UIImage ty_imageByApplyingTintEffectWithColor:[UIColor blueColor] toImage:_sourceImage];
}

@end
