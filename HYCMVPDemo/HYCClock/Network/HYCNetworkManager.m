//
//  HYCNetworkManager.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "HYCNetworkManager.h"

@implementation HYCNetworkManager

+(void)getClockData:(suceessReponse)success
        withFailure:(failureReponse)failue{
    success(@{@"renderStyle":@"2" , @"countNumber" : @"666"});
}

@end
