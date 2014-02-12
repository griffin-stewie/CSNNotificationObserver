//
//  CSNNotificationObserver.h
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Observer for NSNotification
 */
@interface CSNNotificationObserver : NSObject


#pragma mark - Selector Support

/**
 Initialize and add observer selector style
 
 @param notificationObserver same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationSelector same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationName     same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationSender   same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 
 @return Initialized instance of CSNNotificationObserver.
 */
- (instancetype)initWithObserver:(id)notificationObserver
                        selector:(SEL)notificationSelector
                            name:(NSString *)notificationName
                          object:(id)notificationSender;

/**
 Adds an entry to the NSNotificationCenter's dispatch table with an observer, a notification selector and optional criteria: notification name and sender.
 
 @param notificationObserver same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationSelector same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationName     same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 @param notificationSender   same as `addObserver:selector:name:object:` of `NSNotificationCenter`
 */
- (void)addObserver:(id)notificationObserver
           selector:(SEL)notificationSelector
               name:(NSString *)notificationName
             object:(id)notificationSender;

/**
 Removes matching entries from the NSNotificationCenter's dispatch table.
 
 @param notificationObserver same as `removeObserver:name:object:` of `NSNotificationCenter`
 @param notificationName     same as `removeObserver:name:object:` of `NSNotificationCenter`
 @param notificationSender   same as `removeObserver:name:object:` of `NSNotificationCenter`
 */
- (void)removeObserver:(id)notificationObserver
                  name:(NSString *)notificationName
                object:(id)notificationSender;


#pragma mark - Block Support

/**
  Initialize and add observer block style
 
 @param notificationName   same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param notificationSender same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param queue              same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param block              same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 
 @return Initialized instance of CSNNotificationObserver.
 */
- (instancetype)initWithName:(NSString *)notificationName
                      object:(id)notificationSender
                       queue:(NSOperationQueue *)queue
                  usingBlock:(void (^)(NSNotification *notification))block;

/**
 Adds an entry to the NSNotificationCenter's dispatch table with a notification queue and a block to add to the queue, and optional criteria: notification name and sender.
 
 If you add observer for same name, remove previous observer first.
 
 @param notificationName   same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param notificationSender same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param queue              same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 @param block              same as `addObserverForName:object:queue:usingBlock:` of `NSNotificationCenter`
 */
- (void)addObserverForName:(NSString *)notificationName
                    object:(id)notificationSender
                     queue:(NSOperationQueue *)queue
                usingBlock:(void (^)(NSNotification *notification))block;

/**
 Remove observer by name.
 
 @param notificationName notification name
 */
- (void)removeObserverByName:(NSString *)notificationName;

@end
