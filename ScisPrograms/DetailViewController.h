//
//  DetailViewController.h
//  ScisPrograms
//
//  Created by Daniel Jones on 7/6/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *coursesTableView;

@property (weak, nonatomic) IBOutlet UINavigationItem *navbar;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (strong, nonatomic) NSString *titleContents;
@property (strong, nonatomic) NSString *subtitleContents;

@end
