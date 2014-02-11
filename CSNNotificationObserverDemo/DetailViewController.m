//
//  DetailViewController.m
//  CSNNotificationObserverDemo
//
//  Created by griffin_stewie on 2014/02/11.
//  Copyright (c) 2014年 cyan-stivy.net. All rights reserved.
//

#import "DetailViewController.h"
#import "CSNNotificationObserver.h"

@interface DetailViewController ()
@property (nonatomic, strong) CSNNotificationObserver *notificationObserver;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.notificationObserver = [[CSNNotificationObserver alloc] initWithObserver:self selector:@selector(receiveNotification:) name:nil object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)receiveNotification:(NSNotification *)notification
{
    NSLog(@"%s %@", __PRETTY_FUNCTION__, notification);
}
@end
