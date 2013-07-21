//
//  AppDelegate.m
//  Demo
//
//  Created by Balázs Faludi on 21.07.13.
//  Copyright (c) 2013 Balazs Faludi. All rights reserved.
//

#import "AppDelegate.h"
#import "BFAutoLayoutDebugger.h"
#import "ColorView.h"

@interface AppDelegate ()

@property (weak) IBOutlet ColorView *colorView1;
@property (weak) IBOutlet ColorView *colorView2;
@property (weak) IBOutlet ColorView *colorView3;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

- (void)awakeFromNib {
	_colorView1.color = [NSColor colorWithCalibratedRed:0.930 green:0.964 blue:0.658 alpha:1.000];
	_colorView2.color = [NSColor colorWithCalibratedRed:0.812 green:0.866 blue:1.000 alpha:1.000];
	_colorView3.color = [NSColor colorWithCalibratedRed:0.875 green:0.790 blue:1.000 alpha:1.000];
	[[BFAutoLayoutDebugger sharedDebugger] addMenu];
	[[BFAutoLayoutDebugger sharedDebugger] showPanel];
}

@end
