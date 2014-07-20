//
//  DetailViewController.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "DetailViewController.h"
#import "DescriptionViewController.h"
#import "AFNetworking.h"
#import "ProgramSvcAFNetworking.h"
#import "Program.h"

@interface DetailViewController ()
{
    NSMutableArray *courseTitleArray;
    ProgramSvcAFNetworking *pSvc;
}
@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) { }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize program service
    pSvc = [[ProgramSvcAFNetworking alloc]init];
    self.navbar.title = self.titleContents;
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
    
    // create delegate to listen for the event that fires when the data is loaded in the service
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateLeftTable"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkRes:) name:@"updateLeftTable" object:nil];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pSvc retrieveAllPrograms].count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    NSMutableArray *courses = [pSvc retrieveAllPrograms];
    cell.textLabel.text = ((Program *)[courses objectAtIndex:indexPath.row]).name;
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"courseSegue"]) {
        
        NSIndexPath *indexpath = nil;
        NSString *courseTitleString = nil;
        
        NSMutableArray *courses = [pSvc retrieveAllPrograms];
        indexpath = [_coursesTableView indexPathForSelectedRow];
        courseTitleString = ((Program *)[courses objectAtIndex:indexpath.row]).name;
        
        [[segue destinationViewController] setCourseTitleContents: courseTitleString];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//the event that fires when the data is loaded in the service (reloads table view)
-(void)checkRes:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"updateLeftTable"])
    {
        [_coursesTableView reloadData];
    }
}





@end
