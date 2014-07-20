//
//  Program.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/19/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "Program.h"

@implementation Program

-(NSString *) description
{
    return [NSString stringWithFormat:@"Program: id=%d, name=%@", self.Id, self.name];
}

@end
