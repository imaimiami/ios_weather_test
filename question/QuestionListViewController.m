//
//  QuestionListViewController.m
//  question
//
//  Created by imaimiami on 2014/03/09.
//  Copyright (c) 2014年 PLASTICA ROMANTICA. All rights reserved.
//

#import "QuestionListViewController.h"
#import "WebViewController.h"

@interface QuestionListViewController ()
@property (strong, nonatomic) NSArray *questions;
@end

@implementation QuestionListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self fetchNewQuestions];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *question = self.questions[indexPath.row];
    
    cell.textLabel.text = question[@"dateLabel"];
    NSData *dt = [NSData dataWithContentsOfURL:[NSURL URLWithString:question[@"image"][@"url"]]];
    cell.imageView.image = [[UIImage alloc] initWithData:dt];
    cell.detailTextLabel.text = question[@"telop"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    UITableViewCell *cell = (UITableViewCell *)sender;
    NSLog(@"Value of string is %@", cell);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *question = self.questions[indexPath.row];
    
    WebViewController *viewController = [segue destinationViewController];
    viewController.url = [NSURL URLWithString:@"http://livedoor.com"];
}

- (void) fetchNewQuestions
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError *error)
    {
        if (error)
        {
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError != nil) return;
        
        self.questions = jsonDictionary[@"forecasts"];
        
        [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
        
        
    }];
    
    [task resume];
    
}

- (void) reloadTableView
{
    [self.tableView reloadData];
}

@end
