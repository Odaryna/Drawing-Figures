//
//  FigureController.m
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"
#import <QuartzCore/QuartzCore.h>


static const NSInteger kNumberOfFigures = 20;

@interface FigureController ()

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *zoomInViews;
@property (nonatomic, strong) DrawingFigure *recognizerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timeForNewFigure;
@property (nonatomic, assign) NSTimeInterval startTime;


- (void) placeFigure;
- (void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer;
- (void) zoomIn:(UIView*) view;
- (void) zoomOut:(UIView*) view;
- (void) algorithmForRemovingAndAdding:(DrawingFigure*) view;
- (void) algorithmForMovingRect:(DrawingFigure *)view;
- (void) timerFire;
- (void) keepScore;
- (CGPoint) generalizeVector;
- (IBAction) stopTheGame:(UIBarButtonItem *)sender;

@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize recognizerView = _recognizerView;
@synthesize zoomInViews = _zoomInViews;
@synthesize scoreString = _scoreString;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.squares = [[NSMutableArray alloc] init];
    self.zoomInViews = [[NSMutableArray alloc] init];
    self.startTime = CACurrentMediaTime();
    self.scoreString = @"";

    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
    
    self.timeForNewFigure = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(placeFigure) userInfo:nil repeats:YES];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
}

- (void) placeFigure
{
    NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
    NSInteger color = ((float)rand() / (float)RAND_MAX) * DFColorCount;
    DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type:color];
    ob.vector = [self generalizeVector];
    CGSize size = self.view.frame.size;
    
    NSInteger figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    
    CGRect figureFrame = CGRectZero;
    
    int i = 0;
    for(; i < 20; i++)
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
    
    if (i == 5)
    {
        [self performSegueWithIdentifier:@"gameOver" sender:self];
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
    
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat viewWidth = self.view.frame.size.width;
    
    __weak typeof(DrawingFigure) *weakView = self.recognizerView;
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^
     {
       
         for (DrawingFigure* figure in self.squares)
         {
             if (weakView == nil || (weakView && ![figure isEqual:weakView]))
             {
                 
                 CGPoint vector = figure.vector;
                 if(figure.center.x + figure.frame.size.width / 2 >= viewWidth)
                 {
                     vector = [self generalizeVector];
                     if(vector.x > 0)
                     {
                         vector.x *= -1;
                     }
                 }
                 if(figure.center.x <= figure.frame.size.width / 2)
                 {
                     vector = [self generalizeVector];
                     if(vector.x < 0)
                     {
                         vector.x *= -1;
                     }
                 }
                 if(figure.center.y + figure.frame.size.height / 2 >= viewHeight)
                 {
                     vector = [self generalizeVector];
                     if(vector.y > 0)
                     {
                         vector.y *= -1;
                     }
                 }
                 if(figure.center.y <= figure.frame.size.height / 2)
                 {
                     vector = [self generalizeVector];
                     if(vector.y < 0)
                     {
                         vector.y *= -1;
                     }
                 }
                 figure.vector = vector;
                 figure.center = CGPointMake(figure.center.x + vector.x, figure.center.y + vector.y);
             }
         }
         
     } completion:^(BOOL finished) {
         self.recognizerView = nil;
     }];
    
}

- (void) keepScore
{
    self.startTime = CACurrentMediaTime() - self.startTime;
    NSString* str= [NSString stringWithFormat:@"%.2f", self.startTime];
    self.scoreString = str;
}

- (CGPoint) generalizeVector
{
    CGFloat distance = 35.0f;
    CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    
    return CGPointMake(diffX, diffY);
}

- (IBAction)stopTheGame:(UIBarButtonItem *)sender
{
    [self.timer invalidate];
    self.timer  = nil;
    [self.timeForNewFigure invalidate];
    self.timeForNewFigure  = nil;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gameOver"])
    {
        [self keepScore];
        ViewControllerWithScore *viewController = (ViewControllerWithScore*)segue.destinationViewController;
        [viewController showScore:self.scoreString];
        
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
