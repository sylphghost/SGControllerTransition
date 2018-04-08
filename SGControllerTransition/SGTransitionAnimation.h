//
//  SGTransitionAnimation.h
//  ViewControllersTransition
//
//  Created by sylphghost on 16/5/9.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SGTransitionAnimationType) {
    SGTransitionAnimationPresent,
    SGTransitionAnimationDismiss,
    SGTransitionAnimationPush,
    SGTransitionAnimationPop
};
typedef void(^SGAnimationCompleteTransitionBlock)(void);
typedef void(^SGAnimationTransitioningBlock)(UIViewController *fromViewController,UIViewController *toViewController,UIView *containerView,SGAnimationCompleteTransitionBlock completeTransitionBlock);
@interface SGTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic) NSTimeInterval  transitionDuration;
@property (nonatomic, weak) UIViewController *fromViewController;
@property (nonatomic, weak) UIViewController *toViewController;
@property (nonatomic, weak) UIView           *containerView;
@property(nonatomic,assign) SGTransitionAnimationType type;
+ (instancetype)transitionAnimationWithAnimationDurationl:(NSTimeInterval)duration TransitioningBlock:(SGAnimationTransitioningBlock)animationBlock;
//subclass override this method
- (void)animateTransitionfromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController ContainerView:(UIView *)containerView transitionConpleteBlock:(SGAnimationCompleteTransitionBlock)completeTransitionBlock;
@end
