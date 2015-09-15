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
@property (nonatomic, assign) CGFloat figureSize ;
@property (nonatomic, assign) DrawingFigure *currentFigure ;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;


- (void) placeFigure:(NSInteger)currentNumber;
- (void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer;

@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize kNumberOfFigures = _kNumberOfFigures;
@synthesize figureSize = _figureSize;
@synthesize currentFigure = _currentFigure;
@synthesize panGestureRecognizer = _panGestureRecognizer;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.kNumberOfFigures = 20;
    self.figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    self.squares = [[NSMutableArray alloc] init];

    for (int i = 0; i < self.kNumberOfFigures; ++i)
    {
        [self placeFigure:i];
    }
    
}

- (void) placeFigure:(NSInteger)currentNumber
{
    

        NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
        NSInteger color = ((float)rand() / (float)RAND_MAX) * DFColorCount;
        DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type:color];
        CGSize size = self.view.frame.size;
        
        // 2. Find frame
        CGRect figureFrame = CGRectZero;
        while (true)
        {
            figureFrame = CGRectMake(((float)rand() / (float)RAND_MAX) * (size.width - self.figureSize),
                                               ((float)rand() / (float)RAND_MAX) * (size.height - self.figureSize),
                                               self.figureSize, self.figureSize);
            
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
    

        self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector( moveSubViewWithGestureRecognizer:)];
        [[[self.view subviews] objectAtIndex:currentNumber  ] addGestureRecognizer:self.panGestureRecognizer];



}


-(void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer
{
    UIView *pannedView = recognizer.view;
    bool ifRect = false;
    int indexForCurrent = 0;
    int indexForFigure = 0;
    
    for (DrawingFigure* figure in self.squares)
    {
        indexForCurrent++;
        if (pannedView == figure)
        {
            ifRect = true;
            self.currentFigure = figure;
            break;
        }
    }
    
    if (!ifRect) return;
    
    if (pannedView == self.view) return;
    
    switch (recognizer.state)
    {
        case   UIGestureRecognizerStateBegan:
        {
            pannedView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            pannedView.layer.borderColor = [UIColor blackColor].CGColor;
            pannedView.layer.borderWidth = 2.0;
            pannedView.layer.cornerRadius = 3.0;
            break;
        }
        case   UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            pannedView.center = CGPointMake(pannedView.center.x + translation.x, pannedView.center.y + translation.y);
            [recognizer setTranslation:CGPointZero inView:self.view];
            
            /*for (int i = 0; i < [[self.view subviews] count ]; i++)
            {
                UIView* transformedView = [[self.view subviews] objectAtIndex:i ];
                if (CGRectIntersectsRect([transformedView frame], [pannedView frame]) && (transformedView != pannedView))
                {
                    transformedView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                    transformedView.layer.borderColor = [UIColor blackColor].CGColor;
                    transformedView.layer.borderWidth = 2.0;
                    transformedView.layer.cornerRadius = 3.0;
                    i--;
                }
                else
                {
                    transformedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    transformedView.layer.cornerRadius = 0.0;
                    transformedView.layer.borderWidth = 0.0;
                    break;
                }
                
            }*/
            

            
            break;
        }
        case   UIGestureRecognizerStateEnded:  case UIGestureRecognizerStateCancelled:
        {
            
            pannedView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            pannedView.layer.cornerRadius = 0.0;
            pannedView.layer.borderWidth = 0.0;

            
            for (DrawingFigure* figure in self.squares)
            {
                indexForFigure++;
                if (CGRectIntersectsRect([self.currentFigure frame], [figure frame]) && (self.currentFigure != figure))
                {
                    if ([figure figure]  == [self.currentFigure figure])
                    {
                        [self.squares removeObjectAtIndex:indexForFigure];
                        [self.squares removeObjectAtIndex:indexForCurrent];
                        [pannedView removeFromSuperview];
                        
                        UIView *intersectsView = self.view;
                        
                        for(UIView *subview in [self.view subviews])
                        {
                            if (subview == figure)
                            {
                                intersectsView = subview;
                                break;
                            }
                        }
                        
                        [intersectsView removeFromSuperview];
                        self.kNumberOfFigures -= 2;
                    }
                    else
                    {
                        [self placeFigure:self.kNumberOfFigures];
                        self.kNumberOfFigures++;
                    }
                    break;
                }
            }

            
            break;
        }
        default:
            break;
    
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
