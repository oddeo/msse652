//
//  DetailViewController.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "DetailViewController.h"
#import "DescriptionViewController.h"

//week 3 test
@interface DetailViewController ()
{
    NSMutableArray *courseTitleArray;
    NSArray *_jsonArray;
    NSMutableData *_responseData;
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

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil; //returning nil indicates caching the response is not needed
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    // populate a json array and delegate the parse task to the parseData helper method
    NSError *error = nil;
    _jsonArray = [NSJSONSerialization JSONObjectWithData:_responseData
                                                 options:kNilOptions
                                                   error:&error];
    [self parseData];
    self.navbar.title = self.titleContents;
    [_coursesTableView reloadData];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeData];
    self.coursesTableView.delegate = self;
    self.coursesTableView.dataSource = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [courseTitleArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CourseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    
    cell.textLabel.text = [courseTitleArray objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"courseSegue"]) {
        
        NSIndexPath *indexpath = nil;
        NSString *courseTitleString = nil;
        
        indexpath = [_coursesTableView indexPathForSelectedRow];
        courseTitleString = [courseTitleArray objectAtIndex:indexpath.row];
        
        [[segue destinationViewController] setCourseTitleContents: courseTitleString];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper Methods ****************
- (void) initializeData
{
    
    NSURL *url = [NSURL URLWithString:@"http://regisscis.net/Regis2/webresources/regis2.program"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json"
   forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request
                                                            delegate:self];
    NSLog(@"Connected to: %@", conn);
    
}

- (void) parseData
{
    
  // populate the array that feeds the table view
  courseTitleArray = [NSMutableArray array];
    
  for (int i=0; i<_jsonArray.count; i++) {
    NSDictionary *pgm = _jsonArray[i];
    for (id key in pgm) {
      if([key  isEqual: @"name"]) {
        id value = [pgm objectForKey:key];
        [courseTitleArray addObject: value];
      }
    }
  }
    
}



@end
