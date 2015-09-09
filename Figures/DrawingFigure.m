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

@end

@implementation DrawingFigure

- (DrawingFigure*) initWithType:(DFFigureType)figure
{
    if (self = [super init])
    {
        self.figure = figure;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //CGContextSetRGBFillColor(currentContext, 150,150,150,0.6);
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
    CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(currentContext, 70);
    CGContextAddLines(currentContext, arrayOfPoints, 3);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
}


-(void)drawRectangle:(CGContextRef)currentContext :(CGRect)rect
{
       CGContextBeginPath(currentContext);
    CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
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
    CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
    CGContextAddLines(currentContext, arrayOfPoints, 4);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
   
}

-(void)drawCircle:(CGContextRef)currentContext :(CGRect)rect
{
    CGContextSetRGBFillColor (currentContext, 3.0, 1.0, 0.0, 1.0);
    CGContextFillEllipseInRect (currentContext, rect);
    
    CGContextSetRGBStrokeColor (currentContext, 0.0, 0.0, 1.0, 1.0);
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
        CGContextSetRGBFillColor(currentContext,0.8,0.3,0.5,1);
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
        CGContextSetRGBFillColor(currentContext,0.7,0.4,0.5,1);
        CGContextAddLines(currentContext, arrayOfPoints, 4);
        CGContextClosePath(currentContext);
        CGContextFillPath(currentContext);
    }

-(void)drawSmile:(CGContextRef)currentContext :(CGRect)rect
{
    [self drawCircle:currentContext: rect];
    
    CGContextSetRGBStrokeColor(currentContext, 1.0, 0.8, 1.0, 1.0);
    CGContextSetRGBFillColor(currentContext, 0.8, 0.3, 0.3, 1.0);
    
    CGRect innerRect = CGRectInset (rect, rect.size.width*0.3, rect.size.height*0.3);
    
    CGContextAddArc(currentContext, innerRect.origin.x , innerRect.origin.y, innerRect.size.width/6, 0, M_PI *2, 0);
    CGContextMoveToPoint(currentContext, 240, 125);
    CGContextAddArc(currentContext, innerRect.size.width, innerRect.origin.y, innerRect.size.width/6, 0, M_PI *2, 0);
    CGContextFillPath(currentContext);

    
    CGContextMoveToPoint(currentContext, 100, 300);
    CGContextAddCurveToPoint(currentContext, 100, 250, 250, 275 ,275, 250);
    CGContextStrokePath(currentContext);

    }

-(void)drawSinus:(CGContextRef)currentContext :(CGRect)rect
{
    CGContextSetRGBStrokeColor(currentContext, 0.8, 0.3, 0.3, 1.0);
        int y;
        for(int x=rect.origin.x; x < rect.size.width; x++)
            {
                    y = ((rect.size.height/2) * sin(x/M_PI/4)) + 187;
                    if (x == 0)
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
    
    CGContextSetRGBFillColor(currentContext,0.7,0.4,0.5,1);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
    //CGContextDrawPath (currentContext, kCGPathFillStroke);
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

@end
