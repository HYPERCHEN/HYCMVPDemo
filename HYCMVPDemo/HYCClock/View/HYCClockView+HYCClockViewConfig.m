//
//  HYCClockView+HYCClockViewConfig.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "HYCClockView+HYCClockViewConfig.h"

@implementation HYCClockView (HYCClockViewConfig)

-(void)setBgColor:(UIColor *)bgColor withCountNumber:(NSString *)count{
    self.backgroundColor = bgColor;
    self.countLabel.text = count;
}

@end
