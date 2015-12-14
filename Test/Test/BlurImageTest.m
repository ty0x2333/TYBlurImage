//
//  BlurImageTest.m
//  Test
//
//  Created by 田奕焰 on 15/12/15.
//
//

#import <XCTest/XCTest.h>
#import "UIImage+BlurEffects.h"
@interface BlurImageTest : XCTestCase

@end

@implementation BlurImageTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLightEffect
{
    UIImage *image = [self imageForTesting];
    UIImage *blurImage = [UIImage ty_imageByApplyingLightEffectToImage:image];
    XCTAssertNotNil(blurImage);
}

- (void)testExtraLightEffect
{
    UIImage *image = [self imageForTesting];
    UIImage *blurImage = [UIImage ty_imageByApplyingExtraLightEffectToImage:image];
    XCTAssertNotNil(blurImage);
}

- (void)testDarkEffect
{
    UIImage *image = [self imageForTesting];
    UIImage *blurImage = [UIImage ty_imageByApplyingDarkEffectToImage:image];
    XCTAssertNotNil(blurImage);
}

- (void)testTintEffect
{
    UIImage *image = [self imageForTesting];
    UIColor *tintColor = [UIColor whiteColor];
    UIImage *blurImage = [UIImage ty_imageByApplyingTintEffectWithColor:tintColor toImage:image];
    XCTAssertNotNil(blurImage);
}

- (void)testBaseBlurEffect
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [image copy];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNotNil(blurImage);
}

#pragma mark - Test Parameter is nil

#pragma mark Light Effect
- (void)testLightEffectWhenInputNil
{
    UIImage *blurImage = [UIImage ty_imageByApplyingLightEffectToImage:nil];
    XCTAssertNil(blurImage);
}

#pragma mark ExtraLight Effect
- (void)testExtraLightEffectWhenInputNil
{
    UIImage *blurImage = [UIImage ty_imageByApplyingExtraLightEffectToImage:nil];
    XCTAssertNil(blurImage);
}

#pragma mark Dark Effect
- (void)testDarkEffectWhenInputNil
{
    UIImage *blurImage = [UIImage ty_imageByApplyingDarkEffectToImage:nil];
    XCTAssertNil(blurImage);
}

#pragma mark Tint Effect
- (void)testTintEffectWhenImageNil
{
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingTintEffectWithColor:tintColor toImage:nil];
    XCTAssertNil(blurImage);
}

- (void)testTintEffectWhenTintColorNil
{
    UIImage *image = [self imageForTesting];
    UIImage *blurImage = [UIImage ty_imageByApplyingTintEffectWithColor:nil toImage:image];
    XCTAssertNotNil(blurImage);
}

#pragma mark - Base Blur Effect
- (void)testBaseBlurEffectWhenImageNil
{
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [self imageForTesting];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:nil withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNil(blurImage);
}

- (void)testBaseBlurEffectWhenTintColorNil
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [image copy];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:nil saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNotNil(blurImage);
}

- (void)testBaseBlurEffectWhenMaskImageNil
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:nil];
    XCTAssertNotNil(blurImage);
}

- (void)testBaseBlurEffectWhenImageEmpty
{
    UIImage *image = [[UIImage alloc] init];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [self imageForTesting];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNil(blurImage);
}

- (void)testBaseBlurEffectWhenMaskImageEmpty
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [[UIImage alloc] init];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNil(blurImage);
}

- (void)testBaseBlurEffectWhenRadiusMinus
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = -20.f;
    CGFloat saturationDeltaFactor = 1.2f;
    UIImage *maskImage = [image copy];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNotNil(blurImage);
}

- (void)testBaseBlurEffectWhenSaturationDeltaFactorMinus
{
    UIImage *image = [self imageForTesting];
    CGFloat blurRadius = 20.f;
    CGFloat saturationDeltaFactor = -1.2f;
    UIImage *maskImage = [image copy];
    UIColor *tintColor = [UIColor colorWithWhite:.4f alpha:.3f];
    UIImage *blurImage = [UIImage ty_imageByApplyingBlurToImage:image withRadius:blurRadius tintColor:tintColor saturationDeltaFactor:saturationDeltaFactor maskImage:maskImage];
    XCTAssertNotNil(blurImage);
}

#pragma mark - Helper

- (UIImage *)imageForTesting
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *testBundlePath = [testBundle pathForResource:@"hd2560_1600" ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:testBundlePath];
}

@end
