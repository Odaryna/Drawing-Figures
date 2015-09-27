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
static const NSInteger kNumberAttempts = 20;

@interface FigureController ()

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, strong) NSMutableArray *zoomInViews;
@property (nonatomic, strong) DrawingFigure *recognizerView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timeForNewFigure;
@property (nonatomic, strong) NSTimer *timeForBomb;
@property (nonatomic, assign) NSTimeInterval startTime;
@property (nonatomic, assign) NSTimeInterval endTime;
@property (nonatomic, assign) NSTimeInterval pauseTime;
@property (nonatomic, strong) NSTimer *timerForExplosion;


- (void) placeFigure;
- (void) moveSubViewWithGestureRecognizer:(UIPanGestureRecognizer *) recognizer;
- (void) zoomIn:(UIView*) view;
- (void) zoomOut:(UIView*) view;
- (void) algorithmForRemovingAndAdding:(DrawingFigure*) view;
- (void) algorithmForMovingRect:(DrawingFigure *)view;
- (void) timerFire;
- (void) keepScore;
- (CGPoint) generalizeVector;
- (IBAction) stopTheGame:(UIBarButtonItem *)sender;
- (IBAction) stopAndContinueGame:(UIBarButtonItem *)sender;
- (void) startTimer;

@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize recognizerView = _recognizerView;
@synthesize zoomInViews = _zoomInViews;
@synthesize scoreString = _scoreString;


bool clickedPause = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"10e39f13ddfb80570f3e44fb2016cb76.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.squares = [[NSMutableArray alloc] init];
    self.zoomInViews = [[NSMutableArray alloc] init];
    self.startTime = CACurrentMediaTime();
    self.endTime = 0.0f;
    
    self.scoreString = @"";

    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        [self placeFigure];
    }
    
    [self startTimer];
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
    for(; i < kNumberAttempts; i++)
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
    
    if (i >= kNumberAttempts)
    {
        [self stopTimer];
        [self gameOver];
    }
    
    ob.frame = figureFrame;
    
    [self.squares addObject:ob];
    [self.view addSubview:ob];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector( moveSubViewWithGestureRecognizer:)];
    [ob addGestureRecognizer:panGestureRecognizer];


}

- (void)gameOver
{
    [self performSegueWithIdentifier:@"gameOver" sender:self];
}


- (void)moveSubViewWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    if (![recognizer.view isKindOfClass:[DrawingFigure class]])
    {
        return;
    }
    
    
    if (clickedPause) return;
    
   self.recognizerView = (DrawingFigure*)recognizer.view;
    
    switch (recognizer.state)
    {
        case   UIGestureRecognizerStateBegan:
        {
           [self zoomIn:self.recognizerView];
            if ([self.recognizerView figure] == DFFigureTypeBomb)
            {
                self.timerForExplosion = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerExplosion) userInfo:nil repeats:YES];
                [self stopTimer];

                [self performSelector:@selector(gameOver) withObject:nil afterDelay:1];
            }
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



- (void) timerExplosion
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIView* coverView = [[UIView alloc] initWithFrame:screenRect];
    
    [UIView animateWithDuration:0.1 animations:^{
        NSInteger currentBackgroundColor = rand()%4;
        
        coverView.backgroundColor = [UIColor blackColor];
        switch (currentBackgroundColor)
        {
            case 0:
                coverView.backgroundColor = [UIColor greenColor];
                break;
            case 1:
                coverView.backgroundColor = [UIColor redColor];
                break;
            case 2:
                coverView.backgroundColor = [UIColor blueColor];
                break;
            case 3:
                coverView.backgroundColor = [UIColor yellowColor];
                break;
            default:
                break;
        }
        [self.view addSubview:coverView];
    } completion:^(BOOL finished) {
        
    }];

}

- (void) zoomIn:(UIView*) view
{
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    view.layer.borderColor = [UIColor yellowColor].CGColor;
    view.layer.borderWidth = 2.0;
    view.layer.cornerRadius = 3.0;
    view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    view.layer.shadowOpacity = 0.5f;
}

- (void) zoomOut:(UIView*) view
{
    view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    view.layer.cornerRadius = 0.0;
    view.layer.borderWidth = 0.0;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.0f;
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
    
    NSUInteger indexForMin = 0;
    
    for (NSUInteger i = 1; i < [lengths count]; i++)
    {
        if ([lengths[i] doubleValue] < [lengths[indexForMin] doubleValue])
        {
          indexForMin = i;
        }
    }
    
    NSUInteger indexForCurrent = [self.squares indexOfObject:view];
    DrawingFigure* choosedView = [self.zoomInViews objectAtIndex:indexForMin];

    if ([choosedView figure ] == DFFigureTypeBomb)
    {
        {
            self.timerForExplosion = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerExplosion) userInfo:nil repeats:YES];
            [self stopTimer];
            [self performSelector:@selector(gameOver) withObject:nil afterDelay:1];
        }
        return;

    }

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
                 if(figure.center.y + figure.frame.size.height / 2 + 50.0f >= viewHeight)
                 {
                     vector = [self generalizeVector];
                     if(vector.y > 0)
                     {
                         vector.y *= -1;
                     }
                 }
                 if(figure.center.y <= figure.frame.size.height / 2 + 64.0f)
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
    self.endTime += CACurrentMediaTime() - self.startTime;
    NSString* str= [NSString stringWithFormat:@"%.2f", self.endTime];
    self.scoreString = str;
}

- (CGPoint) generalizeVector
{
    CGFloat distance = 35.0f;
    CGFloat diffX = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    CGFloat diffY = ((float)rand() / (float)RAND_MAX) * distance - distance / 2.0f;
    
    return CGPointMake(diffX, diffY);
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gameOver"])
    {
        [self keepScore];
        ViewControllerWithScore *viewController = (ViewControllerWithScore*)segue.destinationViewController;
        viewController.nameOfThePlayer = self.nameOfThePlayer;
        [viewController showScore:self.scoreString];
        
        if (self.timerForExplosion)
        {
            [self.timerForExplosion invalidate];
            self.timerForExplosion = nil;
        }
        
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


- (IBAction)stopTheGame:(UIBarButtonItem *)sender
{    [self stopTimer];
    [self gameOver];
}

- (void) startTimer
{
    self.timeForNewFigure = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(placeFigure) userInfo:nil repeats:YES];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
}

- (void) stopTimer
{
    [self.timer invalidate];
    self.timer  = nil;
    [self.timeForNewFigure invalidate];
    self.timeForNewFigure  = nil;
}



- (IBAction)stopAndContinueGame:(UIBarButtonItem *)sender
{
    if ([sender.title isEqualToString:@"⚫️"])
    {
        self.endTime += CACurrentMediaTime() - self.startTime;
        [self stopTimer];
        clickedPause = true;        
        sender.title = @"◻️";
    }
    else if ([sender.title isEqualToString:@"◻️"])
    {
        self.startTime = CACurrentMediaTime();
        [self startTimer];
        sender.title = @"⚫️";
        clickedPause = false;
    }
}
@end
