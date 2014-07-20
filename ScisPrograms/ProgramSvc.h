//
//  ProgramSvc.h
//  ScisPrograms
//
//  Created by Daniel Jones on 7/19/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"

@protocol ProgramSvc <NSObject>

-(Program *) createProgram: (Program *) program;
-(NSMutableArray *) retrieveAllPrograms;
-(Program *) updateProgram: (Program *) program;
-(Program *) deleteProgram: (Program *) program;

@end
