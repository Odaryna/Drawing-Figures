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
    // Do any additional setup after loading the view, typically from a nib.

   
    for (int item = 0; item < 50; ++item)
    {
        [self placeFigure];
    }


}

-(void) placeFigure
{
    NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
    DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type];
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
