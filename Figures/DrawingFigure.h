//
//  DrawingFigure.h
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingFigure : UIView

typedef NS_ENUM(NSInteger, DFFigureType)
{
    DFFigureTypeTriangular,
    DFFigureTypeCircle,
    DFFigureTypeSquare,
    DFFigureTypeRhomb,
    DFFigureTypeHexagon,
    DFFigureTypeTrapezoid,
    DFFigureTypeSinus,
    DFFigureTypeSmile,
    DFFigureTypeNAngles,
    DFFigureTypeBomb,
    DFFigureTypeCount
};

typedef NS_ENUM(NSInteger, DFFillingColor)
{
    DFColorRed,
    DFColorGreen,
    DFColorPink,
    DFColorYellow,
    DFColorBlue,
    DFColorBlack,
    DFColorViolet,
    DFColorCount    
};

@property (assign, nonatomic) enum DFFigureType figure;
@property (assign, nonatomic) enum DFFillingColor color;
@property (nonatomic, assign) CGPoint vector;

- (DrawingFigure*)initWithType:(DFFigureType)figureType :(DFFillingColor)color;

@end
