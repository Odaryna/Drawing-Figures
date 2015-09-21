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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewControllerWithScore

@synthesize scoreLabel;
@synthesize stringWithScore = _stringWithScore;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scoreLabel.text = self.stringWithScore;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showScore:(NSString*)score
{
    self.stringWithScore = score;
}


@end
