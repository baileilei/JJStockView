//
//  ListenerBag.m
//  TfsCore
//
//  Created by CKC on 12/10/10.
//  All rights reserved. © Treasure Frontier System Sdn. Bhd.
//

#import "ListenerBag.h"


@implementation ListenerBag
//@synthesize actionListeners;
//@synthesize itemListeners;
//@synthesize changeListeners;
@synthesize source;

#define LISTERNER_SIZE 100

//- (void) initArray:(NSObject*[LISTERNER_SIZE])array
//{
//    //    NSObject** array = malloc(sizeof(NSObject*) * LISTERNER_SIZE);
//    for (int i=0; i<LISTERNER_SIZE; i++)
//    {
//        array[i] = nil;
//    }
////    return array;
//}

- (id) init:(NSObject *) source_
{
	if ((self = [super init]))
	{
		self.source = source_;
//        [self initArray:actionListenerArray];
//        [self initArray:itemListenerArray];
//        [self initArray:changeListenerArray];
//		actionListenerArray = nil;
//		itemListenerArray = nil;
//		changeListenerArray = nil;
	}
	return self;
}

- (void) addObjectToArray:(NSObject *)obj array:(NSObject**)array
{
	for (int i=0; i<LISTERNER_SIZE; i++)
	{
		if (array[i]==nil)
		{
			array[i] = obj;
			break;
		}
	}
}

- (void) removeObjectFromArray:(NSObject *)obj array:(NSObject**)array
{
	for (int i=0; i<LISTERNER_SIZE; i++)
	{
		if (array[i]==obj)
		{
			array[i] = nil;
			break;
		}
	}
}

- (void) addActionListener:(id<ActionListener>) l
{
	if (l == nil) return;
//	if (actionListenerArray==nil)
//	{
//		actionListenerArray = [self initArray];
//	}
//    [self addObjectToArray:l array:actionListenerArray];

//	if (self.actionListeners==nil)
//	{
//		self.actionListeners = [[[NSMutableArray alloc] init] autorelease];
//	}
//	[self.actionListeners addObject:l];
//	[l release];
}

- (void) removeActionListener:(id<ActionListener>) l
{
//	if (self.actionListeners==nil) return;
//	[l retain];
//	[self.actionListeners removeObject:l];
	
//    if (actionListenerArray==nil) return;
//    [self removeObjectFromArray:l array:actionListenerArray];
}

- (void) fireActionListener
{
	[self fireActionListener:@""];
}

- (void) fireActionListener:(NSString *) command
{
//    if (actionListenerArray==nil) return;
//
//    ActionEvent *actionEvent = [[ActionEvent alloc] init:self.source idNo:UIControlEventTouchUpInside command:command];
//
//    for (int i=0; i<LISTERNER_SIZE; i++)
//    {
//        if (actionListenerArray[i]!=nil)
//        {
//            if ([actionListenerArray[i] respondsToSelector:@selector(actionPerformed:)])
//                [actionListenerArray[i] actionPerformed:actionEvent];
//        }
//    }

//    [actionEvent release];
	
//	if (self.actionListeners==nil) return;
//	int count = [self.actionListeners count];
//	if (count==0) return;
//	ActionEvent *actionEvent = [[ActionEvent alloc] init:self.source idNo:UIControlEventTouchUpInside command:command];
//	
//	for (id<ActionListener> listener in self.actionListeners) {
//		[listener actionPerformed:actionEvent];
//	}
//	[actionEvent release];
}

- (void) addItemListener:(id<ItemListener>) l
{
	if (l == nil) return;
//	if (itemListenerArray==nil)
//	{
//		itemListenerArray = [self initArray];
//	}
//    [self addObjectToArray:l array:itemListenerArray];
	
//	if (self.itemListeners==nil) self.itemListeners = [[[NSMutableArray alloc] init] autorelease];
//	[self.itemListeners addObject:l];
//	[l release];
}
- (void) removeItemListener:(id<ItemListener>) l
{
//	if (self.itemListeners==nil) return;
//	[l retain];
//	[self.itemListeners removeObject:l];
	
//    if (itemListenerArray==nil) return;
//    [self removeObjectFromArray:l array:itemListenerArray];
}

- (void) fireItemListener:(int) stateChange
{
//    if (itemListenerArray==nil) return;
//
//    ItemEvent *itemEvent = [[ItemEvent alloc] init:self.source idNo:0 item:self.source stateChange:stateChange];
//
//    for (int i=0; i<LISTERNER_SIZE; i++)
//    {
//        if (itemListenerArray[i]!=nil)
//        {
//            if ([itemListenerArray[i] respondsToSelector:@selector(itemStateChanged:)])
//                [itemListenerArray[i] itemStateChanged:itemEvent];
//        }
//    }
	
//    [itemEvent release];
	
//	if (self.itemListeners==nil) return;
//	int count = [self.itemListeners count];
//	if (count==0) return;
//	
//	ItemEvent *itemEvent = [[ItemEvent alloc] init:self.source idNo:0 item:self.source stateChange:stateChange];
//	
//	for (id<ItemListener> listener in self.itemListeners) {
//		[listener itemStateChanged:itemEvent];
//	}
//	[itemEvent release];
}

- (void) addChangeListener:(id<ChangeListener>) l
{
	if (l == nil) return;
//	if (changeListenerArray==nil)
//	{
//		changeListenerArray = [self initArray];
//	}
//    [self addObjectToArray:l array:changeListenerArray];
	
//	if (self.changeListeners==nil) changeListeners = [[NSMutableArray alloc] init];
//	[self.changeListeners addObject:l];
//	[l release];
}

- (void) removeChangeListener:(id<ChangeListener>) l
{
//	if (self.changeListeners==nil) return;
//	[l retain];
//	[self.changeListeners removeObject:l];
	
//    if (changeListenerArray==nil) return;
//    [self removeObjectFromArray:l array:changeListenerArray];
}

- (void) fireChangeListener
{//change事件， button事件 都归一为actionPerform事件
//    if (changeListenerArray==nil) return;
//
//    ChangeEvent *changeEvent = [[ChangeEvent alloc] init:self.source];
//
//    for (int i=0; i<LISTERNER_SIZE; i++)
//    {
//        if (changeListenerArray[i]!=nil)
//        {
//            if ([changeListenerArray[i] respondsToSelector:@selector(stateChanged:)])
//                [changeListenerArray[i] stateChanged:changeEvent];
//        }
//    }
	
//    [changeEvent release];
	
//	if (self.changeListeners==nil) return;
//	int count = [self.changeListeners count];
//	if (count==0) return;
//	ChangeEvent *changeEvent = [[ChangeEvent alloc] init:self.source];
//
//	for (id<ChangeListener> listener in self.changeListeners)
//	{
//		[listener stateChanged:changeEvent];
//	}
//	[changeEvent release];
}

- (void) dealloc
{
//	NSLog(@"ListenerBag dealloc a=%d, i=%d, c=%d", 
//		  actionListeners==nil?-1:actionListeners.retainCount,
//		  itemListeners==nil?-1:itemListeners.retainCount,
//		  changeListeners==nil?-1:changeListeners.retainCount);

//	if (actionListenerArray!=nil)
//	{
//		free(actionListenerArray);	
//		actionListenerArray = nil;
//	}
//	
//	if (itemListenerArray!=nil)
//	{
//		free(itemListenerArray);	
//		itemListenerArray = nil;
//	}
//	
//	if (changeListenerArray!=nil)
//	{
//		free(changeListenerArray);	
//		changeListenerArray = nil;
//	}
//	[actionListeners release];
//	[itemListeners release];
//	[changeListeners release];
//	[source release];
//    [super dealloc];
}

@end
