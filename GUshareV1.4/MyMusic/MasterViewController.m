//
//  MasterViewController.m
//  MyMusic
//
//  Created by Florian Heller on 3/18/13.
//  Copyright (c) 2013 Florian Heller - RWTH Aachen University. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSArray *_myMusic;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
	NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"plist"];
	if (musicPath)
	{
		_myMusic = [NSArray arrayWithContentsOfFile:musicPath];
	}
	else {
		NSLog(@"Could not load music database");
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // URL for our plist
	NSURL *plistURL = [NSURL URLWithString:@"http://github.com/samsoffes/iphone-plist/raw/master/HelloWorld.plist"];
	
	// Initialize our dictionary from the plist on the server
	NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfURL:plistURL];
	
	// Update the view to show that our results
	
	// Integers are mapped to NSNumbers
	// We need to do string value because this is a NSNumber and the UILabel wants a NSString
	labelThree.text = [[dictionary objectForKey:@"weCanDoIntegersToo"] stringValue];
    
	// Do any additional setup after loading the view, typically from a nib.
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [_myMusic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_myMusic[section][@"toShare"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	NSDictionary *object = _myMusic[indexPath.section][@"toShare"][indexPath.row];
	cell.textLabel.text = object[@"itemname"];
	cell.detailTextLabel.text = object[@"sharedby"];
	cell.imageView.image = [UIImage imageNamed:_myMusic[indexPath.section][@"image"]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return _myMusic[section][@"title"];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//		[_myMusic[indexPath.section][@"tracks"] removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
      [[segue destinationViewController] setItemName:_myMusic[indexPath.section][@"toShare"][indexPath.row][@"itemname"]];
     
        
        
        [[segue destinationViewController] setTitle:_myMusic[indexPath.section][@"title"]];
        [[segue destinationViewController] setSharedBy :_myMusic[indexPath.section][@"toShare"][indexPath.row][@"sharedby"]];
        [[segue destinationViewController] setFrom:_myMusic[indexPath.section][@"toShare"][indexPath.row][@"from"]];
       [[segue destinationViewController] setTo:_myMusic[indexPath.section][@"toShare"][indexPath.row][@"to"]];
//       [[segue destinationViewController] setTrackTitle:_myMusic[indexPath.section][@"toShare"][indexPath.row][@"description"]];
        [[segue destinationViewController] setItemimage:[UIImage imageNamed:_myMusic[indexPath.section][@"toShare"][indexPath.row][@"image"]]];


		//NSDictionary *selectedTrack = _myMusic[indexPath.section][@"tracks"][indexPath.row];
        //[[segue destinationViewController] setDetailItem:selectedTrack];
    }
}

@end
