//
//  TYDemoSwitch.m
//  TYBlurImageExample
//
//  Created by 田奕焰 on 15/12/9.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "TYDemoSwitch.h"

@interface TYDemoSwitch()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TYDemoSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _contentSwitch = [[UISwitch alloc] init];
        [self addSubview:_contentSwitch];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat fullWidth = CGRectGetWidth(self.bounds);
    CGFloat fullHeight = CGRectGetHeight(self.bounds);
    _titleLabel.frame = CGRectMake(0, 0, fullWidth / 2, fullHeight);
    _contentSwitch.frame = CGRectMake(fullWidth / 2, 0, fullWidth / 2, fullHeight);
}

#pragma mark - Setter / Getter

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = [NSString stringWithString:title];
}

- (void)setOn:(BOOL)on
{
    _contentSwitch.on = on;
}

- (NSString *)title
{
    return _titleLabel.text;
}

- (BOOL)isOn
{
    return _contentSwitch.isOn;
}

@end
