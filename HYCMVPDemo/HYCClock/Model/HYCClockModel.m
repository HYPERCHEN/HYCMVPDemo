//
//  HYCClockModel.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "HYCClockModel.h"

@implementation HYCClockModel

+(HYCClockModel *)getModelFromDic:(NSDictionary *)dic{
    
    HYCClockModel *model = [[HYCClockModel alloc] init];
    
    model.renderStyle = [dic[@"renderStyle"] integerValue];
    
    model.countNumber = [dic[@"countNumber"] integerValue];
    
    return model;
}

#pragma mark -  HYCClockRenderProtocol Delegate

-(UIColor *)getbgColor:(id)model{
    HYCClockModel *clockModel = (HYCClockModel *)model;
    return clockModel.renderStyle == 2 ?  [UIColor purpleColor] : [UIColor blueColor];
}

-(NSString *)getCurrentCount:(id)model{
    HYCClockModel *clockModel = (HYCClockModel *)model;
    return [NSString stringWithFormat:@"%ld",(long)clockModel.countNumber];
}


@end
