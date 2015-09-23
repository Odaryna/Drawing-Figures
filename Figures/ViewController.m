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
#import "StoringFiles.h"




@interface ViewController ()

@property (nonatomic,strong) UIAlertView *alertView;
@property (nonatomic,strong) StoringFiles *files;

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (IBAction)startButton;

@end

@implementation ViewController

@synthesize alertView = _alertView;
@synthesize nameOfThePlayer = _nameOfThePlayer;
@synthesize files = _files;

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"sky-home.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];

    
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Getting started!" message:@"Enter your name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    self.files = [StoringFiles SharedInstance];
   
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
        self.files.nameOfThePlayer = self.nameOfThePlayer;
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
