//
//  FigureController.h
//  Figures
//
//  Created by Administrator on 9/11/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingFigure.h"
#import "ViewControllerWithScore.h"

@interface FigureController : UIViewController
@property (nonatomic, strong) NSString *scoreString;
@property (nonatomic, strong) NSString *nameOfThePlayer;
@end
