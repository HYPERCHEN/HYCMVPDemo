//
//  HYCClockView.h
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef void(^startBlock)(UIButton *sender);
typedef void(^endBlock)(UIButton *sender);

@interface HYCClockView : UIView

@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)UIButton *stopBtn;

@property(nonatomic,copy)startBlock startBlock;
@property(nonatomic,copy)endBlock endBlock;

-(void)clickStartBtn:(startBlock)block;

-(void)clickEndBtn:(endBlock)block;



@end
