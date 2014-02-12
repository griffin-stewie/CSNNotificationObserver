//
//  CSNNotificationObserver.m
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import "CSNNotificationObserver.h"

@interface CSNNotificationObserver ( )
@property (nonatomic, strong) NSMutableDictionary *mappingDictionary;
@property (nonatomic, strong) NSNotificationCenter *notificationCenter;
@end

@implementation CSNNotificationObserver

- (instancetype)init
{
    self = [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    if (self) {

    }
    
    return self;
}

- (instancetype)initWithNotificationCenter:(NSNotificationCenter *)notificationCenter
{
    self = [super init];
    if (self) {
        self.mappingDictionary = [NSMutableDictionary dictionary];
        self.notificationCenter = notificationCenter;
    }

    return self;
}


#pragma mark - Selector Support

- (instancetype)initWithObserver:(id)notificationObserver
                        selector:(SEL)notificationSelector
                            name:(NSString *)notificationName
                          object:(id)notificationSender
{
    self = [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    if (self) {
        [self addObserver:notificationObserver selector:notificationSelector name:notificationName object:notificationSender];
    }
    
    return self;
}

- (void)dealloc
{
    [self.notificationCenter removeObserver:self];
    
    for (id observer in [self.mappingDictionary allValues]) {
        [self.notificationCenter removeObserver:observer];
    }
}

- (void)addObserver:(id)notificationObserver
           selector:(SEL)notificationSelector
               name:(NSString *)notificationName
             object:(id)notificationSender
{
    [self.notificationCenter addObserver:notificationObserver selector:notificationSelector name:notificationName object:notificationSender];
}

- (void)removeObserver:(id)notificationObserver
                  name:(NSString *)notificationName
                object:(id)notificationSender
{
    [self.notificationCenter removeObserver:notificationObserver name:notificationName object:notificationSender];
}


#pragma mark - Block Support

- (instancetype)initWithName:(NSString *)name
                      object:(id)notificationSender
                       queue:(NSOperationQueue *)queue
                  usingBlock:(void (^)(NSNotification *notification))block
{
    self = [self initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    if (self) {
        [self addObserverForName:name object:notificationSender queue:queue usingBlock:block];
    }

    return self;
}

- (void)addObserverForName:(NSString *)name
                    object:(id)notificationSender
                     queue:(NSOperationQueue *)queue
                usingBlock:(void (^)(NSNotification *notification))block
{
    id <NSCopying> key = [self keyByName:name];
    if (key) {
        [self removeObserverByName:name];
    }
    
    id observer = [self.notificationCenter addObserverForName:name object:notificationSender queue:queue usingBlock:block];
    [self.mappingDictionary setObject:observer forKey:[self keyByName:name]];
}

- (void)removeObserverByName:(NSString *)name
{
    id <NSCopying> key = [self keyByName:name];
    id observer = [self.mappingDictionary objectForKey:key];
    [self.mappingDictionary removeObjectForKey:key];
    [self.notificationCenter removeObserver:observer];
}


#pragma mark - Internal

- (id <NSCopying>)keyByName:(NSString *)name
{
    return [name length] ? name : [NSNull null];
}
@end
