//
//  SGControllerTransitionHander.h
//  ViewControllersTransition
//
//  Created by sylphghost on 16/5/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGTransitionAnimation.h"
@interface SGControllerTransition : NSObject<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;
@property(strong,nonatomic) SGTransitionAnimation *animation;
//navigationPushAnimationHander
+ (instancetype)navigationPushTransitionHanderWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC TransitionAnimation:(SGTransitionAnimation *)animation;
//navigationPopAnimationHander
+ (instancetype)navigationPopTransitionHanderWithFromViewController:(UIViewController *)fromVC  TransitionAnimation:(SGTransitionAnimation *)animation ScreenEdgePanGestureAvailable:(BOOL)available;
//viewControllerPresentAnimationHander
+ (instancetype)viewControllerPresentTransitonWithToViewController:(UIViewController *)toVC transitionAnimation:(SGTransitionAnimation *)animation;
//viewControllerDismissAnimationHander
+ (instancetype)viewControllerDismissTransitonWithFromViewController:(UIViewController *)fromVC transitionAnimation:(SGTransitionAnimation *)animation ScreenEdgePanGestureAvailable:(BOOL)available;
- (void)complete;
@end
