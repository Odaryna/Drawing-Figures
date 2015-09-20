//
//  ViewControllerWithScore.m
//  Figures
//
//  Created by Administrator on 9/19/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//


#import "ViewControllerWithScore.h"
#import "TableViewController.h"
#import "ViewController.h"

@interface ViewControllerWithScore ()

@end

@implementation ViewControllerWithScore

@synthesize scoreLabel;
@synthesize stringWithScore = _stringWithScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    scoreLabel.text = self.stringWithScore;
    self.stringWithScore = @"";

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showScore: (NSString*) score
{
    scoreLabel.text = score;
    self.stringWithScore = score;
    
    TableViewController* table = [[TableViewController alloc] init];
    ViewController* firstView = [[ViewController alloc] init];
    
    [table.map setObject:self.stringWithScore forKey:firstView.nameOfThePlayer];

}


@end
