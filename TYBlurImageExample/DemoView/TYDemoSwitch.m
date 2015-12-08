//
//  TYDemoSwitch.m
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
