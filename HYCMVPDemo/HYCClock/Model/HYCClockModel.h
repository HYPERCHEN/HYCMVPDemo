//
//  HYCClockModel.h
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HYCClockRenderProtocol.h"

@interface HYCClockModel : NSObject <HYCClockRenderProtocol>

@property(nonatomic,assign)NSInteger countNumber;

@property(nonatomic)NSInteger actionStyle;

@property(nonatomic)NSInteger renderStyle;

+(HYCClockModel *)getModelFromDic:(NSDictionary *)dic;



@end
