//
//  ViewController.m
//  WhatToEat
//
//  Created by 姚家庆 on 2017/8/1.
//  Copyright © 2017年 明星科技. All rights reserved.
//

#import "ViewController.h"
#import "JNWSpringAnimation.h"
#import "YJFoods.h"
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
@property (nonatomic,strong) YJFoods *foods;

@end

@implementation ViewController
- (IBAction)refresh:(id)sender {
    self.goButton.center = self.originalPoint;
    self.goButton.alpha = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _foods = [[YJFoods alloc]init];
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(goAction:)];
    [self.goButton addGestureRecognizer:panRecognizer];
    self.originalPoint = self.goButton.center;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.foods read];
}
-(void)goAction:(UIPanGestureRecognizer*)panRecognizer{
    CGPoint translatedPoint = [panRecognizer translationInView:self.view];
    if (panRecognizer.state == UIGestureRecognizerStateBegan) {
        self.startTime = [NSDate timeIntervalSinceReferenceDate];
        self.startPoint = CGPointMake(panRecognizer.view.center.x+translatedPoint.x, panRecognizer.view.center.y+translatedPoint.y);

        [panRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
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
        if (self.finalPoint.y<100) {
            self.finalPoint = CGPointMake(self.finalPoint.x, 150-self.finalPoint.y);
           // animationY.values = @[@(self.originalPoint.y),@(100),@(self.finalPoint.y)];
        }else if (self.finalPoint.y>self.view.frame.size.height-50) {
            self.finalPoint = CGPointMake(self.finalPoint.x, 2*(self.view.frame.size.height-50)-self.finalPoint.y);
            //animationY.values = @[@(self.originalPoint.y),@(self.view.frame.size.height-50),@(self.finalPoint.y)];
        }else{
            //animationY.values = @[@(self.originalPoint.y),@(self.finalPoint.y)];
        }

        animationX.mass = 5;
        animationX.stiffness = 10;
        animationX.fromValue = @(self.originalPoint.x);
        animationX.toValue = @(self.finalPoint.x);
        
        animationY.mass = 5;
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
        self.goButton.alpha = 0;
        self.goButton.center = self.finalPoint;
        [self success];
//        if (self.goButton.frame.origin.x>self.aim.frame.origin.x && (self.goButton.frame.origin.x+self.goButton.frame.size.width)<(self.aim.frame.origin.x+self.aim.frame.size.width ) && self.goButton.frame.origin.y>self.aim.frame.origin.y && (self.goButton.frame.origin.y+self.goButton.frame.size.height)<(self.aim.frame.origin.y+self.aim.frame.size.height )) {
//            
//            [self success];
//        }else{
//            [self fail];
//        }
        [panRecognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}
-(void)success{
 //   NSLog(@"success");
    NSUInteger row = arc4random() % self.foods.names.count;
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"决定了" message:[NSString stringWithFormat:@"就吃%@",self.foods.names[row]] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self refresh:nil];
    }];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)fail{
 //   NSLog(@"fail");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
