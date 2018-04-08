//
//  ViewController.m
//  SGControllerTransition
//
//  Created by sylphghost on 2018/4/2.
//  Copyright © 2018年 sylphghost. All rights reserved.
//

#import "FirstViewController.h"
#import <SGControllerTransition/SGControllerTransition.h>
#import "SecondViewController.h"
@interface FirstViewController ()
@property(nonatomic,strong) SGControllerTransition* transition;
@property(nonatomic,strong) SGTransitionAnimation* showAnimation;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _logoImageV = [UIImageView new];
    _logoImageV.frame = CGRectMake(0, 100, 100, 100);
    _logoImageV.image= [UIImage imageNamed:@"avatar.jpeg"];
    [self.view addSubview:_logoImageV];
    UIButton *pushButton = [self buttonWithTitle:@"push"];
    [pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *presentActionButton = [self buttonWithTitle:@"present"];
    [presentActionButton addTarget:self action:@selector(presentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect tempButtonFrame = pushButton.frame;
    tempButtonFrame.origin.y = 250;
    tempButtonFrame.origin.x = 200;
    pushButton.frame = tempButtonFrame;
    tempButtonFrame = presentActionButton.frame;
    tempButtonFrame.origin.y = 350;
    tempButtonFrame.origin.x = 200;
    presentActionButton.frame = tempButtonFrame;
    [self.view addSubview:pushButton];
    [self.view addSubview:presentActionButton];
    
    self.title = @"first";
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark private method
- (UIButton *)buttonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button sizeToFit];
    return button;
}
#pragma mark - event response
- (void)pushButtonAction:(UIButton *)sender{
    SecondViewController *toViewController = [SecondViewController new];
    [self setupAnimationWithToViewController:toViewController];
    _transition = [SGControllerTransition navigationPushTransitionHanderWithFromViewController:self ToViewController:toViewController TransitionAnimation:_showAnimation];
    [self.navigationController pushViewController:toViewController animated:true];
}
- (void)presentButtonAction:(UIButton *)sender{
    SecondViewController *toViewController = [SecondViewController new];
    [self setupAnimationWithToViewController:toViewController];
    toViewController.type = Present;
    _transition = [SGControllerTransition viewControllerPresentTransitonWithToViewController:toViewController transitionAnimation:_showAnimation];
    [self presentViewController:toViewController animated:true completion:^{
//        [self.transition complete];
    }];
}
#pragma mark - create animation
- (void)setupAnimationWithToViewController:(UIViewController *)toViewController{
     __weak typeof(self) weakSelf = self;
    NSTimeInterval animationTime = 1;
    _showAnimation = [SGTransitionAnimation transitionAnimationWithAnimationDurationl:animationTime TransitioningBlock:^(UIViewController *fromViewController, UIViewController *toViewController, UIView *containerView, SGAnimationCompleteTransitionBlock completeTransitionBlock) {
        SecondViewController *secondVC = (SecondViewController *)toViewController;
        secondVC.avatarView.image = weakSelf.logoImageV.image;
        secondVC.avatarView.frame = weakSelf.logoImageV.frame;
        [secondVC.view addSubview:secondVC.avatarView];
        weakSelf.logoImageV.alpha = 0;
        [UIView animateWithDuration:animationTime delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect avatarFrame = secondVC.avatarView.frame;
            secondVC.fromRect = avatarFrame;
            avatarFrame.origin.y = 200;
            avatarFrame.origin.x = 100;
            avatarFrame.size = CGSizeMake(200, 200);
            secondVC.avatarView.frame = avatarFrame;
                    } completion:^(BOOL finished) {
            completeTransitionBlock();
            weakSelf.logoImageV.alpha = 1;
        }];
    }];
}

@end
