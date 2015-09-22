//
//  TableViewController.m
//  Figures
//
//  Created by Administrator on 9/18/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "FigureController.h"

extern NSString *globalKey;

@interface TableViewController ()

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSMutableArray *scores;
@property (nonatomic, strong) NSDictionary *map;

@end

@implementation TableViewController

@synthesize map = _map;
@synthesize names = _names;
@synthesize scores = _scores;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.map = [[NSUserDefaults standardUserDefaults] objectForKey:globalKey];
    if (self.map == nil)
    {
        self.map = [[NSDictionary alloc] init];
    }
    else
    {
        self.scores = [[NSMutableArray alloc] init];
        
        self.names = [self.map keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 doubleValue] > [obj2 doubleValue]) {
                
                return (NSComparisonResult)NSOrderedAscending;
            }
            if ([obj1 doubleValue] < [obj2 doubleValue]) {
                
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        for (NSString* name in self.names)
        {
            [self.scores addObject:[self.map objectForKey:name ]];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.map count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {

     UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
     
     [cell.textLabel setText:[self.names objectAtIndex:indexPath.row]];
     [cell.detailTextLabel setText:[self.scores objectAtIndex:indexPath.row]];
     return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
