//
//  ViewController.m
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "DrawingFigure.h"
#import "FigureController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FigureController* figureController = [[FigureController alloc] init];
    DrawingFigure* figure;
    
    
    
    figureController.squares = [[NSMutableArray alloc] init];
    
    for (int item = 0; item < 10; ++item)
    {
        figure = [figureController placeFigure];
        [figureController.squares addObject:figure];
        [self.view addSubview:figure];
        
    }

    for (UIView *subview in [self.view subviews])
    {
       UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveSubViewWithGestureRecognizer:)];
        [subview addGestureRecognizer:panGestureRecognizer];
    }
}

-(void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer
{
    UIView *pannedView = recognizer.view;
    CGPoint translation = [recognizer translationInView:pannedView.superview];
    pannedView.center = CGPointMake(pannedView.center.x + translation.x, pannedView.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:pannedView.superview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
