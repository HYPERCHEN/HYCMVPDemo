//
//  ViewController.m
//  HYCMVPDemo
//
//  Created by eric on 2018/2/23.
//  Copyright © 2018年 eric. All rights reserved.
//

#import "ViewController.h"

#import "HYCClockPresenter.h"

#import "HYCNetworkManager.h"

@interface ViewController () <HYCClockPresenterProtocol>

@property(nonatomic,strong)HYCClockPresenter *clockPresenter;

@property(nonatomic,strong)HYCClockView *clockView;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initUI];
    
    [self getNetData];
}

-(void)initUI{
    [self.view addSubview:self.clockView];
}

-(void)getNetData{
    
    [HYCNetworkManager getClockData:^(id data) {
        
        NSDictionary *dic = (NSDictionary *)data;
        
        HYCClockModel *clockModel = [HYCClockModel getModelFromDic:dic];
        
        self.clockPresenter.delegate = self;
        
        [self.clockPresenter attachView:self.clockView withModel:clockModel];
        
    } withFailure:^(id data) {
        
    }];
    
}

#pragma mark - HYCClockPresenter Delegate

-(void)returnClockInteraction:(ClockInteraction)code{
    
    switch (code) {
            
        case ClockInteractionStart:
        {
            NSLog(@"start");
        }
            break;
            
        case ClockInteractionEnd:
        {
            NSLog(@"end");
            
            NSLog(@"now the model number : %ld",self.clockPresenter.clockModel.countNumber);
            
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - lazy init

-(HYCClockPresenter *)clockPresenter{
    if (!_clockPresenter) {
        _clockPresenter = [[HYCClockPresenter alloc] init];
    }
    return _clockPresenter;
}

-(HYCClockView *)clockView{
    if (!_clockView) {
        _clockView = [[HYCClockView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _clockView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
