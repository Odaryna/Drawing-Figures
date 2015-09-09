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
    DFFigureTypeCount
};

@property (assign, nonatomic) enum DFFigureType figure;

- (DrawingFigure*) initWithType:(DFFigureType)figureType;

@end
