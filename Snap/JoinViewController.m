//
//  JoinViewController.m
//  Snap
//
//  Created by Jesper Nielsen on 01/07/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "JoinViewController.h"
#import "UIFont+SnapAdditions.h"

@interface JoinViewController ()
@property (nonatomic, weak) IBOutlet UILabel *headingLabel;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UIView *waitView;
@property (nonatomic, weak) IBOutlet UILabel *waitLabel;
@end

@implementation JoinViewController{
    MatchMakingClient *_matchMakingClient;
}
@synthesize delegate = _delegate;
@synthesize headingLabel = _headingLabel;
@synthesize nameLabel = _nameLabel;
@synthesize nameTextField = _nameTextField;
@synthesize statusLabel = _statusLabel;
@synthesize tableView = _tableView;
@synthesize waitView = _waitView;
@synthesize waitLabel = _waitLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"dealloc %@",self);
#endif
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if(_matchMakingClient == nil){
        _matchMakingClient = [[MatchMakingClient alloc] init];
        _matchMakingClient.delegate = self;
        [_matchMakingClient startSearchingForServersWithSessionID:SESSION_ID];
        self.nameTextField.placeholder = _matchMakingClient.session.displayName;
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headingLabel.font = [UIFont jn_snapFontWithSize:24.0f];
    self.nameLabel.font = [UIFont jn_snapFontWithSize:16.0f];
    self.statusLabel.font = [UIFont jn_snapFontWithSize:16.0f];
    self.waitLabel.font = [UIFont jn_snapFontWithSize:18.0f];
    self.nameTextField.font = [UIFont jn_snapFontWithSize:20.0f];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponder)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.waitView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)exitAction:(id)sender{
    [self.delegate joinViewControllerDidCancel:self];
}

#pragma mark - MatchmakingClientDelegate
- (void)matchmakingClient:(MatchMakingClient *)client serverBecameAvailable:(NSString *)peerID{
    [self.tableView reloadData];
}

- (void)matchmakingClient:(MatchMakingClient *)client serverBecameUnavailable:(NSString *)peerID{
    [self.tableView reloadData];
}

#pragma mark - UITablweViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_matchMakingClient != nil) {
        return [_matchMakingClient availableServerCount];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *peerID = [_matchMakingClient peerIDForAvailableServerAtIndex:indexPath.row];
    cell.textLabel.text = [_matchMakingClient displayNameForPeerID:peerID];
    
    return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

@end
