//
//  DrawingFigure.h
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingFigure : UIView

typedef NS_ENUM(NSInteger, FigureType)
{triangular, circle, square, rhomb, hexagon, oval, trapezoid, sinus, smile, n_angles} ;

@property (assign, nonatomic) enum FigureType figure;
@property (nonatomic) NSInteger CountOfAngles;


- (DrawingFigure*) initWithType:(NSInteger) fig;
- (DrawingFigure*) initWithType:(NSInteger) fig number:(NSInteger) angles;
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
