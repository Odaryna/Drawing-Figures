//
//  ViewControllerWithScore.m
//  Figures
//
//  Created by Administrator on 9/18/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "FigureController.h"
#import "ViewControllerWithScore.h"

@interface ViewControllerWithScore ()

@end

@implementation ViewControllerWithScore

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) showScore
{
    self.scoreLabel.text = [self.scoreLabel.text stringByAppendingString: [FigureController keepScore]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
