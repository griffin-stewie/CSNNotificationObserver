//
//  CSNNotificationObserver.h
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSNNotificationObserver : NSObject


#pragma mark - Selector Support

- (instancetype)initWithObserver:(id)notificationObserver
                        selector:(SEL)notificationSelector
                            name:(NSString *)notificationName
                          object:(id)notificationSender;

- (void)addObserver:(id)notificationObserver
           selector:(SEL)notificationSelector
               name:(NSString *)notificationName
             object:(id)notificationSender;

- (void)removeObserver:(id)notificationObserver
                  name:(NSString *)notificationName
                object:(id)notificationSender;


#pragma mark - Block Support

- (instancetype)initWithName:(NSString *)name
                      object:(id)notificationSender
                       queue:(NSOperationQueue *)queue
                  usingBlock:(void (^)(NSNotification *notification))block;

- (void)addObserverForName:(NSString *)name
                    object:(id)notificationSender
                     queue:(NSOperationQueue *)queue
                usingBlock:(void (^)(NSNotification *notification))block;

- (void)removeObserverByName:(NSString *)name;

@end
