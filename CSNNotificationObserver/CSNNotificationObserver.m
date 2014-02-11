//
//  CSNNotificationObserver.m
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import "CSNNotificationObserver.h"

@implementation CSNNotificationObserver

#pragma mark - Selector Support

- (instancetype)initWithObserver:(id)notificationObserver selector:(SEL)notificationSelector name:(NSString *)notificationName object:(id)notificationSender
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:notificationObserver selector:notificationSelector name:notificationName object:notificationSender];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addObserver:(id)notificationObserver selector:(SEL)notificationSelector name:(NSString *)notificationName object:(id)notificationSender
{
    [[NSNotificationCenter defaultCenter] addObserver:notificationObserver selector:notificationSelector name:notificationName object:notificationSender];
}

- (void)removeObserver:(id)notificationObserver name:(NSString *)notificationName object:(id)notificationSender
{
    [[NSNotificationCenter defaultCenter] removeObserver:notificationObserver name:notificationName object:notificationSender];
}

#pragma mark - Block Support

//- (instancetype)initWithName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *notification))block
//{
//
//}

//- (void)addObserverForName:(NSString *)name object:(id)obj queue:(NSOperationQueue *)queue usingBlock:(void (^)(NSNotification *notification))block
//{
//
//}

//- (void)removeObserverByName:(NSString *)name
//{
//
//}


@end
