//
//  ViewControllerWithScore.h
//  Figures
//
//  Created by Administrator on 9/18/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerWithScore : UIViewController


@property (strong, nonatomic) NSString* stringWithScore;

- (void) showScore: (NSString*) score;

@end
