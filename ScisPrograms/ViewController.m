//
//  ViewController.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()
{
    NSMutableArray *titleArray;
    NSMutableArray *subtitleArray;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.programsTableView.delegate = self;
    self.programsTableView.dataSource = self;
    
    titleArray = [[NSMutableArray alloc]initWithObjects:@"SCIS", nil];
    subtitleArray = [[NSMutableArray alloc]initWithObjects:@"View List of Programs", nil];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [subtitleArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        NSIndexPath *indexpath = nil;
        NSString *titlestring = nil;
        NSString *subtitlestring = nil;
        
        indexpath = [_programsTableView indexPathForSelectedRow];
        titlestring = [titleArray objectAtIndex:indexpath.row];
        subtitlestring = [subtitleArray objectAtIndex:indexpath.row];
        
        [[segue destinationViewController] setTitleContents: titlestring];
        [[segue destinationViewController] setSubtitleContents: subtitlestring];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
