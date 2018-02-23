# HYCMVPDemo

Note : this article is my personal understanding about `MVP`.

In the `PBITableView`, we can see the `MVVM` way to construct the tableview.So what about the `MVP` way? 

There are a common introduce about `MVP`:

```
MVP is a user interface architectural pattern engineered to facilitate automated unit testing and improve the separation of concerns in presentation logic:

The model is an interface defining the data to be displayed or otherwise acted upon in the user interface.

The view is a passive interface that displays data (the model) and routes user commands (events) to the presenter to act upon that data.

The presenter acts upon the model and the view. It retrieves data from repositories (the model), and formats it for display in the view.

Normally, the view implementation instantiates the concrete presenter object, providing a reference to itself. 
```
We can use following example code to show how it works:

```
let model = Person(firstName: "David", lastName: "Blaine")
let view = GreetingViewController()
let presenter = GreetingPresenter(view: view, person: model)
```
Now let's try to code it. 


## Common Data Process in iOS ViewController


* Obtain data from the Networking using JSON mostly
* Transfer JSON to model
* Render the specific view.
* Handle the target action and update the view and model.
   
In the `MVC`, if we put these steps into a `view controller`,it would be massive.

`View Controller` need a `assistant` to help it to distribute the pressure. And the assistant also should `report` the `view controller` what happen in someways.

In the `MVP`,the `assistant` called `presenter`.And the way to report is `Protocol`.

Talking about the `view` and `model` , in the `MVP`, `view` should be updated by the presenter.And `model` should provide the detail info like the color, size, height, layout and presenter handle these info and use the `view's interface` to  update.


## Link the view controller and presenter


In the View Controller, we use the network interface to obtain the data.

So we transfer the JSON to the Model and link the view and present.

```
    [HYCNetworkManager getClockData:^(id data) {
        
        NSDictionary *dic = (NSDictionary *)data;
        
        HYCClockModel *clockModel = [HYCClockModel getModelFromDic:dic];
        
        self.clockPresenter.delegate = self;
        
        [self.clockPresenter attachView:self.clockView withModel:clockModel];
        
    } withFailure:^(id data) {
        
    }];
```

Use the protocol to `link the view controller` and `presenter`. We can according to detail need to implement more functions.In the Demo.

```
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
    }
}
```


## Link the view to presenter


Firstly, using the function and property, we can hold the view in presenter.

```
-(void)attachView:(HYCClockView *)view withModel:(id<HYCClockRenderProtocol>)model{

    //@property(nonatomic,weak) HYCClockView *clockView;
    
    _clockModel = (HYCClockModel *)model;
    _clockView = view;
    
    [self setViewRenderActions];
    [self setBtnTargetActions];
}
```

Then `view` need to provide two kind interface so that the `presenter` can update it.

One is render function for UI.In the Demo, we use the `Category`.
```
-(void)setBgColor:(UIColor *)bgColor withCountNumber:(NSString *)count;
``` 
The other one is targer action for Interaction.In the demo, we use the `block`.

```
-(void)clickStartBtn:(startBlock)block;

-(void)clickEndBtn:(endBlock)block;
```
And the presenter could implement its own protocol to notify the view controller in the view target action block:

```
[self.clockView clickStartBtn:^(UIButton *sender) {
        
        id tempDelegate = self.delegate;
        if (tempDelegate && [tempDelegate respondsToSelector:@selector(returnClockInteraction:)]) {
            [self.delegate returnClockInteraction:ClockInteractionStart];
        }
        
        //Strat Counting
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _clockModel.countNumber = _clockModel.countNumber + 1;
            self.clockView.countLabel.text = [_clockModel getCurrentCount:_clockModel];
        }];
        
}];
```
Note using the  `Category` and `block` can ensure the reuse in some way.

## Link the model to presenter.

Like the view , we use the function parameters as the property to hold the model.

And the question is how can model change the view appearance.

* Model should handle the info and return the value that view needed.

See the code, use the `protocol`. U can handle the model and return the value UI requires.

```
#pragma mark -  HYCClockRenderProtocol Delegate

-(UIColor *)getbgColor:(id)model{
    HYCClockModel *clockModel = (HYCClockModel *)model;
    return clockModel.renderStyle == 2 ?  [UIColor purpleColor] : [UIColor blueColor];
}
```
* Presenter use the model's protocol function to update the view.

```
-(void)setViewRenderActions{
   [_clockView setBgColor:[_clockModel getbgColor:_clockModel] withCountNumber:[_clockModel getCurrentCount:_clockModel]];
}
```

## The data bind Still Confuses A Lot

The `MVP` is suitable for the `one-way` data process. 

Once the `view` changes and it needs to update the model. It is actually a typical feature about `MVVM`.

In the demo, when the user click the `end`,the model's countNumber should be 0 and the view need updated too.

In the demo , I write the code like following, it is not elegant enough but it works fine.
U can learn the `ReactiveCocoa` to know better ways.

```
    [self.clockView clickEndBtn:^(UIButton *sender) {
        
        [self.timer invalidate];
        
        _clockModel.countNumber = 0;
        self.clockView.countLabel.text = [_clockModel getCurrentCount:_clockModel];
        
        id tempDelegate = self.delegate;
        if (tempDelegate && [tempDelegate respondsToSelector:@selector(returnClockInteraction:)]) {
            [self.delegate returnClockInteraction:ClockInteractionEnd];
        }
    }];
```

 














 





