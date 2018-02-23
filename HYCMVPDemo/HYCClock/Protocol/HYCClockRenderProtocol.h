//
//  HYCClockRenderProtocol.h
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol HYCClockRenderProtocol <NSObject>

- (UIColor *)getbgColor:(id)model;

- (NSString *)getCurrentCount:(id)model;


@end
