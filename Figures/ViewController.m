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

-(void) placeFigure;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


   
    for (int item = 0; item < 200; ++item)
    {
        [self placeFigure];
    }


}

-(void) placeFigure
{
    NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
    NSInteger color = ((float)rand() / (float)RAND_MAX) * DFColorCount;
    DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type:color];
    CGSize size = self.view.frame.size;
    CGFloat figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    
    CGRect figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                    ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                    figureSize, figureSize);
    
    ob.frame = figureFrame;
    [self.view addSubview:ob];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
