//
//  SGControllerTransitionHander.m
//  ViewControllersTransition
//
//  Created by sylphghost on 16/5/10.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SGControllerTransition.h"
typedef NS_ENUM(NSInteger,SGTransitionControllerType) {
SGTransitionNavigationController,
SGTransitionViewController
};
static CGFloat completeProgress = 0.3;
@interface SGControllerTransition()


@property(strong,nonatomic)   UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;
@property(weak,nonatomic) UIViewController * fromController;
@property(weak,nonatomic) UIViewController * toViewController;
@property(assign,nonatomic) SGTransitionControllerType controllerType;
@end
@implementation SGControllerTransition
#pragma mark - life cycle
+ (instancetype)navigationPushTransitionHanderWithFromViewController:(UIViewController *)fromVC ToViewController:(UIViewController *)toVC TransitionAnimation:(SGTransitionAnimation *)animation{
    if (!fromVC.navigationController) return nil;
    SGControllerTransition *hander=[SGControllerTransition new];
    fromVC.navigationController.delegate=hander;
    hander.fromController=fromVC;
    hander.toViewController=toVC;
    animation.fromViewController = fromVC;
    animation.toViewController = toVC;
    animation.type = SGTransitionAnimationPush;
    hander.animation=animation;
    return hander;
}
+ (instancetype)navigationPopTransitionHanderWithFromViewController:(UIViewController *)fromVC  TransitionAnimation:(SGTransitionAnimation *)animation ScreenEdgePanGestureAvailable:(BOOL)available{
    if (!fromVC.navigationController) return nil;
    SGControllerTransition *hander=[SGControllerTransition new];
    fromVC.navigationController.delegate=hander;
    fromVC.navigationController.transitioningDelegate = hander;
    hander.fromController=fromVC;
    hander.controllerType=SGTransitionNavigationController;
    animation.fromViewController = fromVC;
    animation.type = SGTransitionAnimationPop;
    if (available)[hander.fromController.view addGestureRecognizer:hander.edgePanGestureRecognizer];
    fromVC.navigationController.interactivePopGestureRecognizer.enabled=!available;
    hander.animation=animation;
    return hander;
}
+ (instancetype)viewControllerPresentTransitonWithToViewController:(UIViewController *)toVC transitionAnimation:(SGTransitionAnimation *)animation{
    SGControllerTransition *hander=[SGControllerTransition new];
    toVC.transitioningDelegate=hander;
    hander.toViewController=toVC;
    hander.animation=animation;
    animation.toViewController = toVC;
    animation.type = SGTransitionAnimationPresent;
    return hander;
}
+ (instancetype)viewControllerDismissTransitonWithFromViewController:(UIViewController *)fromVC transitionAnimation:(SGTransitionAnimation *)animation ScreenEdgePanGestureAvailable:(BOOL)available{
    SGControllerTransition *hander=[SGControllerTransition new];
    fromVC.transitioningDelegate=hander;
    hander.fromController=fromVC;
    hander.controllerType=SGTransitionViewController;
    fromVC.modalPresentationStyle=UIModalPresentationCustom;
    if (available)[hander.fromController.view addGestureRecognizer:hander.edgePanGestureRecognizer];
    hander.animation=animation;
    animation.type = SGTransitionAnimationDismiss;
    animation.fromViewController = fromVC;
    return hander;
}
- (void)dealloc{
    NSLog(@"hander释放了");
}
#pragma mark - UINavigationControllerDelegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    switch (operation) {
        case UINavigationControllerOperationPush:
             return  _animation?_animation:nil;
        case UINavigationControllerOperationPop:
            return  _animation?_animation:nil;
            break;
        case UINavigationControllerOperationNone:
            return nil;
            break;
    }
}
//navigation百分比退出控制代理
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return _percentDrivenTransition;
}
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
        if ([presented isKindOfClass:[self.toViewController class]])return _animation;
        else return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
   return  _animation?_animation:nil;
}
//viewController百分比dismiss退出控制代理
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}
#pragma mark - private method
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer {
    CGFloat xDistance = [recognizer translationInView:self.fromController.view].x;
    CGFloat fromViewWidth = _fromController.view.frame.size.width;
    CGFloat progress = xDistance/fromViewWidth;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        _percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        _controllerType==SGTransitionNavigationController?[self.fromController.navigationController popViewControllerAnimated:YES]:[self.fromController dismissViewControllerAnimated:YES completion:nil];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded||recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > completeProgress) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

#pragma mark -getters and setters
- (UIScreenEdgePanGestureRecognizer *)edgePanGestureRecognizer{
    if (!_edgePanGestureRecognizer) {
      _edgePanGestureRecognizer= [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanGesture:)];
        _edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    }
    return _edgePanGestureRecognizer;
}
- (void)complete{
    _animation.fromViewController.transitioningDelegate = nil;
    _animation.toViewController.transitioningDelegate = nil;
    if (_controllerType == SGTransitionNavigationController) {
        _fromController.navigationController.delegate = nil;
        _fromController.transitioningDelegate = nil;
    }else{
        _animation.toViewController.transitioningDelegate = nil;
        _animation.fromViewController.transitioningDelegate = nil;
    }
}

@end
