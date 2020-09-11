//
//  ViewController.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 Joting. All rights reserved.
//

#import "ViewController.h"
#import "JNWSpringAnimation.h"
#import "YJGroups.h"
#import "YJResultManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import "YJProgressHUD.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;
@property (nonatomic,assign) CGFloat startTime;
@property (nonatomic,assign) CGFloat endTime;
@property (nonatomic,assign) CGFloat deltTime;
@property (nonatomic,assign) CGFloat speedX;
@property (nonatomic,assign) CGFloat speedY;
@property (nonatomic,assign) CGPoint finalPoint;
@property (nonatomic,assign) CGPoint originalPoint;
@property (weak, nonatomic) IBOutlet UIImageView *aim;
@property (weak,nonatomic) YJGroups *groups;
@property (strong,nonatomic) NSMutableArray *allElement;
@end

@implementation ViewController
-(NSMutableArray *)allElement{
    if (!_allElement) {
        NSMutableArray *arrayM = [NSMutableArray array];
        for (Group *element in self.groups.groups) {
            if (element.selected) {
                [arrayM addObjectsFromArray:element.members.allObjects];
            }
        }
        _allElement = arrayM;
    }
    return _allElement;
}
-(YJGroups *)groups{
    if (!_groups) {
        _groups = [YJGroups shared];
    }
    return _groups;
}
- (IBAction)goToResult:(id)sender {
    [self showViewController:[YJResultManager shared].resultController sender:nil];
}
- (IBAction)refresh:(id)sender {
    self.goButton.center = self.originalPoint;
    self.goButton.alpha = 1;
}
-(void)initElements{
    _allElement = nil;
}
- (IBAction)initElements:(id)sender {
    [self initElements];
    [YJProgressHUD showSuccess:@"重置成功"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(goAction:)];
    [self.goButton addGestureRecognizer:panRecognizer];
    self.originalPoint = self.goButton.center;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self initElements];
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[self imageWithColor:[UIColor colorWithWhite:1 alpha:0]]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
}
-(void)goAction:(UIPanGestureRecognizer*)panRecognizer{
    CGPoint translatedPoint = [panRecognizer translationInView:self.view];
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        self.startPoint = CGPointMake(panRecognizer.view.center.x+translatedPoint.x, panRecognizer.view.center.y+translatedPoint.y);

        [panRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        AudioServicesPlaySystemSound(1519);
    }
    if (panRecognizer.state == UIGestureRecognizerStateEnded) {
        self.endTime = [NSDate timeIntervalSinceReferenceDate];
        self.deltTime = self.endTime - self.startTime;
        self.endPoint = CGPointMake(panRecognizer.view.center.x+translatedPoint.x, panRecognizer.view.center.y+translatedPoint.y);
        self.speedX = (self.endPoint.x - self.startPoint.x)/self.deltTime;
        self.speedY = (self.endPoint.y - self.startPoint.y)/self.deltTime;
        self.finalPoint = CGPointMake(self.endPoint.x + self.speedX * 0.05, self.endPoint.y + self.speedY * 0.05);
        //动画
        JNWSpringAnimation *animationX = [JNWSpringAnimation animationWithKeyPath:@"position.x"];

        JNWSpringAnimation *animationY = [JNWSpringAnimation animationWithKeyPath:@"position.y"];

        
        if (self.finalPoint.x < 50 ) {
            self.finalPoint = CGPointMake(100-self.finalPoint.x, self.finalPoint.y);
            //animationX.values = @[@(self.originalPoint.x),@50,@(self.finalPoint.x)];
        }else if (self.finalPoint.x > self.view.frame.size.width-50 ) {
            self.finalPoint = CGPointMake(2*self.view.frame.size.width-50 - self.finalPoint.x, self.finalPoint.y);
            //animationX.values = @[@(self.originalPoint.x),@(self.view.frame.size.width-50),@(self.finalPoint.x)];
        }else{
            //animationX.values = @[@(self.originalPoint.x),@(self.finalPoint.x)];
        }
        if (self.finalPoint.y<50) {
            self.finalPoint = CGPointMake(self.finalPoint.x, 100-self.finalPoint.y);
           // animationY.values = @[@(self.originalPoint.y),@(100),@(self.finalPoint.y)];
        }else if (self.finalPoint.y>self.view.frame.size.height-50) {
            self.finalPoint = CGPointMake(self.finalPoint.x, 2*(self.view.frame.size.height-50)-self.finalPoint.y);
            //animationY.values = @[@(self.originalPoint.y),@(self.view.frame.size.height-50),@(self.finalPoint.y)];
        }else{
            //animationY.values = @[@(self.originalPoint.y),@(self.finalPoint.y)];
        }

        animationX.mass = 10;
        animationX.stiffness = 10;
        animationX.fromValue = @(self.originalPoint.x);
        animationX.toValue = @(self.finalPoint.x);
        
        animationY.mass = 10;
        animationY.stiffness = 10;
        animationY.fromValue = @(self.originalPoint.y);
        animationY.toValue = @(self.finalPoint.y);
        //创建透明度动画
        CABasicAnimation *aniAlp=[CABasicAnimation animation];
        aniAlp.keyPath=@"opacity";
        //创建缩放动画
        CAKeyframeAnimation *aniScale=[CAKeyframeAnimation animation];
        aniScale.keyPath=@"transform.scale";
        //创建旋转动画
        CABasicAnimation *aniRot=[CABasicAnimation animation];
        aniRot.keyPath=@"transform.rotation";
        //隐藏
        //透明度变为0
        aniAlp.fromValue=@1;
        aniAlp.byValue = @0.9;
        aniAlp.toValue=@0;
        //缩小
        aniScale.values=@[@1,@0];
        //旋转
        aniRot.fromValue=@0;
        aniRot.toValue=@(-M_PI);

        
        CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
        aniGroup.animations = @[animationX,animationY,aniAlp,aniRot,aniScale];
        aniGroup.duration = 5;
        [self.goButton.layer addAnimation:aniGroup forKey:nil];
//        self.goButton.alpha = 0;
//        self.goButton.center = self.finalPoint;
        if (self.finalPoint.x>self.aim.frame.origin.x && (self.finalPoint.x)<(self.aim.frame.origin.x+self.aim.frame.size.width ) && self.finalPoint.y>self.aim.frame.origin.y && (self.finalPoint.y)<(self.aim.frame.origin.y+self.aim.frame.size.height )) {
            
            [self success];
        }else{
            [self fail];
        }
        [panRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}
-(void)success{
 //   NSLog(@"success");
    
    if (!self.allElement.count) {
        [YJProgressHUD showWarning:@"所有人都已经中奖了，不要再扔了！"];
        return;
    }
    NSUInteger row = arc4random() % self.allElement.count;
    People *object = self.allElement[row];

    if([[YJResultManager shared]add:object]){
        [self.allElement removeObject:object];
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Gotit", nil) message:[NSString stringWithFormat:@"%@ %@ %@!",NSLocalizedString(@"ItisHeader", nil),object.name,NSLocalizedString(@"ItisFooter", nil)] preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:NSLocalizedString(@"Sure", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertVC addAction:sure];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        //show error
        [YJProgressHUD showError:@"获奖人数已满，不能再抽奖咯"];
    }

}
-(void)fail{
    [YJProgressHUD showError:@"没有砸中哦"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
