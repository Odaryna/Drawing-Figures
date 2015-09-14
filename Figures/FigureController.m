//
//  FigureController.m
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"

static NSInteger const kNumberOfFigures = 15;

@interface FigureController ()

@property (nonatomic, strong) NSMutableArray *squares;
@property (nonatomic, assign) NSInteger counter;
@property (nonatomic, assign) CGFloat figureSize ;

- (void) placeFigure;
- (void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer;
//- (void)detectSwipe:(UISwipeGestureRecognizer *)recognizer;
@end

@implementation FigureController

@synthesize squares = _squares;
@synthesize counter = _counter;
@synthesize figureSize = _figureSize;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.figureSize = 50 + ((float)rand() / (float)RAND_MAX);
    self.squares = [[NSMutableArray alloc] init];

    [self placeFigure];
   
   
    UIPanGestureRecognizer *panGestureRecognizer;
    for (UIView *subview in [self.view subviews])
    {
            panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector( moveSubViewWithGestureRecognizer:)];
        [subview addGestureRecognizer:panGestureRecognizer];
    }
    
}

- (void) placeFigure
{
    
    for (int i = 0; i < kNumberOfFigures; ++i)
    {
        
        NSInteger type = ((float)rand() / (float)RAND_MAX) * DFFigureTypeCount;
        NSInteger color = ((float)rand() / (float)RAND_MAX) * DFColorCount;
        DrawingFigure *ob = [[DrawingFigure alloc] initWithType:type:color];
        CGSize size = self.view.frame.size;
        
        // 2. Find frame
        CGRect figureFrame = CGRectZero;
        for (int j = 0; j < 1000; ++j)
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
            // 3. Check if intersects other views
            // -- YES - continue
            // -- NO - figureFrame = candidate
        }
        
        // 4. setFrame
        
        ob.frame = figureFrame;
        [self.squares addObject:ob];
        [self.view addSubview:ob];
        
    }
    

}


-(void) moveSubViewWithGestureRecognizer: (UIPanGestureRecognizer *) recognizer
{
    UIView *pannedView = recognizer.view;
    switch (recognizer.state)
    {
        case   UIGestureRecognizerStateBegan:
        {
            pannedView.transform = CGAffineTransformMakeScale(1.5, 1.8);
            break;
        }
        case   UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.view];
            pannedView.center = CGPointMake(pannedView.center.x + translation.x, pannedView.center.y + translation.y);
            [recognizer setTranslation:CGPointZero inView:self.view];
            break;
        }
        case   UIGestureRecognizerStateEnded:  case UIGestureRecognizerStateCancelled:
        {
            
            
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
