//
//  DrawingFigure.m
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "DrawingFigure.h"

@interface DrawingFigure ()

@property (nonatomic) NSInteger countOfAngles;

- (void) drawTriangle:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawRectangle:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawRhomb:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawCircle:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawHexagon:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawTrapezoid:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawSmile:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawSinus:(CGContextRef)currentContext :(CGRect)rect;
- (void) drawNAngles:(CGContextRef)currentContext :(CGRect)rect :(NSInteger)count;
- (void) figureCheck:(DrawingFigure*)draw :(CGContextRef)currentContext :(CGRect)rect;
- (void) colorCheck: (DrawingFigure*)draw :(CGContextRef)currentContext :(CGRect)rect ;
//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;


@end

@implementation DrawingFigure

- (DrawingFigure*) initWithType:(DFFigureType)figureType :(DFFillingColor)color;
{
    if (self = [super init])
    {
        self.figure = figureType;
        self.color = color;

    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [self colorCheck:self :currentContext :rect];
    [self figureCheck:self :currentContext :rect];
}

-(void)drawTriangle:(CGContextRef)currentContext :(CGRect)rect
{
       CGPoint arrayOfPoints[3] =
    {
        CGPointMake(rect.origin.x, rect.size.height),
        CGPointMake(rect.size.width, rect.size.height),
        CGPointMake(rect.size.width/2, rect.origin.y)
    };
    
    CGContextBeginPath(currentContext);
    CGContextSetLineWidth(currentContext, 70);
    CGContextAddLines(currentContext, arrayOfPoints, 3);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
}


-(void)drawRectangle:(CGContextRef)currentContext :(CGRect)rect
{
    CGContextBeginPath(currentContext);
    CGContextAddRect(currentContext, rect);
    CGContextFillPath(currentContext);
}

-(void)drawRhomb:(CGContextRef)currentContext :(CGRect)rect
{
     CGPoint arrayOfPoints[4] =
    {
        CGPointMake(rect.size.width/2, rect.origin.y),
        CGPointMake(rect.size.width, rect.size.height/2),
        CGPointMake(rect.size.width/2, rect.size.height),
        CGPointMake(rect.origin.x, rect.size.height/2)
    };
    
    CGContextBeginPath(currentContext);
    CGContextAddLines(currentContext, arrayOfPoints, 4);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
}

-(void)drawCircle:(CGContextRef)currentContext :(CGRect)rect
{
    CGContextFillEllipseInRect (currentContext, rect);
   
    CGContextSetLineWidth (currentContext, 3.0);
    CGContextStrokeEllipseInRect (currentContext, rect);
}

-(void)drawHexagon:(CGContextRef)currentContext :(CGRect)rect
{
    CGPoint arrayOfPoints[6] = { CGPointMake(rect.size.width/4, rect.origin.y),
                                         CGPointMake(rect.size.width*3/4, rect.origin.y),
                                         CGPointMake(rect.size.width, rect.size.height/2),
                                         CGPointMake(rect.size.width*3/4, rect.size.height),
                                         CGPointMake(rect.size.width/4, rect.size.height),
                                         CGPointMake(rect.origin.x,rect.size.height/2)};
    
        CGContextBeginPath(currentContext);
        CGContextAddLines(currentContext, arrayOfPoints, 6);
        CGContextClosePath(currentContext);
        CGContextFillPath(currentContext);
    }

-(void)drawTrapezoid:(CGContextRef)currentContext :(CGRect)rect
{
   
        CGPoint arrayOfPoints[4] = { CGPointMake(rect.size.width/4, rect.origin.y),
                                         CGPointMake(rect.size.width*3/4, rect.origin.y),
                                         CGPointMake(rect.size.width, rect.size.height),
                                         CGPointMake(rect.origin.x ,rect.size.height)};
    
        CGContextBeginPath(currentContext);
        CGContextAddLines(currentContext, arrayOfPoints, 4);
        CGContextClosePath(currentContext);
        CGContextFillPath(currentContext);
    }

-(void)drawSmile:(CGContextRef)currentContext :(CGRect)rect
{
    [self drawCircle:currentContext: rect];
    
    CGFloat eyeW = rect.size.width / 6;
    CGFloat inBetween = rect.size.width / 5;
    
    CGRect rectSmallFirst = CGRectMake(rect.origin.x + rect.size.width / 2 - inBetween - eyeW / 2, rect.origin.y + rect.size.height / 4, rect.size.width/5, rect.size.height/5);
   
    
    CGRect rectSmallSecond = CGRectMake(rect.origin.x + rect.size.width / 2 + inBetween - eyeW / 2, rect.origin.y + rect.size.height / 4, rect.size.width/5, rect.size.height/5);

    CGContextSetLineWidth (currentContext, 3.0);
    CGContextStrokeEllipseInRect (currentContext, rectSmallFirst);
    CGContextStrokeEllipseInRect (currentContext, rectSmallSecond);
    
    CGContextMoveToPoint(currentContext, rect.size.width/3, rect.size.height*2/3);
    CGContextAddCurveToPoint(currentContext, rect.size.width/3, rect.size.height*2/3, rect.size.width*2/3, rect.size.height*3/4 ,rect.size.width*3/4, rect.size.height*2/3);
    CGContextStrokePath(currentContext);

    }

-(void)drawSinus:(CGContextRef)currentContext :(CGRect)rect
{
        int y;
        for(int x=rect.origin.x; x < rect.size.width; x++)
            {
                    y = ((rect.size.height/2) * sin(x/M_PI)) + rect.size.height/2;
                    if (x == rect.origin.x)
                        {
                              CGContextMoveToPoint(currentContext, x, y);
                        }
                    else
                    {
                        
                        CGContextAddLineToPoint(currentContext, x, y);
                    }
                }
        CGContextStrokePath(currentContext);

}


- (void) drawNAngles:(CGContextRef)currentContext :(CGRect)rect :(NSInteger)count
{
    if (count == 0) return;
    
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / count;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5*exteriorAngle);
    
    for (int currentAngle = 0; currentAngle < count; currentAngle++)
    {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:CGPointMake(center.x + curX,
                                                                center.y + curY)]];
    }
    
    for(NSValue * point in result) {
        CGPoint val = [point CGPointValue];
        if([result indexOfObject:point]==0)
        {
            CGContextMoveToPoint (currentContext, val.x, val.y);
            
        }
        else
        {
            CGContextAddLineToPoint (currentContext, val.x, val.y);
        }
    }
    
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
    CGContextDrawPath (currentContext, kCGPathFillStroke);
}


- (void)figureCheck: (DrawingFigure*) draw :(CGContextRef)currentContext :(CGRect)rect ;
{
    CGRect innerRect = CGRectInset (rect, 2, 2);
    switch(draw.figure)
    {
        case 0:
            [self drawTriangle:currentContext :innerRect];
            break;
        case 1:
            [self drawCircle:currentContext :innerRect];
            break;
        case 2:
            [self drawRectangle:currentContext :innerRect];
            break;
        case 3:
            [self drawRhomb:currentContext :innerRect];
            break;
        case 4:
            [self drawHexagon:currentContext :innerRect];
            break;
        case 5:
            [self drawTrapezoid:currentContext :innerRect];
            break;
        case 6:
            [self drawSinus:currentContext :innerRect];
            break;
        case 7:
            [self drawSmile:currentContext :innerRect];
            break;
        case 8:
            [self drawNAngles:currentContext :innerRect :12];
            break;
        default:
            break;
    }
}

- (void) colorCheck: (DrawingFigure*)draw :(CGContextRef)currentContext :(CGRect)rect ;
{
    switch(draw.color)
    {
        case 0:
            CGContextSetRGBFillColor(currentContext, 4, 0.8, 7, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor(currentContext, 0.8, 0.3, 0.3, 1.0);
            CGContextSetRGBStrokeColor(currentContext, 1.5, 0.2, 1.0, 1.0);
            break;
        case 1:
            CGContextSetRGBFillColor(currentContext, 0.3, 10, 5, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
            CGContextSetRGBStrokeColor (currentContext, 0.0, 0.0, 1.0, 1.0);
            break;
        case 2:
            CGContextSetRGBFillColor(currentContext, 56, 87, 122, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor(currentContext, 1.5, 0.2, 1.0, 1.0);
            CGContextSetRGBStrokeColor(currentContext,0.8,0.5,0.5,1);
            break;
        case 3:
            CGContextSetRGBFillColor(currentContext, 0.8, 1.5, 10, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor (currentContext, 3.0, 1.0, 0.0, 1.0);
            CGContextSetRGBStrokeColor (currentContext, 0.0, 0.0, 1.0, 1.0);
            break;
        case 4:
            CGContextSetRGBFillColor(currentContext, 43, 157, 32, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor (currentContext, 0.0, 0.0, 1.0, 1.0);
            CGContextSetRGBStrokeColor(currentContext,0.7,0.4,0.5,1);
            break;
        case 5:
            CGContextSetRGBFillColor(currentContext, 33, 12, 23, 0.5);
            CGContextFillRect(currentContext, rect);
            CGContextSetRGBFillColor (currentContext, 0.0, 0.0, 0.0, 1.0);
            CGContextSetRGBStrokeColor(currentContext, 0.8, 0.3, 0.3, 1.0);
            break;
        default:
            break;
    }

}


/*- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    CGRect frameRect = self.frame;
    frameRect.size.width = 100;
    frameRect.size.height= 100;
    self.frame = frameRect;
    
}*/



@end
