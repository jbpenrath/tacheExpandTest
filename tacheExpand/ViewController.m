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
    
    self.pushView = [[JAPushView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    
    [self.pushView.textView setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vehicula placerat porttitor. Sed vehicula fermentum bibendum. Etiam vel eleifend leo, ac lacinia dui. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Curabitur placerat nisi nec sapien aliquet rutrum. Ut at metus vel ligula luctus congue. Donec id libero a lorem tincidunt fermentum id nec ex. Sed dapibus fermentum bibendum. Curabitur eu accumsan nisl, non dictum odio. Vestibulum vehicula sapien diam, at viverra justo sagittis et. Maecenas neque odio, imperdiet ac libero at, interdum molestie mauris. Aliquam et velit et lectus malesuada scelerisque. Phasellus quis tortor tincidunt, vulputate est consequat, rhoncus mi. Proin sit amet lorem interdum, commodo lectus vel, pharetra tortor. Cras pellentesque leo ut dui tempor, nec auctor magna mollis."];
    
    [self.view addSubview:self.pushView];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
