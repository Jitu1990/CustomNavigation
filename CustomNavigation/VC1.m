//
//  VC1.m
//  CustomNavigation
//
//  Created by Mukul Gupta on 29/09/16.
//  Copyright © 2016 hl. All rights reserved.
//

#import "VC1.h"
#import "VC2.h"

@interface PushAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end
@interface PopAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation PopAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromVCFrame = fromViewController.view.frame;
    CGFloat width = toViewController.view.frame.size.width;
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectOffset(fromVCFrame, width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = CGRectOffset(fromVCFrame, -width, 0);
        toViewController.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.frame = fromVCFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
    
}

@end
@implementation PushAnimator

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
 
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CGRect fromVCFrame = fromViewController.view.frame;
    CGFloat width = toViewController.view.frame.size.width;
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectOffset(fromVCFrame, -width, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.frame = CGRectOffset(fromVCFrame, width, 0);
        toViewController.view.frame = fromVCFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.frame = fromVCFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end

@interface VC1 ()<UINavigationControllerDelegate>

@end

@implementation VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.delegate = self;
    
}
- (IBAction)pushactn:(id)sender {
    VC2 *vc=  [[VC2 alloc]initWithNibName:@"VC2" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
 }

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPop) {
        return  [[PopAnimator alloc]init];
    }
    
    if (operation == UINavigationControllerOperationPush) {
        return [[PushAnimator alloc]init];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
