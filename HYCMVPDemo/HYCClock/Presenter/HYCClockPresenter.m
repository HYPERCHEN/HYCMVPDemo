//
//  HYCClockPresenter.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "HYCClockPresenter.h"

@implementation HYCClockPresenter

-(void)attachView:(HYCClockView *)view withModel:(id<HYCClockRenderProtocol>)model{
    
    _clockModel = (HYCClockModel *)model;
    
    _clockView = view;
    
    [self setViewRenderActions];
    
    [self setBtnTargetActions];
}

-(void)setViewRenderActions{
   [_clockView setBgColor:[_clockModel getbgColor:_clockModel] withCountNumber:[_clockModel getCurrentCount:_clockModel]];
}
-(void)setBtnTargetActions{
    
    [self.clockView clickStartBtn:^(UIButton *sender) {
        
        id tempDelegate = self.delegate;
        if (tempDelegate && [tempDelegate respondsToSelector:@selector(returnClockInteraction:)]) {
            [self.delegate returnClockInteraction:ClockInteractionStart];
        }
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _clockModel.countNumber = _clockModel.countNumber + 1;
            self.clockView.countLabel.text = [_clockModel getCurrentCount:_clockModel];
        }];
        
    }];
    
    [self.clockView clickEndBtn:^(UIButton *sender) {
        
        [self.timer invalidate];
        
        _clockModel.countNumber = 0;
        self.clockView.countLabel.text = [_clockModel getCurrentCount:_clockModel];
        
        id tempDelegate = self.delegate;
        if (tempDelegate && [tempDelegate respondsToSelector:@selector(returnClockInteraction:)]) {
            [self.delegate returnClockInteraction:ClockInteractionEnd];
        }
    }];
    
}

#pragma mark - Custom Init

-(instancetype)init{
    self = [super init];
    if (self) {
        _timer = [[NSTimer alloc] init];
        _clockModel = [[HYCClockModel alloc] init];
    }
    return self;
}


@end
