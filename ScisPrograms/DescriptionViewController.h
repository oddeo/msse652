//
//  DescriptionViewController.h
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navbarDesc;
@property (weak, nonatomic) IBOutlet UILabel *courseTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseSubtitleLabel;

@property (strong, nonatomic) NSString *courseTitleContents;
@property (strong, nonatomic) NSString *courseSubtitleContents;

- (IBAction)registerCourse:(id)sender;

@end
