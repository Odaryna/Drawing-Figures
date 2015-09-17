//
//  FigureController.m
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"
#import <QuartzCore/QuartzCore.h>

static const NSInteger kNumberOfFigures = 15;


@interface FigureController ()

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *zoomInViews;
@property (nonatomic, strong) DrawingFigure *recognizerView;
@property (nonatomic, strong) NSTimer *timer;

- (void) placeFigure;
- (void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer;
- (void) zoomIn:(UIView*) view;
- (void) zoomOut:(UIView*) view;
- (void) algorithmForRemovingAndAdding:(DrawingFigure*) view;
- (void) algorithmForMovingRect:(DrawingFigure *)view;
- (void) timerFire;

@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize recognizerView = _recognizerView;
@synthesize zoomInViews = _zoomInViews;
@synthesize timer = _timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.squares = [[NSMutableArray alloc] init];
    self.zoomInViews = [[NSMutableArray alloc] init];

    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
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
        for(int i = 0; i < 15; i++)
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
    
   self.recognizerView = (DrawingFigure*)recognizer.view;
    
    switch (recognizer.state)
    {
        case   UIGestureRecognizerStateBegan:
        {
           [self zoomIn:self.recognizerView];
            break;
        }
        case   UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            self.recognizerView.center = CGPointMake(self.recognizerView.center.x + translation.x, self.recognizerView.center.y + translation.y);
            [recognizer setTranslation:CGPointZero inView:self.view];
            
            [self algorithmForMovingRect:self.recognizerView];
            break;
        }
        case   UIGestureRecognizerStateEnded:  case UIGestureRecognizerStateCancelled:
        {
            [self algorithmForRemovingAndAdding:self.recognizerView];
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
    for (DrawingFigure* figure in self.squares)
    {
        if (figure == view) continue;
        if (figure.layer.borderWidth == 2.0 && figure.layer.cornerRadius == 3.0)
        {
            [self.zoomInViews addObject:figure];
        }
    }
    
    for (DrawingFigure* figure in self.squares)
    {
        [self zoomOut:figure];
    }
    
    if (![self.zoomInViews count]) return;
    
    NSMutableArray *lengths = [[NSMutableArray alloc] initWithCapacity:[self.zoomInViews count]];
    
    for (int i = 0; i < [self.zoomInViews count]; i++)
    {
        DrawingFigure* figure = self.zoomInViews[i];
        double length;
        length = sqrt((figure.center.x - view.center.x)*(figure.center.x - view.center.x) + (figure.center.y - view.center.y)*(figure.center.y - view.center.y));
        [lengths addObject:[NSNumber numberWithDouble:length ]];
    }
    
    NSUInteger indexForMax = 0;
    
    for (int i = 0; i < [lengths count] - 1; i++)
    {
        if (lengths[i] > lengths[i+1]) indexForMax = i+1;
    }
    
    NSUInteger indexForCurrent = [self.squares indexOfObject:view];
    DrawingFigure* choosedView = [self.zoomInViews objectAtIndex:indexForMax];


    if ([choosedView figure]  == [view figure])
        {
                
            [self.squares removeObjectAtIndex:indexForCurrent];
                
             NSUInteger indexForFigure = [self.squares indexOfObject:choosedView];
             [self.squares removeObjectAtIndex:indexForFigure];
                
            [view removeFromSuperview];
            [choosedView removeFromSuperview];
        }
    else
        {
            [self placeFigure];
        }

    
    [UIView animateWithDuration:0.1 animations:^{
        self.recognizerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.recognizerView = nil;
        
    }];
    
    
    [self.zoomInViews removeAllObjects];

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



- (void)timerFire
{
    CGFloat distance = 15.0f;
    CGFloat viewHeight = self.view.frame.size.height-25;
    CGFloat viewWidth = self.view.frame.size.width-25;
    CACurrentMediaTime();
    
    __weak typeof(DrawingFigure) *weakView = self.recognizerView;
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        
        for (DrawingFigure* figure in self.squares)
        {
            if (weakView == nil || (weakView && ![figure isEqual:weakView]))
            {
                CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
                CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
                
                                if(figure.center.x >= viewWidth)
                                    {
                                            if(diffX > 0)
                                                {
                                                        diffX *= -1;
                                                    }
                                        }
                                if(figure.center.x <= 25)
                                   {
                                            if(diffX < 0)
                                                {
                                                        diffX *= -1;
                                                    }
                                        }
                                if(figure.center.y >= viewHeight)
                                    {
                                            if(diffY > 0)
                                                {
                                                        diffY *= -1;
                                                    }
                                       }
                                if(figure.center.y <= 25)
                                    {
                                            if(diffY < 0)
                                                {
                                                        diffY *= -1;
                                                    }
                                        }
                figure.center = CGPointMake(figure.center.x + diffX, figure.center.y + diffY);
            }
        }
        
                     } completion:^(BOOL finished) {
                         self.recognizerView = nil;
                     }];
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
