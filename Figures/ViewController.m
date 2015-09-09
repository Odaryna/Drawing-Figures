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

    //DrawingFigure* figure = [[DrawingFigure alloc] initWithType:DFFigureTypeHexagon];
    //figure.frame = CGRectMake(0, 0, 375, 375);
    //[self.view addSubview:figure];
    
    NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
    DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type];
        CGSize size = self.view.frame.size;
        CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    
        CGRect figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                  ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                  figureSize, figureSize);
    
        ob.frame = figureFrame;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
