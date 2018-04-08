//
//  SeoncdViewController.m
//  SGControllerTransition
//
//  Created by sylphghost on 2018/4/3.
//  Copyright © 2018年 sylphghost. All rights reserved.
//

#import "SecondViewController.h"

#import "FirstViewController.h"
@interface SecondViewController ()

@property(nonatomic,strong) SGTransitionAnimation* hiddenAnimation;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"second";
    if (_type == Present) {
        UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [dismissButton setTitle:@"dismiss" forState:UIControlStateNormal];
        [dismissButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        dismissButton.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:dismissButton];
        [dismissButton sizeToFit];
        CGRect buttonFrame = dismissButton.frame;
        buttonFrame.origin.x = (self.view.frame.size.width - buttonFrame.size.width)/2.0;
        buttonFrame.origin.y = self.view.frame.size.height - buttonFrame.size.height - 100;
        dismissButton.frame = buttonFrame;
        [dismissButton addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dismissButton];
    }
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_type == Push) {
        [self setupHideenAnimation];
        _transition = [SGControllerTransition navigationPopTransitionHanderWithFromViewController:self TransitionAnimation:_hiddenAnimation ScreenEdgePanGestureAvailable:true];
    }else{
            [self setupHideenAnimation];
            self.transition = [SGControllerTransition viewControllerDismissTransitonWithFromViewController:self transitionAnimation:self.hiddenAnimation ScreenEdgePanGestureAvailable:true];
    }

}
- (void)dealloc{
    NSLog(@"第二个销毁了");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark event response
- (void)dismissAction:(UIButton *)sender{
    [self setupHideenAnimation];
    _transition = [SGControllerTransition viewControllerDismissTransitonWithFromViewController:self transitionAnimation:_hiddenAnimation ScreenEdgePanGestureAvailable:true];
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
#pragma mark - getters and setters
- (UIImageView *)avatarView{
    if (!_avatarView) {
        _avatarView = [UIImageView new];
    }
    return _avatarView;
}
- (void)setupHideenAnimation{
    NSTimeInterval duration = 1;
     __weak typeof(self) weakSelf = self;
    _hiddenAnimation = [SGTransitionAnimation transitionAnimationWithAnimationDurationl:duration TransitioningBlock:^(UIViewController *fromViewController, UIViewController *toViewController, UIView *containerView, SGAnimationCompleteTransitionBlock completeTransitionBlock) {
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
              weakSelf.avatarView.frame = weakSelf.fromRect;
        } completion:^(BOOL finished) {
            completeTransitionBlock();
        }];
        
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
