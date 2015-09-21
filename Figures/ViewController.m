//
//  ViewController.m
//  Figures
//
//  Created by Administrator on 9/7/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "DrawingFigure.h"
#import "FigureController.h"




@interface ViewController ()

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@property (nonatomic,strong) UIAlertView *alertView;

- (IBAction)startButton;

@end

@implementation ViewController

@synthesize alertView = _alertView;
@synthesize nameOfThePlayer = _nameOfThePlayer;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Getting started!" message:@"Enter your name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton
{
    [ self.alertView show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1){
        self.nameOfThePlayer = [alertView textFieldAtIndex:0].text;
        [self performSegueWithIdentifier:@"gettingStarted" sender:self];
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gettingStarted"])
    {
        FigureController *viewController = (FigureController*)segue.destinationViewController;
        viewController.nameOfThePlayer = self.nameOfThePlayer;
    }
}
@end
