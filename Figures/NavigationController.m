//
//  NavigationController.m
//  Figures
//
//  Created by Administrator on 9/17/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "NavigationController.h"
#import "TableViewController.h"


@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    TableViewController* table = [[TableViewController alloc] init];
    table.map = [[NSMutableDictionary alloc] init];

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
