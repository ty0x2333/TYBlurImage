//
//  BlurAnimationTest.m
//  Test
//
//  Created by 田奕焰 on 15/12/15.
//
//

#import <XCTest/XCTest.h>
#import "UIImageView+BlurAnimation.h"
@interface BlurAnimationTest : XCTestCase

@end

@implementation BlurAnimationTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlurIn
{
    UIImage *image = [self imageForTesting];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView ty_blurInAnimationWithDuration:10];
}

- (void)testBlurOut
{
    UIImage *image = [self imageForTesting];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView ty_blurOutAnimationWithDuration:10];
}

- (void)testBlurInWithCompletion
{
    UIImage *image = [self imageForTesting];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    XCTestExpectation * expectation = [self expectationWithDescription:@"ty_blurOutAnimationWithDuration"];
    [imageView ty_blurInAnimationWithDuration:2 completion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}

- (void)testBlurOutWithCompletion
{
    UIImage *image = [self imageForTesting];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    XCTestExpectation * expectation = [self expectationWithDescription:@"ty_blurOutAnimationWithDuration"];
    [imageView ty_blurOutAnimationWithDuration:2 completion:^{
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
}


- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - Helper

- (UIImage *)imageForTesting
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSString *testBundlePath = [testBundle pathForResource:@"hd2560_1600" ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:testBundlePath];
}

@end
