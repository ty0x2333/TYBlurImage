//
//  TYDemoSwitch.h
//  TYBlurImageExample
//
//  Created by 田奕焰 on 15/12/9.
//  Copyright © 2015年 luckytianyiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYDemoSwitch : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign, getter = isOn) BOOL on;

@property (nonatomic, strong) UISwitch *contentSwitch;

@end
