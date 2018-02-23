//
//  HYCNetworkManager.h
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^suceessReponse)(id data);
typedef void(^failureReponse)(id data);

@interface HYCNetworkManager : NSObject

+(void)getClockData:(suceessReponse)success withFailure:(failureReponse)failue;


@end
