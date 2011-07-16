//
//  AppDelegate.h
//  Matching
//
//  Created by Emmy Chen on 7/16/11.
//  Copyright Kuaitech 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
