//
//  CSNNotificationObserverDemoTests.m
//  CSNNotificationObserverDemoTests
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "CSNNotificationObserver.h"

static NSString * const kTestNotificationName = @"testNotification";

@interface SampleObserver : NSObject

@end

@implementation SampleObserver
- (void)receiveNotification:(NSNotification *)notification
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
}
@end

@interface CSNNotificationObserverDemoTests : XCTestCase
@property (nonatomic ,strong) SampleObserver *sampleObserver;
@end

@implementation CSNNotificationObserverDemoTests

- (void)setUp
{
    [super setUp];
    self.sampleObserver = [[SampleObserver alloc] init];
}

- (void)tearDown
{
    self.sampleObserver = nil;
    [super tearDown];
}

- (void)testRemoveObserverSelectorStyleWhenDeallocated
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithObserver:self.sampleObserver selector:@selector(receiveNotification:) name:kTestNotificationName object:nil];
    
    id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];

    [[mock expect] removeObserver:self.sampleObserver];
  
    observer = nil;
    
    [mock verify];
}

- (void)testRemoveObserverBlockStyleWhenDeallocated
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithName:kTestNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
    }];
    
    id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
    
    NSMutableDictionary *mappingDictionary = [observer valueForKey:@"mappingDictionary"];
    for (id observer in [mappingDictionary allValues]) {
        [[mock expect] removeObserver:observer];
    }
    
    observer = nil;
    
    [mock verify];
}

- (void)testRemoveObserverNameObject
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithObserver:self.sampleObserver selector:@selector(receiveNotification:) name:kTestNotificationName object:nil];
    
    id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];
    [[mock expect] removeObserver:self.sampleObserver name:kTestNotificationName object:nil];

    [observer removeObserver:self.sampleObserver name:kTestNotificationName object:nil];
    
    [mock verify];
}

- (void)testRemoveObserver
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithName:kTestNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
    }];

    id mock = [OCMockObject partialMockForObject:[NSNotificationCenter defaultCenter]];

    NSMutableDictionary *mappingDictionary = [observer valueForKey:@"mappingDictionary"];
    for (NSString *key in [mappingDictionary allKeys]) {
        if ([key isEqualToString:kTestNotificationName]) {
            [[mock expect] removeObserver:[mappingDictionary objectForKey:key]];
        }
    }

    [observer removeObserverByName:kTestNotificationName];
    
    [mock verify];
}

- (void)testInternalConditionMappingHashTable
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithObserver:self.sampleObserver selector:@selector(receiveNotification:) name:kTestNotificationName object:nil];

    NSHashTable *hashTable = [observer valueForKey:@"mappingHashTable"];
    XCTAssertEqual([hashTable count], (NSUInteger)1, @"hashTable Count shold be 1 right after addObserver");

    [observer removeObserver:self.sampleObserver name:kTestNotificationName object:nil];

    hashTable = [observer valueForKey:@"mappingHashTable"];
    XCTAssertEqual([hashTable count], (NSUInteger)0, @"hashTable Count shold be 0 right after removeObserver");
}

- (void)testInternalConditionMappingDictionary
{
    CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithName:kTestNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
    }];

    NSMutableDictionary *mappingDictionary = [observer valueForKey:@"mappingDictionary"];
    XCTAssertEqual([mappingDictionary count], (NSUInteger)1, @"hashTable Count shold be 1 right after addObserver");

    [observer removeObserverByName:kTestNotificationName];
    
    mappingDictionary = [observer valueForKey:@"mappingDictionary"];
    XCTAssertEqual([mappingDictionary count], (NSUInteger)0, @"hashTable Count shold be 0 right after removeObserver");
}

- (void)testReceiveNotificationSelectorStyle
{
    __unused CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithObserver:self.sampleObserver selector:@selector(receiveNotification:) name:kTestNotificationName object:nil];
    
    NSNotification *notification = [NSNotification notificationWithName:kTestNotificationName object:nil];
    id mock = [OCMockObject partialMockForObject:self.sampleObserver];
    [[mock expect] receiveNotification:notification];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [mock verify];
}

- (void)testReceiveNotificationBlockStyle
{
    __unused CSNNotificationObserver *observer = [[CSNNotificationObserver alloc] initWithName:kTestNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
        XCTAssertNotNil(notification, @"notification should not be nil");
        XCTAssertEqualObjects(notification.name, kTestNotificationName, @"notification name should be equal %@", kTestNotificationName);
    }];
    
    NSNotification *notification = [NSNotification notificationWithName:kTestNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
