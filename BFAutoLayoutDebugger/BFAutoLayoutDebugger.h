//
//  BFAutoLayoutDebugger.h
//  BFAutoLayoutDebugger
//
//  Created by Balázs Faludi on 20.07.13.
//  Copyright (c) 2013 Balazs Faludi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFAutoLayoutDebuggerWindowController;

@interface BFAutoLayoutDebugger : NSObject

@property (nonatomic) BFAutoLayoutDebuggerWindowController *windowController;

+ (instancetype)sharedDebugger;

- (void)addMenu;
- (void)removeMenu;

- (void)showPanel;

@end
