//
//  ProgramSvcAFNetworking.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/19/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import "ProgramSvcAFNetworking.h"
#import "AFNetworking.h"

@implementation ProgramSvcAFNetworking

static NSString * const BaseURLString = @"http://regisscis.net/Regis2/webresources/regis2.program";
NSMutableArray *_allPrograms;

//Use AFNetworking to make a GET call to the REST service
//Set Accept header to request JSON from the REST service
- (void) initializeData
{
    
    _allPrograms = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager GET:BaseURLString parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             //this doesnt fire until we get a successful response from the service
             [self parseData:responseObject];
             
             //which is why we publish an event when the data comes back
             //so we can notify the tableview to reload and use the data from the service
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateLeftTable" object:self];
             NSLog(@"JSON: %@", responseObject);
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Request Failed ... Error: %@", error);
         }];
    
}

-(id)init
{
    if(self){

        [self initializeData];
        return self;
    }
    return nil;
}

-(Program *)createProgram:(Program *)program
{
    [_allPrograms addObject:program];
    return program;
}

-(NSMutableArray *) retrieveAllPrograms
{
    return _allPrograms;
}

-(Program *)updateProgram:(Program *)program
{
    [self deleteProgram:program];
    return [self createProgram:program];
}

-(Program *)deleteProgram:(Program *)program
{
    [_allPrograms removeObject:program];
    return program;
}

- (void) parseData: (NSMutableArray *) dataObject
{
 
    // build program objects from REST service and add to list
    for (int i=0; i< dataObject.count; i++) {
        NSDictionary *pgm = dataObject[i];
        for (id key in pgm) {
            if([key  isEqual: @"name"]) {
                id value = [pgm objectForKey:key];
                Program *program = [[Program alloc]init];
                program.Id = i+1;
                program.name = value;
                [self createProgram:program];
            }
        }
    }
    
}

@end
