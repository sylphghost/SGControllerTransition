//
//  SeoncdViewController.h
//  SGControllerTransition
//
//  Created by sylphghost on 2018/4/3.
//  Copyright © 2018年 sylphghost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SGControllerTransition/SGControllerTransition.h>
typedef NS_ENUM(NSInteger,SecondViewControllerShowType) {
    Push,
    Present
};
@interface SecondViewController : UIViewController
@property(nonatomic,strong) UIImageView* avatarView;
@property(nonatomic,assign) CGRect fromRect;
@property(nonatomic,assign) SecondViewControllerShowType type;
@property(nonatomic,strong) SGControllerTransition* transition;
@end
