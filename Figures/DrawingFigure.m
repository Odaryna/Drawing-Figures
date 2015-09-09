//
//  DrawingFigure.m
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "DrawingFigure.h"

@implementation DrawingFigure

- (void)drawRect:(CGRect)rect
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 150,150,150,0.7);
    CGContextFillRect(currentContext, CGRectMake(0, 0, 375, 375));
    [self figureCheck:self :currentContext :rect];
}

- (DrawingFigure*) initWithType:(NSInteger) fig
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 375, 375)])
    {
        self.figure = fig;
    }
    return self;
}

- (DrawingFigure*) initWithType:(NSInteger) fig number:(NSInteger) angles
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 375, 375)])
    {
        self.figure = fig;
        self.CountOfAngles = angles;
    }
    return self;
}

-(void)setBackground:(CGContextRef) currentContext
{
    CGContextSetRGBFillColor(currentContext, 150,150,150,0.7);
    CGContextFillRect(currentContext, CGRectMake(0, 0, 375, 375));
}

-(void)drawTriangle:(CGContextRef)currentContext :(CGRect)rect
{
     CGRect innerRect = CGRectInset (self.bounds, 1, 1);
    
    CGPoint arrayOfPoints[3] =
    {
        CGPointMake(0, innerRect.size.height),
        CGPointMake(innerRect.size.width, innerRect.size.height),
        CGPointMake(innerRect.size.width/2, 0)
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
     CGRect innerRect = CGRectInset (self.bounds, 20, 20);
    
    CGContextBeginPath(currentContext);
    CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
    CGContextAddRect(currentContext, innerRect);
    CGContextFillPath(currentContext);
}

-(void)drawRhomb:(CGContextRef)currentContext :(CGRect)rect
{
    CGRect innerRect = CGRectInset (self.bounds, 2, 2);
    
    CGPoint arrayOfPoints[4] =
    {
        CGPointMake(innerRect.size.width/2, 0),
        CGPointMake(innerRect.size.width, innerRect.size.height/2),
        CGPointMake(innerRect.size.width/2, innerRect.size.height),
        CGPointMake(0, innerRect.size.height/2)
    };
    
    CGContextBeginPath(currentContext);
    CGContextSetRGBFillColor (currentContext, 0.0, 1.0, 0.0, 1.0);
    CGContextAddLines(currentContext, arrayOfPoints, 4);
    CGContextClosePath(currentContext);
    CGContextFillPath(currentContext);
   
}

-(void)drawCircle:(CGContextRef)currentContext :(CGRect)rect
{
    CGRect innerRect = CGRectInset (self.bounds, 1, 1);
    
    CGContextSetRGBFillColor (currentContext, 3.0, 1.0, 0.0, 1.0);
    CGContextFillEllipseInRect (currentContext, innerRect);
    
    CGContextSetRGBStrokeColor (currentContext, 0.0, 0.0, 1.0, 1.0);
    CGContextSetLineWidth (currentContext, 3.0);
    CGContextStrokeEllipseInRect (currentContext, innerRect);
}

-(void)drawHexagon:(CGContextRef)currentContext :(CGRect)rect
{
    CGRect innerRect = CGRectInset (self.bounds, 2, 2);
    
    CGPoint arrayOfPoints[6] = { CGPointMake(60, 0),
                                         CGPointMake(innerRect.size.width-60, 0),
                                         CGPointMake(innerRect.size.width, innerRect.size.height/2),
                                         CGPointMake(innerRect.size.width-60, innerRect.size.height),
                                         CGPointMake(60, innerRect.size.height),
                                         CGPointMake(0,innerRect.size.height/2)};
        CGContextBeginPath(currentContext);
        CGContextSetRGBFillColor(currentContext,0.8,0.3,0.5,1);
        CGContextAddLines(currentContext, arrayOfPoints, 6);
        CGContextClosePath(currentContext);
        CGContextFillPath(currentContext);
    }

-(void)drawTrapezoid:(CGContextRef)currentContext :(CGRect)rect
{
        CGRect innerRect = CGRectInset (self.bounds,2, 2);
    
        CGPoint arrayOfPoints[4] = { CGPointMake(80, 0),
                                         CGPointMake(innerRect.size.width-80, 0),
                                         CGPointMake(innerRect.size.width, innerRect.size.height),
                                         CGPointMake(0 ,innerRect.size.height)};
        CGContextBeginPath(currentContext);
        CGContextSetRGBFillColor(currentContext,0.8,0.3,0.5,1);
        CGContextAddLines(currentContext, arrayOfPoints, 4);
        CGContextClosePath(currentContext);
        CGContextFillPath(currentContext);
    }

-(void)drawSmile:(CGContextRef)currentContext :(CGRect)rect
{
        [self drawCircle:currentContext: rect];
    
    CGContextBeginPath(currentContext);
    CGContextAddArc(currentContext, 130, 125, 15, 0, 130, 0);
    CGContextSetRGBFillColor(currentContext, 0.8, 0.3, 0.3, 1.0);
    CGContextFillPath(currentContext);
    CGContextAddArc(currentContext, 240, 125, 15, 0, 130, 0);
    CGContextSetRGBFillColor(currentContext, 0.8, 0.3, 0.3, 1.0);
    CGContextFillPath(currentContext);
    CGContextSetRGBStrokeColor(currentContext, 0.8, 0.8, 0.3, 1.0);
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
                    y = ((rect.size.height/2) * sin(((x*4) % 360) * M_PI/180)) + 187;
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
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / count;
    float interiorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5*interiorAngle);
    
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
    [[UIColor clearColor] setFill];
    [[UIColor blackColor] setStroke];
    CGContextDrawPath (currentContext, kCGPathFillStroke);
}


-(void)figureCheck: (DrawingFigure*) draw :(CGContextRef)currentContext :(CGRect)rect ;
{
       switch(draw.figure)
       {
                    case 0:
                        [self drawTriangle:currentContext :rect];
                        break;
                    case 1:
                        [self drawRectangle:currentContext :rect];
                        break;
                    case 2:
                        [self drawRhomb:currentContext :rect];
                        break;
                    case 3:
                        [self drawCircle:currentContext :rect];
                        break;
                    case 4:
                        [self drawHexagon:currentContext :rect];
                        break;
                    case 5:
                        [self drawTrapezoid:currentContext :rect];
                        break;
                    case 6:
                        [self drawSinus:currentContext :rect];
                       break;
                    case 7:
                        [self drawSmile:currentContext :rect];
                        break;
                    case 8:
                        [self drawNAngles:currentContext :rect :self.CountOfAngles];
                        break;
                    case 9:
                        break;
            }
    }



@end
