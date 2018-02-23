//
//  HYCClockPresenter.h
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYCClockView.h"
#import "HYCClockView+HYCClockViewConfig.h"
#import "HYCClockModel.h"

typedef NS_ENUM(NSInteger,ClockInteraction){
    ClockInteractionStart,
    ClockInteractionEnd
};

@protocol HYCClockPresenterProtocol

-(void)returnClockInteraction:(ClockInteraction)code;

@end

@interface HYCClockPresenter : NSObject 

@property(nonatomic,strong)HYCClockModel *clockModel;

@property(nonatomic,weak)HYCClockView *clockView;

@property(nonatomic,weak) id<HYCClockPresenterProtocol> delegate;

@property(nonatomic,strong)NSTimer *timer;

-(void)attachView:(HYCClockView *)view withModel:(id<HYCClockRenderProtocol>)model;



@end
