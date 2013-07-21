//
//  ColorView.m
//  BFAutoLayoutDebugger
//
//  Created by Balázs Faludi on 21.07.13.
//  Copyright (c) 2013 Balazs Faludi. All rights reserved.
//

#import "ColorView.h"

@implementation ColorView


- (void)setColor:(NSColor *)color {
	_color = color;
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
	[self.color setFill];
	NSRectFill(dirtyRect);
}

@end
