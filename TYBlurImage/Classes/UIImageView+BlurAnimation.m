//
//  UIImageView+BlurAnimation.m
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

#import "UIImageView+BlurAnimation.h"
#import "UIImage+BlurEffects.h"
#import <objc/runtime.h>

static NSInteger const kDefaultFramesCount = 5;

static const char kBaseImageKey = '\0';
static const char kBlurTintColorKey = '\0';
static const char kFramesCountKey = '\0';
static const char kFramesArrayKey = '\0';
static const char kFramesReverseArrayKey = '\0';
static const char kBlurRadiusKey = '\0';
static const char kDownsampleBlurAnimationImageKey = '\0';

static const BOOL kDownsampleBlurAnimationImage = YES;

@interface UIImageView()

@property (strong, nonatomic) UIImage *baseImage;

@property (strong) NSMutableArray *framesArray;

@property (strong) NSMutableArray *framesReverseArray;

@end

@implementation UIImageView (BlurAnimation)

// Downsamples the image so we avoid needing to blur a huge image.
- (UIImage*)ty_downsampleImage
{
    NSData *imageAsData = UIImageJPEGRepresentation(self.baseImage, 0.001);
    UIImage *downsampledImaged = [UIImage imageWithData:imageAsData];
    return downsampledImaged;
}

#pragma mark - Animation Methods

- (void)ty_generateBlurFramesWithCompletion:(void(^)())completion
{
    if (self.baseImage == nil) {
        self.baseImage = self.image;
    }
    if (self.baseImage) {
        self.framesArray = [[NSMutableArray alloc] init];
        self.framesReverseArray = [[NSMutableArray alloc] init];
        
        // Our default number of frames, if none is provided.
        // Keep this low to prevent huge performance issues.
        NSInteger frameCount = self.framesCount ? self.framesCount : kDefaultFramesCount;
        
        if (!self.blurTintColor) {
            self.blurTintColor = [UIColor clearColor];
        }
        
        UIImage *downsampledImage = self.isDownsampleBlurAnimationImage ? [self ty_downsampleImage] : self.baseImage;
        
        for (NSUInteger i = 0; i < frameCount; i++) {
            
            CGFloat process = (CGFloat)i / frameCount;
            UIImage *blurredImage = [UIImage ty_imageByApplyingBlurToImage:downsampledImage
                                                                    withRadius:process * self.blurRadius
                                                                     tintColor:self.blurTintColor
                                                         saturationDeltaFactor:1
                                                                     maskImage:nil];
            if (blurredImage == nil) {
                continue;
            }
            [self.framesArray addObject:blurredImage];
            [self.framesReverseArray insertObject:blurredImage atIndex:0];
        }
    }
    if (completion) {
        completion();
    }
}

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration
{
    [self ty_blurInAnimationWithDuration:duration completion:nil];
}

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration
{
    [self ty_blurOutAnimationWithDuration:duration completion:nil];
}

- (void)ty_blurInAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion
{
    if (self.framesArray == nil) {
        [self ty_generateBlurFramesWithCompletion:^{
            [self ty_blurInAnimationWithDuration:duration completion:completion];
        }];
    } else {
        self.animationDuration = duration;
        self.animationImages = self.framesArray;
        [self setImage:[self.framesArray lastObject]];
        [self startAnimating];
        if(completion){
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if(completion){
                    completion();
                }
            });
        }
    }
}

- (void)ty_blurOutAnimationWithDuration:(CGFloat)duration completion:(void(^)())completion
{
    if (self.framesReverseArray == nil) {
        [self ty_generateBlurFramesWithCompletion:^{
            [self ty_blurOutAnimationWithDuration:duration completion:completion];
        }];
    } else {
        self.animationDuration = duration;
        self.animationImages = self.framesReverseArray;
        [self setImage:self.baseImage];
        [self startAnimating];
        if(completion){
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, self.animationDuration * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                if(completion){
                    completion();
                }
            });
        }
    }
}

#pragma mark - Setter

- (void)setBlurTintColor:(UIColor *)blurTintColor
{
    objc_setAssociatedObject(self, &kBlurTintColorKey, blurTintColor, OBJC_ASSOCIATION_RETAIN);
}

- (void)setFramesCount:(NSInteger)framesCount
{
    NSNumber *number = [NSNumber numberWithInteger:framesCount];
    objc_setAssociatedObject(self, &kFramesCountKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setBlurRadius:(CGFloat)blurRadius
{
    NSNumber *number = [NSNumber numberWithFloat:blurRadius];
    objc_setAssociatedObject(self, &kBlurRadiusKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setDownsampleBlurAnimationImage:(BOOL)downsampleBlurAnimationImage
{
    NSNumber *number = [NSNumber numberWithBool:downsampleBlurAnimationImage];
    objc_setAssociatedObject(self, &kDownsampleBlurAnimationImageKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Getter

- (UIColor *)blurTintColor
{
    return objc_getAssociatedObject(self, &kBlurTintColorKey);
}

- (NSInteger)framesCount
{
    NSNumber *number = objc_getAssociatedObject(self, &kFramesCountKey);
    return [number integerValue];
}

- (CGFloat)blurRadius
{
    NSNumber *number = objc_getAssociatedObject(self, &kBlurRadiusKey);
    return [number floatValue];
}

- (BOOL)isDownsampleBlurAnimationImage
{
    NSNumber *number = objc_getAssociatedObject(self, &kDownsampleBlurAnimationImageKey);
    if (number == nil) {
        self.downsampleBlurAnimationImage = kDownsampleBlurAnimationImage;
        return kDownsampleBlurAnimationImage;
    }
    return [number boolValue];
}

#pragma mark - Private

#pragma mark Setter

- (void)setBaseImage:(UIImage *)baseImage
{
    objc_setAssociatedObject(self, &kBaseImageKey, baseImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setFramesArray:(NSMutableArray *)framesArray
{
    objc_setAssociatedObject(self, &kFramesArrayKey, framesArray, OBJC_ASSOCIATION_RETAIN);
}

- (void)setFramesReverseArray:(NSMutableArray *)framesReverseArray
{
    objc_setAssociatedObject(self, &kFramesReverseArrayKey, framesReverseArray, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark Getter

- (UIImage *)baseImage
{
    return objc_getAssociatedObject(self, &kBaseImageKey);
}

- (NSMutableArray *)framesArray
{
    return objc_getAssociatedObject(self, &kFramesArrayKey);
}

- (NSMutableArray *)framesReverseArray
{
    return objc_getAssociatedObject(self, &kFramesReverseArrayKey);
}

@end
