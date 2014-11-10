//
//  EmployeesTableViewController.m
//  POCEmployeeDetail
//
//  Created by Suresh on 03/11/14.
//  Copyright (c) 2014 Neev. All rights reserved.
//

#import "EmployeesTableViewController.h"
#import "DataManager.h"
#import "Employee.h"
#import "ViewController.h"
#import <CoreData/CoreData.h>

@interface EmployeesTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *companyDetails;
@end

@implementation EmployeesTableViewController
@synthesize employees = _employees;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
       self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
        self.navigationController.navigationBar.hidden = NO;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employees"];
    self.employees = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.employees count];
}


#pragma mark - Table view delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"employeeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"employeeCellIdentifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Employee *employee = [self.employees objectAtIndex:indexPath.row];
    cell.textLabel.text = [employee valueForKey:@"empFirstName"];
    cell.detailTextLabel.text = [employee valueForKey:@"empAddress"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:@"viewController"];

    viewController.employeeEntryIndex = [indexPath row];
    viewController.isForAddingNewEmployee = NO;
    viewController.employeeData = [self.employees objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *viewController = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"addNewEmployee"])
        viewController.isForAddingNewEmployee = YES;
    
}


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end
