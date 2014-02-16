# CSNNotificationObserver

## Overview

Simple manage NotificationObserver inspired by cockscomb. you won't forget to remove notification.

## Requirements

* iOS 6 or Later
* ARC

## Usage

### Traditional implementation for selector style

```objc
@implementation SampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)receiveDidEnterBackgroundNotification:(NSNotification *)notification
{
    // do something
}

- (void)dealloc
{
    // You have to remove observer, but sometimes forget about it.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
```

### New implementation for selector style

```objc
@implementation SampleViewController {
    CSNNotificationObserver *_observer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _observer = [[CSNNotificationObserver alloc] initWithObserver:self selector:@selector(receiveDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)receiveDidEnterBackgroundNotification:(NSNotification *)notification
{
    // do something
}

- (void)dealloc
{
    // You don't have to worry about to remove observer
}

@end
```

### Traditional implementation for blocks style

```objc
@implementation SampleViewController {
    id _didEnterBackgroundNotificationObserver;
    id _willEnterForegroundNotificationObserver;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _didEnterBackgroundNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        // do something
    }];
    
    _willEnterForegroundNotificationObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        // do something
    }];
}

- (void)dealloc
{
    // You have to remove observer, but sometimes forget about it.
    [[NSNotificationCenter defaultCenter] removeObserver:_didEnterBackgroundNotificationObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:_willEnterForegroundNotificationObserver];
}

@end

```

### New implementation for blocks style

```objc
@implementation SampleViewController {
    CSNNotificationObserver *_observer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _observer = [[CSNNotificationObserver alloc] initWithName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        // do something
    }];
    
    [_observer addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        // do something
    }];
}

- (void)dealloc
{
    // You don't have to worry about to remove observer
}

@end
```

Especially useful when you choose block based notification observing. You don't need to have ivars, you need just 1 ivar, and it's automatically removed as observer when deallocated.

## Install

Use CocoaPods,

```ruby
pod 'CSNNotificationObserver', :git => 'https://github.com/griffin-stewie/CSNNotificationObserver.git'
```


## License

The MIT License (MIT)

Copyright (c) 2014 griffin-stewie

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
