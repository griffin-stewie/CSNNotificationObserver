//
//  DetailViewController.m
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import "DetailViewController.h"
#import "CSNNotificationObserver.h"

static NSString * const kTestNotificationName = @"UIApplicationWillChangeStatusBarFrameNotification";

@interface DetailViewController ()
@property (nonatomic, strong) CSNNotificationObserver *notificationObserver;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CSNNotificationObserver *)notificationObserver
{
    if (_notificationObserver == nil) {
        _notificationObserver = [[CSNNotificationObserver alloc] init];
    }
    
    return _notificationObserver;
}

- (IBAction)addObserverAction:(id)sender
{
    [self.notificationObserver addObserver:self selector:@selector(receiveNotification:) name:kTestNotificationName object:nil];
}

- (IBAction)removeObserverAction:(id)sender
{
    [self.notificationObserver removeObserver:self name:kTestNotificationName object:nil];
}

- (IBAction)addObserverBlockAction:(id)sender
{
    [self.notificationObserver addObserverForName:kTestNotificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSLog(@"%s Block Support: %@", __PRETTY_FUNCTION__, notification);
    }];
}

- (IBAction)removeObserverBlockAction:(id)sender
{
    [self.notificationObserver removeObserverByName:kTestNotificationName];
}

- (void)receiveNotification:(NSNotification *)notification
{
    NSLog(@"%s Selector Support: %@", __PRETTY_FUNCTION__, notification);
}

- (IBAction)removeNotificationObserver:(id)sender
{
    self.notificationObserver = nil;
}
@end
