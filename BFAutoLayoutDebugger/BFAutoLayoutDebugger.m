//
//  BFAutoLayoutDebugger.m
//  BFAutoLayoutDebugger
//
//  Created by Balázs Faludi on 20.07.13.
//  Copyright (c) 2013 Balazs Faludi. All rights reserved.
//

#import "BFAutoLayoutDebugger.h"
#import "BFAutoLayoutDebuggerWindowController.h"

@interface BFAutoLayoutDebugger ()

@property (nonatomic) NSMenuItem *mainMenuItem;

@end


@implementation BFAutoLayoutDebugger

+ (instancetype)sharedDebugger
{
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
        /* Do any other initialisation stuff here */
    });
    return sharedObject;
}

- (void)addMenu {
	NSMenu *menu = [[NSApplication sharedApplication] mainMenu];
	
	NSMenu *debugMenu = [[NSMenu alloc] initWithTitle:@"Auto Layout"];
	NSMenuItem *debuggerItem = [[NSMenuItem alloc] initWithTitle:@"Show Debugger" action:@selector(showPanel) keyEquivalent:@"a"];
	[debuggerItem setTarget:self];
	[debuggerItem setKeyEquivalentModifierMask:NSAlternateKeyMask | NSCommandKeyMask | NSControlKeyMask];
	[debugMenu addItem:debuggerItem];
	
	NSMenuItem *debugItem = [[NSMenuItem alloc] initWithTitle:@"Auto Layout" action:nil keyEquivalent:@""];
	[debugItem setSubmenu:debugMenu];
	[menu addItem:debugItem];
	
	self.mainMenuItem = debugItem;
}

- (void)removeMenu {
	NSMenu *menu = [[NSApplication sharedApplication] mainMenu];
	[menu removeItem:self.mainMenuItem];
	self.mainMenuItem = nil;
}

- (BFAutoLayoutDebuggerWindowController *)windowController {
	if (!_windowController) {
		_windowController = [[BFAutoLayoutDebuggerWindowController alloc] init];
	}
	return _windowController;
}

- (void)showPanel {
	[self.windowController.window orderFront:self];
}

@end
