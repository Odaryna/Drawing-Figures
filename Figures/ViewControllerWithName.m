//
//  ViewControllerWithName.m
//  Figures
//
//  Created by Administrator on 9/17/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ViewControllerWithName.h"

@interface ViewControllerWithName ()

- (IBAction)ClearText;

@property (weak, nonatomic) IBOutlet UITextField *nameOfTheGamer;
@property (nonatomic,strong) NSString* currentName;
@end

@implementation ViewControllerWithName

@synthesize nameOfTheGamer = _nameOfTheGamer;
@synthesize currentName = _currentName;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ClearText {
    
    self.nameOfTheGamer.text = @"";
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
