//
//  TYDemoSlider.m
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

#import "TYDemoSlider.h"
#import <Masonry.h>

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
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kContentMarginHorizontal);
            make.top.bottom.equalTo(self);
        }];
        
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(kContentMarginHorizontal);
            make.right.equalTo(self).offset(-kContentMarginHorizontal);
            make.top.bottom.equalTo(self);
        }];
    }
    return self;
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

- (void)setValue:(CGFloat)value
{
    _slider.value = value;
}

- (CGFloat)value
{
    return _slider.value;
}


@end
