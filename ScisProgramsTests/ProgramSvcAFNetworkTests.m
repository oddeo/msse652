//
//  ProgramSvcAFNetworkTests.m
//  ScisPrograms
//
//  Created by Daniel Jones on 7/19/14.
//  Copyright (c) 2014 regis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Program.h"
#import "ProgramSvcAFNetworking.h"

@interface ProgramSvcAFNetworkTests : XCTestCase

@end

@implementation ProgramSvcAFNetworkTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProgramSvcAFNetworkingImplementsProgramSvcProtocal
{
    XCTAssertTrue([ProgramSvcAFNetworking conformsToProtocol:@protocol(ProgramSvc)]
                  , @"ProgramSvcAFNetworking must conform to the ProgramSvc protocol");
}

-(void)testProgramSvcCanCreateProgram
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
    
    XCTAssertTrue([[pSvc createProgram: newProgram] isMemberOfClass: [Program class]],
                   @"createProgram should return an object of type Program");
}

-(void)testProgramSvcCanRetrieveAllPrograms
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
    Program *p = [pSvc createProgram: newProgram]; p = nil;

    XCTAssertTrue([pSvc retrieveAllPrograms].count == 1, @"Count should be 1");
}

-(void)testProgramSvcRetrievesListOfPrograms
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
    Program *p = [pSvc createProgram: newProgram]; p = nil;
    
    XCTAssertTrue([[[pSvc retrieveAllPrograms]
                   objectAtIndex:0]
                    isMemberOfClass: [Program class]], @"Should return object of type Program");
}

-(void)testProgramSvcCanUpdateProgram
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
      [newProgram setName:@"New Program"];
    
    Program *sameProgram = [pSvc createProgram: newProgram];
    NSString *newName = @"Name changed";
      [sameProgram setName:newName];
    
    XCTAssertEqual(newName, [pSvc updateProgram:sameProgram].name,
                   @"Names should both be %@", newName);
}

-(void)testProgramSvcUpdateDoesNotChangeProgramsCount
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
    [newProgram setName:@"New Program"];
    
    Program *sameProgram = [pSvc createProgram: newProgram];
    int originalCount = [pSvc retrieveAllPrograms].count;
    
    NSString *newName = @"Name changed";
    [sameProgram setName:newName];
    [pSvc updateProgram:sameProgram];
    int afterUpdateCount = [pSvc retrieveAllPrograms].count;
    
    XCTAssertEqual(originalCount, afterUpdateCount,
                   @"Count should remain the same after update %d : %d", originalCount, afterUpdateCount);
}

-(void)testProgramSvcCanDeleteProgram
{
    ProgramSvcAFNetworking *pSvc = [[ProgramSvcAFNetworking alloc] init];
    Program *newProgram = [[Program alloc]init];
    Program *sameProgram = [pSvc createProgram: newProgram];
    int originalCount = [pSvc retrieveAllPrograms].count;
    Program *deletedProgram = [pSvc deleteProgram:sameProgram]; deletedProgram = nil;
    int afterDeleteCount = [pSvc retrieveAllPrograms].count;
    
    XCTAssertNotEqual(originalCount, afterDeleteCount,
                   @"Count should decrement after delete %d : %d", originalCount, afterDeleteCount);
}

@end
