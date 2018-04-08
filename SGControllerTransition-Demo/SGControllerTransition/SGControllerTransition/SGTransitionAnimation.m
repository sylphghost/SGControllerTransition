//
//  SGTransitionAnimation.m
//  ViewControllersTransition
//
//  Created by sylphghost on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "SGTransitionAnimation.h"
static NSTimeInterval DefaultTransitionDuration = 0.5;
@interface SGTransitionAnimation()
@property(copy,nonatomic) SGAnimationTransitioningBlock animationBlock;
@end
@implementation SGTransitionAnimation
#pragma mark -UIViewControllerAnimatedTransitioning
- (instancetype)init{
    if (self=[super init]) {
        _transitionDuration=DefaultTransitionDuration;
    }
    return self;
}
+ (instancetype)transitionAnimationWithAnimationDurationl:(NSTimeInterval)duration TransitioningBlock:(SGAnimationTransitioningBlock)animationBlock{
    SGTransitionAnimation *animation =[SGTransitionAnimation new];
    animation.animationBlock=[animationBlock copy];
    animation.transitionDuration=duration;
    return animation;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return _transitionDuration;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    _toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    _containerView      = [transitionContext containerView];
    if (_type == SGTransitionAnimationDismiss || _type == SGTransitionAnimationPop) {
        [_containerView addSubview:_toViewController.view];
        [_containerView addSubview:_fromViewController.view];
    } else {
        [_containerView addSubview:_fromViewController.view];
        [_containerView addSubview:_toViewController.view];
    }
    SGAnimationCompleteTransitionBlock completeBlock =^{
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    };
    if (_animationBlock) {
        
    _animationBlock(_fromViewController,_toViewController,_containerView,completeBlock);
    }else{
    [self animateTransitionfromViewController:_fromViewController toViewController:_toViewController ContainerView:_containerView transitionConpleteBlock:completeBlock];
    }
}
- (void)animateTransitionfromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController ContainerView:(UIView *)containerView transitionConpleteBlock:(SGAnimationCompleteTransitionBlock)completeBlock{

}
- (void)dealloc{
    NSLog(@"animation被释放了");
}
@end
