//
//  UIImageView+BlurAnimation.m
//  TyBlureImage
//
//  Created by 田奕焰 on 15/12/7.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import "UIImageView+BlurAnimation.h"
#import "UIImageEffects.h"
#import <objc/runtime.h>

static NSInteger const kDefaultFramesCount = 5;

static const char kBaseImageKey = '\0';
static const char kBlurTintColorKey = '\0';
static const char kFramesCountKey = '\0';
static const char kFramesArrayKey = '\0';
static const char kFramesReverseArrayKey = '\0';
static const char kBlurRadiusKey = '\0';

@interface UIImageView()

@property (strong, nonatomic) UIImage *baseImage;

@property (strong) NSMutableArray *framesArray;

@property (strong) NSMutableArray *framesReverseArray;

@end

@implementation UIImageView (BlurAnimation)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(layoutSubviews)), class_getInstanceMethod(self, @selector(ty_layoutSubviews)));
}

- (void)ty_layoutSubviews
{
    [self ty_layoutSubviews];
    
    self.baseImage = self.image;
    [self ty_generateBlurFrames:nil];
    
    // Defaults
    self.animationDuration = 0.1f;
    self.animationRepeatCount = 1;
}

// Downsamples the image so we avoid needing to blur a huge image.
- (UIImage*)ty_downsampleImage
{
    NSData *imageAsData = UIImageJPEGRepresentation(self.baseImage, 0.001);
    UIImage *downsampledImaged = [UIImage imageWithData:imageAsData];
    return downsampledImaged;
}

#pragma mark - Animation Methods

- (void)ty_generateBlurFrames:(void(^)())completion
{
    if (!self.baseImage) {
        return;
    }
    self.framesArray = [[NSMutableArray alloc] init];
    self.framesReverseArray = [[NSMutableArray alloc] init];
    
    // Our default number of frames, if none is provided.
    // Keep this low to prevent huge performance issues.
    NSInteger frameCount = self.framesCount ? self.framesCount : kDefaultFramesCount;
    
    if (!self.blurTintColor) {
        self.blurTintColor = [UIColor clearColor];
    }
    
    UIImage *downsampledImage = [self ty_downsampleImage];
    
    for (NSUInteger i = 0; i < frameCount; i++) {
        
        CGFloat process = (CGFloat)i / frameCount;
        UIImage *blurredImage = [UIImageEffects imageByApplyingBlurToImage:downsampledImage
                                                                withRadius:process * self.blurRadius
                                                                 tintColor:self.blurTintColor
                                                     saturationDeltaFactor:1.8
                                                                 maskImage:nil];
        if (blurredImage == nil) {
            continue;
        }
        [self.framesArray addObject:blurredImage];
        [self.framesReverseArray insertObject:blurredImage atIndex:0];
    }
    completion();
}

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration
{
    self.animationDuration = duration;
    
    self.animationImages = self.framesArray;
    
    [self setImage:[self.framesArray lastObject]];
    
    [self startAnimating];
}

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration
{
    self.animationDuration = duration;
    
    self.animationImages = self.framesReverseArray;
    
    [self setImage:self.baseImage];
    
    [self startAnimating];
}

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion
{
    [self ty_blurInAnimationWithDuration:duration];
    if(completion){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(completion){
                completion();
            }
        });
    }
}

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion
{
    [self ty_blurOutAnimationWithDuration:duration];
    if(completion){
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(completion){
                completion();
            }
        });
    }
}

#pragma mark - Setter

- (void)setBaseImage:(UIImage *)baseImage
{
    objc_setAssociatedObject(self, &kBaseImageKey, baseImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBlurTintColor:(UIColor *)blurTintColor
{
    if ([self.blurTintColor isEqual:blurTintColor]) {
        return;
    }
    objc_setAssociatedObject(self, &kBlurTintColorKey, blurTintColor, OBJC_ASSOCIATION_RETAIN);
    [self ty_generateBlurFrames:nil];
}

- (void)setFramesCount:(NSInteger)framesCount
{
    NSNumber *number = [NSNumber numberWithInteger:framesCount];
    objc_setAssociatedObject(self, &kFramesCountKey, number, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setFramesArray:(NSMutableArray *)framesArray
{
    objc_setAssociatedObject(self, &kFramesArrayKey, framesArray, OBJC_ASSOCIATION_RETAIN);
}

- (void)setFramesReverseArray:(NSMutableArray *)framesReverseArray
{
    objc_setAssociatedObject(self, &kFramesReverseArrayKey, framesReverseArray, OBJC_ASSOCIATION_RETAIN);
}

- (void)setBlurRadius:(CGFloat)blurRadius
{
    if (self.blurRadius == blurRadius) {
        return;
    }
    NSNumber *number = [NSNumber numberWithFloat:blurRadius];
    objc_setAssociatedObject(self, &kBlurRadiusKey, number, OBJC_ASSOCIATION_ASSIGN);
    [self ty_generateBlurFrames:nil];
}

#pragma mark - Getter

- (UIImage *)baseImage
{
    return objc_getAssociatedObject(self, &kBaseImageKey);
}

- (UIColor *)blurTintColor
{
    return objc_getAssociatedObject(self, &kBlurTintColorKey);
}

- (NSInteger)framesCount
{
    NSNumber *number = objc_getAssociatedObject(self, &kFramesCountKey);
    return [number integerValue];
}

- (NSMutableArray *)framesArray
{
    return objc_getAssociatedObject(self, &kFramesArrayKey);
}

- (NSMutableArray *)framesReverseArray
{
    return objc_getAssociatedObject(self, &kFramesReverseArrayKey);
}

- (CGFloat)blurRadius
{
    NSNumber *number = objc_getAssociatedObject(self, &kBlurRadiusKey);
    return [number floatValue];
}

@end
