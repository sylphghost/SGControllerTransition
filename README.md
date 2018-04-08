# SGControllerTransition

   ![language](https://img.shields.io/badge/language-Object--C-orange.svg)[![Support](https://img.shields.io/badge/support-iOS%208.0%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;![CocoPods](https://img.shields.io/badge/cocopods-v1.4-green.svg)&nbsp;[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/sylphghost/SGURLSessionTask/blob/master/LICENSE)&nbsp;

**It is no longer difficult to animate the controller. Creating a transition animation requires only two steps.**
![SGControllerTransition](SGControllerTransition/SGControllerTransition.gif)


# Usage
## 1. Create the animation

```
  _showAnimation = [SGTransitionAnimation transitionAnimationWithAnimationDurationl:animationTime TransitioningBlock:
^(UIViewController *fromViewController, 
UIViewController *toViewController, 
UIView *containerView, 
SGAnimationCompleteTransitionBlock completeTransitionBlock) {
    //Your animation code.
    
    //When your animation is complete, 
    //be sure to call the completeTransitionBlock.
}];
```

## 2. Create the transition

Transition includes four types of transitions: Push, Pop, Present, and Dismiss. According to the specific rotation movement, select the corresponding transition type.

```
    _transition = [SGControllerTransition 
    viewControllerPresentTransitonWithToViewController:
    toViewController 
    transitionAnimation:
    _showAnimation];
```
# Install

#### CocoaPods
1. Add **pod 'SGControllerTransition','~> 1.0.0'** to your Podfile.
2. Run **pod install** or **pod update**.
3. **Import \<SGControllerTransition/SGControllerTransition.h\>**.

# License
SGControllerTransition is provided under the MIT license. See LICENSE file for details.



