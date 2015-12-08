//
//  TYDemoSlider.m
//  TYBlurImageExample
//
//  Created by 田奕焰 on 15/12/9.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "TYDemoSlider.h"

static CGFloat const kContentMarginHorizontal = 20.f;

@interface TYDemoSlider()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TYDemoSlider

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _slider = [[UISlider alloc] init];
        [self addSubview:_slider];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat fullWidth = CGRectGetWidth(self.bounds);
    CGFloat fullHeight = CGRectGetHeight(self.bounds);
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(kContentMarginHorizontal, 0,
                                   CGRectGetWidth(_titleLabel.bounds), fullHeight
                                   );
    [_slider sizeToFit];
    _slider.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame),
                               0,
                               fullWidth - CGRectGetMaxX(_titleLabel.frame) -  kContentMarginHorizontal,
                               fullHeight
                               );
}

#pragma mark - Setter / Getter

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = [NSString stringWithString:title];
}

- (NSString *)title
{
    return _titleLabel.text;
}

- (void)setValue:(float)value
{
    _slider.value = value;
}

- (float)value
{
    return _slider.value;
}


@end
