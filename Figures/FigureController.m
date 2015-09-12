//
//  FigureController.m
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"


@interface FigureController ()
@end

@implementation FigureController

@synthesize squares = _squares;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

- (DrawingFigure*) placeFigure
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
    //self.squares addObject:ob];
    //[self.view addSubview:ob];
    return ob;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
