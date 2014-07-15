//
//  DescriptionViewController.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navbarDesc.title = self.courseTitleContents;
    // Do any additional setup after loading the view.
}

-(IBAction)registerCourse:(id)sender
{
    NSLog(@"%@ Registered", self.courseTitleContents);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
