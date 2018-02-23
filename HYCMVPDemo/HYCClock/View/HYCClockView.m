//
//  HYCClockView.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "HYCClockView.h"

@implementation HYCClockView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

-(void)initUI{
    
    self.countLabel = [UILabel new];
    self.countLabel.textColor = [UIColor redColor];
    self.countLabel.text = @"0";
    self.countLabel.font = [UIFont boldSystemFontOfSize:20];
    
    self.startBtn = [UIButton new];
    [self.startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.startBtn setTitle:@"Start" forState:UIControlStateNormal];
    [self.startBtn addTarget:self action:@selector(clickStart:) forControlEvents:UIControlEventTouchUpInside];
    
    self.stopBtn = [UIButton new];
    [self.stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stopBtn setTitle:@"Stop" forState:UIControlStateNormal];
    [self.stopBtn addTarget:self action:@selector(clickStop:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)clickStartBtn:(startBlock)block{
    self.startBlock = block;
}

-(void)clickEndBtn:(endBlock)block{
    self.endBlock = block;
}

-(void)clickStart:(UIButton *)btn{
    if (self.startBlock) {
      self.startBlock(btn);
    }
}

-(void)clickStop:(UIButton *)btn{
    if(self.endBlock){
        self.endBlock(btn);
    }
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self addSubview:self.countLabel];
    [self.countLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];
    
    [self addSubview:self.startBtn];
    [self.startBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(10);
        make.right.equalTo(self.mas_centerX).offset(-30);
    }];
    
    [self addSubview:self.stopBtn];
    [self.stopBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_centerX).offset(30);
    }];
    
}



@end
