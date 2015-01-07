//
//  ViewController.m
//  tacheExpand
//
//  Created by PENRATH Jean-baptiste on 07/01/2015.
//  Copyright (c) 2015 JB&Anto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/4, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    
    [self.textView setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vehicula placerat porttitor. Sed vehicula fermentum bibendum. Etiam vel eleifend leo, ac lacinia dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Curabitur placerat nisi nec sapien aliquet rutrum. Ut at metus vel ligula luctus congue. Donec id libero a lorem tincidunt fermentum id nec ex. Sed dapibus fermentum bibendum. Curabitur eu accumsan nisl, non dictum odio. Vestibulum vehicula sapien diam, at viverra justo sagittis et. Maecenas neque odio, imperdiet ac libero at, interdum molestie mauris. Aliquam et velit et lectus malesuada scelerisque. Phasellus quis tortor tincidunt, vulputate est consequat, rhoncus mi. Proin sit amet lorem interdum, commodo lectus vel, pharetra tortor. Cras pellentesque leo ut dui tempor, nec auctor magna mollis."];
    
    [self.textView setClipsToBounds:YES];
    [self.textView setBackgroundColor:[UIColor colorWithRed:0.62 green:0.18 blue:0.23 alpha:1]];
    [self.textView setTextColor:[UIColor colorWithRed:0.08 green:0.02 blue:0.09 alpha:1]];
    [self.textView setFont:[UIFont fontWithName:@"Georgia" size:35.0]];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setEditable:NO];
    [self.textView setSelectable:NO];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.view.bounds;
    
    
    self.firstLayer = [CAShapeLayer layer];
    CGPathRef firstPath = [PocketSVG pathFromSVGFileNamed:@"top-base"];
    self.firstLayer.path = firstPath;
    
    self.secondLayer = [CAShapeLayer layer];
    CGPathRef secondPath = [PocketSVG pathFromSVGFileNamed:@"bottom-base"];
    self.secondLayer.path = secondPath;
    [self.secondLayer setPosition:CGPointMake(0, CGRectGetHeight(self.view.bounds)/2)];
    
    self.thirdLayer = [CALayer layer];
    self.thirdLayer.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.bounds), 1);
    [self.thirdLayer setBackgroundColor:[UIColor blackColor].CGColor];
    
    [maskLayer addSublayer:self.firstLayer];
    [maskLayer addSublayer:self.secondLayer];
    [maskLayer addSublayer:self.thirdLayer];
    
    self.view.layer.mask = maskLayer;
    
    [self.view addSubview:self.textView];
        [self middleAnimation];
    
//    CGPathRef primaryShape = [PocketSVG pathFromSVGFileNamed:@"expand"];
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.fillRule = kCAFillRuleEvenOdd;
//    maskLayer.path = primaryShape;
//    self.textView.layer.mask = maskLayer;
//    [self.textView.layer.mask addSublayer:maskLayer];
//    [self.textView.layer.mask setPosition:CGPointMake(0, -CGRectGetHeight(self.view.frame)/4)];
//    [self.view addSubview:self.textView];
    
}

-(void)viewDidAppear:(BOOL)animated {
//    [UIView animateWithDuration:12.0 delay:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.firstLayer.transform = CATransform3DMakeTranslation(30, -30, 0);
//        self.secondLayer.transform = CATransform3DMakeTranslation(30, 30, 0);
//        self.thirdLayer.transform = CATransform3DMakeScale(1, 60, 0);
//    } completion:nil];
}

-(void)middleAnimation{
    CGPathRef finalShapePathTop = [PocketSVG pathFromSVGFileNamed:@"top-expand"];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = 1;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.fromValue = (__bridge id)(self.firstLayer.path);
    pathAnimation.toValue = (__bridge id)(finalShapePathTop);
    
    [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
    [self.firstLayer setPosition:CGPointMake(self.firstLayer.position.x, self.firstLayer.position.y-30)];
    
    CGPathRef finalShapePathBottom = [PocketSVG pathFromSVGFileNamed:@"bottom-expand"];
    CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation2.duration = 1;
    pathAnimation2.removedOnCompletion = NO;
    pathAnimation2.fillMode = kCAFillModeForwards;
    pathAnimation2.fromValue = (__bridge id)(self.secondLayer.path);
    pathAnimation2.toValue = (__bridge id)(finalShapePathBottom);
    
    [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
    [self.secondLayer setPosition:CGPointMake(self.secondLayer.position.x, self.secondLayer.position.y+30)];
    
//    CALayer *finalShapeMiddle = [CALayer layer];
//    finalShapeMiddle.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.bounds), 0);
    
    self.thirdLayer.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds)/2-30, CGRectGetWidth(self.view.bounds), 60);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
