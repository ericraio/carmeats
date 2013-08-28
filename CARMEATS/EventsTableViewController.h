//
//  EventsTableViewController.h
//  CARMEATS
//
//  Created by Eric Raio on 6/23/13.
//  Copyright (c) 2013 Eric Raio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *events;

- (void) dataRetrieved:(NSDictionary *)sourceDictionary;
- (void) loadEvents;

@end
