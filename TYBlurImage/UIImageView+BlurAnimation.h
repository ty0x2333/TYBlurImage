//
//  UIImageView+BlurAnimation.h
//  TyBlureImage
//
//  Created by 田奕焰 on 15/12/7.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BlurAnimation)

@property (strong) UIColor *blurTintColor;

/**
 *  @brief  Number of frames
 *
 *  default value is 5.
 *  @note   Increasing this can cause your app to have huge memory issues. Lower is better, especially when dealing with really fast animations.
 */
@property (assign) NSInteger framesCount;

@property (nonatomic, assign) CGFloat blurRadius;

/**
 *  @brief  need downsample image when play blur animation
 *
 *  default value is true
 *  @note   Downsamples the image so we avoid needing to blur a huge image.
 */
@property (nonatomic, assign) BOOL downsampleBlurAnimationImage;

/**
 *  @brief  Regenerates blur animation frames.
 *
 *  @param completion completion callback
 */
- (void)ty_generateBlurFrames:(void(^)())completion;

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration;

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration;

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion;

@end
