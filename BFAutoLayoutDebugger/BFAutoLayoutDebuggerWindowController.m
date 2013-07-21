//
//  BFAutoLayoutDebuggerWindowController.m
//  BFAutoLayoutDebugger
//
//  Created by Balázs Faludi on 20.07.13.
//  Copyright (c) 2013 Balazs Faludi. All rights reserved.
//

#import "BFAutoLayoutDebuggerWindowController.h"
#import "ColorView.h"

@interface BFAutoLayoutDebuggerWindowController ()

@property (nonatomic) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSSegmentedControl *segmentButton;

@property (nonatomic, weak) NSWindow *debuggedWindow;
@property (nonatomic, weak) NSView *rootView;

@end


@implementation BFAutoLayoutDebuggerWindowController

- (id)init
{

//    NSWindow *debuggedWindow = [NSApp mainWindow];
//	CGFloat width = 350.0f;
//	NSRect rect = NSMakeRect(debuggedWindow.frame.origin.x - width - 20, debuggedWindow.frame.origin.y,
//							 MAX(200, width), MAX(200, debuggedWindow.frame.size.height));
//	NSUInteger style = NSTitledWindowMask | NSUtilityWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
//	NSPanel *panel = [[NSPanel alloc] initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    self = [self initWithWindowNibName:@"BFAutoLayoutDebuggerWindow"];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:)
													 name:NSWindowDidBecomeMainNotification object:nil];
//		panel.delegate = self;
//		NSView *contentView = panel.contentView;
//		
//		self.outlineView = [[NSOutlineView alloc] initWithFrame:contentView.bounds];
//		self.outlineView.autoresizingMask = 0;
//		self.outlineView.translatesAutoresizingMaskIntoConstraints = YES;
//		self.outlineView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleSourceList;
//		self.outlineView.headerView = nil;
//		self.outlineView.delegate = self;
//		self.outlineView.dataSource = self;
//		self.outlineView.rowHeight = 20.0f;
//		self.outlineView.allowsColumnReordering = NO;
//		self.outlineView.columnAutoresizingStyle = NSTableViewFirstColumnOnlyAutoresizingStyle;
//		self.outlineView.allowsColumnResizing = NO;
//		self.outlineView.allowsColumnSelection = NO;
//		self.outlineView.allowsMultipleSelection = YES;
//		self.outlineView.intercellSpacing = NSMakeSize(0, 3);
//		
//		
//		NSTableColumn *outlineColumn = [[NSTableColumn alloc] initWithIdentifier:@"Outline"];
//		outlineColumn.width = contentView.bounds.size.width;
//		outlineColumn.resizingMask = NSTableColumnAutoresizingMask;
//		outlineColumn.editable = NO;
//		[self.outlineView addTableColumn:outlineColumn];
//		self.outlineView.outlineTableColumn = outlineColumn;
//		
//		NSClipView *clipView = [[NSClipView alloc] initWithFrame:contentView.bounds];
//		clipView.translatesAutoresizingMaskIntoConstraints = NO;
//		[clipView addSubview:self.outlineView];
//		
//		NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:contentView.bounds];
//		scrollView.translatesAutoresizingMaskIntoConstraints = NO;
//		[scrollView addSubview:clipView];
//		[scrollView setContentView:clipView];
//		[scrollView setDocumentView:self.outlineView];
//		[contentView addSubview:scrollView];
//		
//		NSDictionary *views = @{@"scrollView": scrollView, @"clipView" : clipView};
//		NSArray *constraints;
//		
//		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0@490)-[scrollView]-(0@490)-|" options:0 metrics:nil views:views];
//		[contentView addConstraints:constraints];
//		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0@490)-[scrollView]-(0@490)-|" options:0 metrics:nil views:views];
//		[contentView addConstraints:constraints];
//		
//		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[clipView]|" options:0 metrics:nil views:views];
//		[scrollView addConstraints:constraints];
//		constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[clipView]|" options:0 metrics:nil views:views];
//		[scrollView addConstraints:constraints];
    }
    return self;
}

- (void)setRootView:(NSView *)rootView {
	if (_rootView != rootView) {
		_rootView = rootView;
		[self.outlineView reloadData];
		[self.outlineView expandItem:self.rootView expandChildren:YES];
		[self updateConstraints];
	}
}

- (void)setDebuggedWindow:(NSWindow *)debuggedWindow {
	if (_debuggedWindow != debuggedWindow && debuggedWindow != self.window) {
		_debuggedWindow = debuggedWindow;
		self.rootView = _debuggedWindow.contentView;
		
		NSRect rect = NSMakeRect(_debuggedWindow.frame.origin.x - self.window.frame.size.width - 20, _debuggedWindow.frame.origin.y,
								 MAX(250, self.window.frame.size.width), _debuggedWindow.frame.size.height);
		[self.window setFrame:rect display:YES];
	}
}

- (void)mainWindowChanged:(NSNotification *)notification {
	NSWindow *newMainWindow = notification.object;
	self.debuggedWindow = newMainWindow;
}

- (void)windowDidLoad {
	self.debuggedWindow = [NSApp mainWindow];
}

- (void)windowWillClose:(NSNotification *)notification {
	[self.debuggedWindow visualizeConstraints:nil];
}

#pragma mark - NSOutlineViewDataSource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
	if (item) return [[item subviews] count];
	return self.rootView ? 1 : 0;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
	return [[item subviews] count] > 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
	return item ? [item subviews][index] : self.rootView;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
	return [item description];
}

#pragma mark - NSOutlineViewDelegate 

//- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item {
//	return [self outlineView:outlineView isItemExpandable:item];
//}

//- (NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item {
//	ColorRowView *cellView = [[ColorRowView alloc] init];
//	cellView.color = [NSColor blueColor];
//	cellView.translatesAutoresizingMaskIntoConstraints = NO;
//	return cellView;
	//	NSTableRowView *rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 200, 20)]; // Frame is temparary, reset by outline view later.
//	return rowView;
//}

//- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
//	ColorView *cellView = [[ColorView alloc] init];
//	cellView.color = [NSColor redColor];
//	cellView.translatesAutoresizingMaskIntoConstraints = NO;
//	return cellView;
//	NSTableCellView *cellView = [[NSTableCellView alloc] initWithFrame:NSMakeRect(0, 0, 200, 20)];
//	NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(3, 0, 194, 20)];
//	textField.stringValue = @"Testing testing...";
//	textField.autoresizingMask = NSViewWidthSizable | NSViewMinYMargin;
//	textField.translatesAutoresizingMaskIntoConstraints = YES;
//	cellView.translatesAutoresizingMaskIntoConstraints = NO;
//	[cellView addSubview:textField];
//	textField.backgroundColor = [NSColor redColor];
//	cellView.backgroundStyle = NSBackgroundStyleDark;
//	
//	NSDictionary *views = @{@"textField" : textField};
//	NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(3)-[textField]" options:0 metrics:nil views:views];
//	[cellView addConstraints:constraints];
//	return cellView;
	
//}

//- (void)outlineView:(NSOutlineView *)outlineView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row {
//	NSRect triangleFrame = [outlineView frameOfOutlineCellAtRow:row];
//	NSView *cellView = [rowView viewAtColumn:0];
//	NSDictionary *views = @{@"cellView" : cellView};
//	CGFloat indent = 40;//triangleFrame.origin.x + triangleFrame.size.width;// + outlineView.indentationPerLevel * [outlineView levelForRow:row];
//	NSDictionary *metrics = @{@"indent" : @(indent)};
//	NSArray *constraints;
//	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-(indent)-[cellView]-(3)-|" options:0 metrics:metrics views:views];
//	[rowView addConstraints:constraints];
//	constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cellView]|" options:0 metrics:metrics views:views];
//	[rowView addConstraints:constraints];
//}

//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//	NSView *rowView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
//	if (!rowView) {
//		rowView = [[NSTableRowView alloc] initWithFrame:NSMakeRect(0, 0, 200, 20)]; // Frame is temparary, reset by outline view later.
//		
//		NSTextField *textField
//	}
//	return rowView;
//}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
	[self updateConstraints];
}

#pragma mark - Actions

- (IBAction)reloadList:(id)sender {
	[self.outlineView reloadData];
	[self.outlineView expandItem:self.rootView expandChildren:YES];
}

- (IBAction)logConstraints:(id)sender {
	NSLog(@"%@", [[self selectedContstraints] description]);
}

- (IBAction)segmentChanged:(id)sender {
	[self updateConstraints];
}

- (void)updateConstraints {
	[self.debuggedWindow visualizeConstraints:[self selectedContstraints]];
}

- (NSArray *)selectedContstraints {
	NSLayoutConstraintOrientation orientation = NSLayoutConstraintOrientationHorizontal;
	if (self.segmentButton.selectedSegment == 1) orientation = NSLayoutConstraintOrientationVertical;
	 
	NSMutableArray *constraints = [[NSMutableArray alloc] init];
	[self.outlineView.selectedRowIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
		NSView *view = [self.outlineView itemAtRow:idx];
		[constraints addObjectsFromArray:[view constraintsAffectingLayoutForOrientation:orientation]];
	}];
	if (constraints.count < 1) {
		[constraints addObjectsFromArray:[self.rootView constraintsAffectingLayoutForOrientation:orientation]];
	}
	return constraints;
}

@end
