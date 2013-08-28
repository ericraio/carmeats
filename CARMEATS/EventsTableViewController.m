//
//  EventsTableViewController.m
//  CARMEATS
//
//  Created by Eric Raio on 6/23/13.
//  Copyright (c) 2013 Eric Raio. All rights reserved.
//

#import "EventsTableViewController.h"
#import "Event.h"
#import "MapViewController.h"

@interface EventsTableViewController ()

@end

@implementation EventsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"CARMEATS";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadEvents];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadEvents) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)viewDidUnload
{
    //Unregister notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataRetrieved:(NSNotification *)sourceDictionary
{
    self.events = sourceDictionary.userInfo[@"events"];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void) loadEvents
{
    [Event fetchAll];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRetrieved:) name:@"eventsJSONFinishedLoading" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ return self.events.count; }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.events[indexPath.row] title];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MapViewController *mapViewController = [[MapViewController alloc] init];
    mapViewController.title = [self.events[indexPath.row] title];
    
    [self.navigationController pushViewController:mapViewController animated:YES];
}

@end
