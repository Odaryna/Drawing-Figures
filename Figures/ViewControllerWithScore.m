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
#import "FigureController.h"
#import "StoringFiles.h"


NSString* globalKey = @"leader";

@interface ViewControllerWithScore ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,strong) StoringFiles *files;

- (IBAction)restartTheGame;
- (IBAction)startTheGame;
- (void)workWithDictionary;

@end

@implementation ViewControllerWithScore

@synthesize scoreLabel;
@synthesize stringWithScore = _stringWithScore;
@synthesize files = _files;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.scoreLabel.text = self.stringWithScore;
    self.files = [StoringFiles SharedInstance];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showScore:(NSString*)score
{
    self.stringWithScore = score;
}


- (IBAction)restartTheGame
{

    [self workWithDictionary];
    [self performSegueWithIdentifier:@"restartTheGame" sender:self];
    
}

- (IBAction)startTheGame
{
    [self workWithDictionary];
    [self performSegueWithIdentifier:@"startTheGame" sender:self];
}

- (void)workWithDictionary
{
    NSDictionary *result = [[NSUserDefaults standardUserDefaults] objectForKey:globalKey];
    if (result == nil)
    {
        result = [[NSDictionary alloc] init];
    }
    
    NSMutableDictionary *mDict = [result mutableCopy];
    
    NSString *score = self.scoreLabel.text;
    if (!score || score.length == 0)
    {
        return;
    }
    
    if (!self.nameOfThePlayer.length) self.nameOfThePlayer = self.files.nameOfThePlayer;
    
    if (!self.nameOfThePlayer.length) self.nameOfThePlayer = @"<noname>";
    
    NSString* scoreOfCurrent = @"";
    
    if ([mDict objectForKey: self.nameOfThePlayer ])
    {
        scoreOfCurrent = [mDict objectForKey: self.nameOfThePlayer ];
        if ([scoreOfCurrent doubleValue] < [score doubleValue])
        {
            [mDict setObject:score forKey:self.nameOfThePlayer];
        }
    }
    else
    {
        [mDict setObject:score forKey:self.nameOfThePlayer];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:mDict forKey:globalKey];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"restartTheGame"])
    {
        FigureController *viewController = (FigureController*)segue.destinationViewController;
    }
    else if ([segue.identifier isEqualToString:@"startTheGame"])
        {
            ViewController *viewController = (ViewController*)segue.destinationViewController;
        }
}
@end
