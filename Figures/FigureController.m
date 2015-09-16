//
//  FigureController.m
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"
#import <QuartzCore/QuartzCore.h>


@interface FigureController ()

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, assign) NSInteger kNumberOfFigures;

- (void) placeFigure;
- (void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer;
- (void) zoomIn:(UIView*) view;
- (void) zoomOut:(UIView*) view;
- (void) algorithmForRemovingAndAdding:(DrawingFigure*) view;
- (void) algorithmForMovingRect:(DrawingFigure *)view;

@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize kNumberOfFigures = _kNumberOfFigures;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.kNumberOfFigures = 20;
    self.squares = [[NSMutableArray alloc] init];

    for (int i = 0; i < self.kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
}

- (void) placeFigure
{
        NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
        NSInteger color = ((float)rand() / (float)RAND_MAX) * DFColorCount;
        DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type:color];
        CGSize size = self.view.frame.size;
    
        NSInteger figureSize = 50 + ((float)rand() / (float)RAND_MAX);
        
        // 2. Find frame
        CGRect figureFrame = CGRectZero;
        while (true)
        {
            figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - figureSize),
                                               ((float)rand() / (float)RAND_MAX) * (size.height - figureSize),
                                               figureSize, figureSize);
            
            BOOL intersects = NO;
            for (DrawingFigure* figure in self.squares)
            {
                if (CGRectIntersectsRect(figureFrame, [figure frame]))
                {
                    intersects = YES;
                    break;
                }
            }

            if (!intersects)
            {
                break;
            }
        }
        
        ob.frame = figureFrame;
    
    [self.squares addObject:ob];
    [self.view addSubview:ob];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector( moveSubViewWithGestureRecognizer:)];
    [ob addGestureRecognizer:panGestureRecognizer];


}


- (void)moveSubViewWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    if (![recognizer.view isKindOfClass:[DrawingFigure class]])
    {
        return;
    }
    
    DrawingFigure *pannedView = (DrawingFigure*)recognizer.view;
    
    switch (recognizer.state)
    {
        case   UIGestureRecognizerStateBegan:
        {
            [self zoomIn:pannedView];
            break;
        }
        case   UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            pannedView.center = CGPointMake(pannedView.center.x + translation.x, pannedView.center.y + translation.y);
            [recognizer setTranslation:CGPointZero inView:self.view];
            
            [self algorithmForMovingRect:pannedView];
            break;
        }
        case   UIGestureRecognizerStateEnded:  case UIGestureRecognizerStateCancelled:
        {
            
            [self algorithmForRemovingAndAdding:pannedView];
            break;
        }
        default:
            break;
    
    }
    

}

- (void) zoomIn:(UIView*) view
{
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 2.0;
    view.layer.cornerRadius = 3.0;
}

- (void) zoomOut:(UIView*) view
{
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    view.layer.cornerRadius = 0.0;
    view.layer.borderWidth = 0.0;
}


- (void) algorithmForRemovingAndAdding:(DrawingFigure*) view
{
    [self zoomOut:view];
    
    NSUInteger indexForCurrent = [self.squares indexOfObject:view];
    
    for (DrawingFigure* figure in self.squares)
    {
        if (CGRectIntersectsRect([view frame], [figure frame]) && (view != figure))
        {
            if ([figure figure]  == [view figure])
            {
                
                [self.squares removeObjectAtIndex:indexForCurrent];
                
                NSUInteger indexForFigure = [self.squares indexOfObject:figure];
                
                [self.squares removeObjectAtIndex:indexForFigure];
                
                [view removeFromSuperview];
                [figure removeFromSuperview];
            }
            else
            {
                [self placeFigure];
            }
            break;
        }
    }

}


- (void) algorithmForMovingRect:(DrawingFigure *)view
{
    for (int i = 0; i < [[self.view subviews] count ]; i++)
    {
        UIView* transformedView = [[self.view subviews] objectAtIndex:i ];
        
        if (transformedView != view)
        {
            
            [self zoomOut:transformedView];
            if (CGRectIntersectsRect([transformedView frame], [view frame]))
            {
                [self zoomIn:transformedView];
            }
        }
    }
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
