//
//  UIImageView+BlurAnimation.h
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

#import <UIKit/UIKit.h>

@interface UIImageView (BlurAnimation)

@property (strong) UIColor *blurTintColor;

/**
 *  @brief  number of frames
 *
 *  default value is 5.
 *  @warning   Increasing this can cause your app to have huge memory issues. Lower is better, especially when dealing with really fast animations.
 */
@property (assign) NSInteger framesCount;

/**
 *  @brief  the blur amount
 */
@property (nonatomic) CGFloat blurRadius;

/**
 *  @brief  need downsample image when play blur animation
 *
 *  default value is true
 *  @warning   Downsamples the image so we avoid needing to blur a huge image.
 */
@property (nonatomic, getter = isDownsampleBlurAnimationImage) BOOL downsampleBlurAnimationImage;

/**
 *  @brief  regenerates blur animation frames.
 *
 *  @param  completion completion callback
 */
- (void)ty_generateBlurFramesWithCompletion:(void(^)())completion;

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration;

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration;

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;

@end
