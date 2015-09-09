//
//  ViewController.m
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "DrawingFigure.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self.view addSubview:tyh];
    DrawingFigure* figure = [[DrawingFigure alloc] initWithType:6];
    [self.view addSubview:figure];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
