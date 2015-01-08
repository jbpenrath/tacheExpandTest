//
//  JAPushTextView.m
//  tacheExpand
//
//  Created by PENRATH Jean-baptiste on 08/01/2015.
//  Copyright (c) 2015 JB&Anto. All rights reserved.
//

#import "JAPushView.h"

@interface JAPushView() {
	BOOL expandMask;
	BOOL isAnimating;
    CGFloat screenHeight;
}

@end

@implementation JAPushView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self == nil) {
        return nil;
    }
    
    screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    
    [self setClipsToBounds:YES];
    [self setBackgroundColor:[UIColor colorWithRed:0.62 green:0.18 blue:0.23 alpha:1]];
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake	(0, (CGRectGetHeight(frame)/2)-30, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setTextColor:[UIColor colorWithRed:0.08 green:0.02 blue:0.09 alpha:1]];
    [self.textView setFont:[UIFont fontWithName:@"Georgia" size:35.0]];
    [self.textView setScrollEnabled:NO];
    [self.textView setEditable:NO];
    [self.textView setSelectable:NO];
    [self addSubview:self.textView];
    
    [self setupMasks];
    
    expandMask = NO;
    isAnimating = NO;
    
    //Gesture Recognizers
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(movePaths:)];
    pinchRecognizer.delegate = self;
    [self addGestureRecognizer:pinchRecognizer];
    
    return self;
    
}

-(void)setupMasks {
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.superview.bounds;
    
    //Mask Layers
    self.firstLayer = [CAShapeLayer layer];
    CGPathRef firstPath = [PocketSVG pathFromSVGFileNamed:@"top-base"];
	[self.firstLayer setPosition:CGPointMake(0, -(screenHeight - CGRectGetHeight(self.frame))/2)];
    self.firstLayer.path = firstPath;
    
    self.secondLayer = [CAShapeLayer layer];
    CGPathRef secondPath = [PocketSVG pathFromSVGFileNamed:@"bottom-base"];
    self.secondLayer.path = secondPath;
	[self.secondLayer setPosition:CGPointMake(0, (screenHeight - CGRectGetHeight(self.frame))/2)];
    
    self.thirdLayer = [CALayer layer];
    self.thirdLayer.frame = CGRectMake(0	, CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.frame), 1);
    [self.thirdLayer setBackgroundColor:[UIColor blackColor].CGColor];
    
    [maskLayer addSublayer:self.firstLayer];
    [maskLayer addSublayer:self.secondLayer];
    [maskLayer addSublayer:self.thirdLayer];
    
    self.layer.mask = maskLayer;
}

-(void)movePaths:(UIPinchGestureRecognizer*)sender {
    CGFloat scale = sender.scale;
    NSLog(@"scale: %f", scale);
    if(isAnimating){
        return;
    }
    if(sender.scale < 1) {
        if(expandMask && CGRectGetHeight(self.thirdLayer.frame) < 30) {
            [self resetAnimation:^{
                expandMask = NO;
                isAnimating = NO;
            }];
            [self.firstLayer setPosition:CGPointMake(0,  -(screenHeight - CGRectGetHeight(self.frame))/2)];
            [self.secondLayer setPosition:CGPointMake(0, (screenHeight - CGRectGetHeight(self.frame))/2)];
            self.thirdLayer.frame = CGRectMake(0	, CGRectGetHeight(self.bounds)/2, CGRectGetWidth(self.superview.bounds), 1);
            self.textView.frame = CGRectMake	(0, (CGRectGetHeight(self.textView.frame)/2)-30, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
            
        }
        else if(expandMask) {
            [self.firstLayer  setPosition:CGPointMake(0, self.firstLayer.frame.origin.y + 1.5)];
            [self.secondLayer setPosition:CGPointMake(0, self.secondLayer.frame.origin.y - 1.5)];
            [self.thirdLayer  setFrame:CGRectMake(0, self.thirdLayer.frame.origin.y + 1.5, CGRectGetWidth(self.thirdLayer.frame), CGRectGetHeight(self.thirdLayer.frame) - 3)];
            [self.textView setFrame:CGRectMake(0, self.textView.frame.origin.y + 1, CGRectGetWidth(self.textView.bounds), CGRectGetHeight(self.textView.bounds) - 1)];
        }
    }
    
    if(sender.scale > 1) {
        if(!expandMask) {
            [self middleAnimation:^{
                expandMask = YES;
                isAnimating = NO;
            }];
        }
        else if(expandMask && CGRectGetHeight(self.thirdLayer.frame) <= CGRectGetHeight(self.frame)-200) {
            [self.firstLayer  setPosition:CGPointMake(0, self.firstLayer.frame.origin.y - 1.5)];
            [self.secondLayer setPosition:CGPointMake(0, self.secondLayer.frame.origin.y + 1.5)];
            [self.thirdLayer setFrame:CGRectMake(0, self.thirdLayer.frame.origin.y - 1.5 , CGRectGetWidth(self.thirdLayer.frame), CGRectGetHeight(self.thirdLayer.frame) + 3)];
            [self.textView setFrame:CGRectMake(0, self.textView.frame.origin.y - 1, CGRectGetWidth(self.textView.bounds), CGRectGetHeight(self.textView.bounds) + 1)];
        }
    }
    
    sender.scale = 1;
}

-(void)middleAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-base" PathB:@"top-expand" WithDuration:0.5];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-base" PathB:@"bottom-expand" WithDuration:0.5];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
    }
    [CATransaction commit];
    
}

-(void)resetAnimation:(void (^)(void))block{
    isAnimating = YES;
    [CATransaction begin];{
        [CATransaction setCompletionBlock:^{
            block();
        }];
        
        CABasicAnimation *pathAnimation = [self switchBetweenPathA:@"top-expand" PathB:@"top-base" WithDuration:0.5];
        [self.firstLayer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        CABasicAnimation *pathAnimation2 = [self switchBetweenPathA:@"bottom-expand" PathB:@"bottom-base" WithDuration:0.5];
        [self.secondLayer addAnimation:pathAnimation2 forKey:@"pathAnimation"];
    }
    [CATransaction commit];
}

- (CABasicAnimation *)switchBetweenPathA:(NSString *)pathA PathB:(NSString *)pathB WithDuration:(CGFloat)duration {
    CGPathRef beginShapePath = [PocketSVG pathFromSVGFileNamed:pathA];
    CGPathRef finalShapePath = [PocketSVG pathFromSVGFileNamed:pathB];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.fromValue = (__bridge id)(beginShapePath);
    pathAnimation.toValue = (__bridge id)(finalShapePath);
    
    return pathAnimation;
}

@end
