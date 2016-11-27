//
//  RootViewController.m
//  ThinkGearTouch
//
//  Created by Horace Ko on 12/2/09.
//  Copyright NeuroSky, Inc. 2009. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
- (void)setLoadingScreenView;
@end

@implementation RootViewController

@synthesize loadingScreen;

// static here
static EEGValues copyEEGValues;
static ESenseValues copySenseValues;
static short copyRawValue;
static int copyRawCount;
static int copyBlinkStrength;
static int copyPoorSignalValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"ThinkGear Data"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self setLoadingScreenView];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    logEnabled = [defaults boolForKey:@"logging_enabled"];
    if(logEnabled)
        [self initLog];
    
    if([[TGAccessoryManager sharedTGAccessoryManager] accessory] != nil)
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    
    if(updateThread == nil) {
        updateThread = [[NSThread alloc] initWithTarget:self selector:@selector(updateTable) object:nil];
        [updateThread start];
    }
    
    //NSLog(@"TGAccessory version: %d", [[TGAccessoryManager sharedTGAccessoryManager] getVersion]);
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [output release];
    [logFile closeFile];
    [logFile release];
    [updateThread cancel];
    [updateThread release];
    [loadingScreen release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Table view methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section){
        case 0:
            return @"Raw";
        case 1:
            return @"Status";
        case 2:
            return @"eSense";
        case 3:
            return @"EEG bands";
        default:
            return nil;
    }
       
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section){
        case 0:
            return 2;
        case 1:
            return 1;
        case 2:
            return 3;
        case 3:
            return 8;
        default:
            return 0;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                       reuseIdentifier:CellIdentifier] autorelease];

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    NSInteger section = [indexPath indexAtPosition:0];
    NSInteger field = [indexPath indexAtPosition:1];
    
    cell.imageView.image = nil;
	// Configure the cell.
    switch(section){
        case 0:
            switch(field){
                case 0:
                    [[cell textLabel] setText:@"Sensor value"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyRawValue]];
                    break;
                case 1:
                    [[cell textLabel] setText:@"Raw count"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyRawCount]];
                default:
                    break;
            }
            
            break;
        case 1:
            switch(field){
                case 0:
                    [[cell textLabel] setText:@"Poor signal"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyPoorSignalValue]];
                    [[cell imageView] setImage:[self updateSignalStatus]];
                    break;
                default:
                    break;
            }
            
            break;
        case 2: 
            switch(field){
                case 0:
                    [[cell textLabel] setText:@"Attention"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copySenseValues.attention]];
                    break;
                case 1:
                    [[cell textLabel] setText:@"Meditation"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copySenseValues.meditation]];
                    break;
                case 2:
                    [[cell textLabel] setText:@"Blink strength"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyBlinkStrength]];
                default:
                    break;
            }
            
            break;
        case 3:
            switch(field){
                case 0:
                    [[cell textLabel] setText:@"Delta"];
                    
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.delta]];
                    break;
                case 1:
                    [[cell textLabel] setText:@"Theta"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.theta]];
                    break;
                case 2:
                    [[cell textLabel] setText:@"Low alpha"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.lowAlpha]];
                    break;
                case 3:
                    [[cell textLabel] setText:@"High alpha"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.highAlpha]];
                    break;
                case 4:
                    [[cell textLabel] setText:@"Low beta"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.lowBeta]];
                    break;
                case 5:
                    [[cell textLabel] setText:@"High beta"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.highBeta]];
                    break;
                case 6:
                    [[cell textLabel] setText:@"Low gamma"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.lowGamma]];
                    break;
                case 7:
                    [[cell textLabel] setText:@"High gamma"];
                    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%d", copyEEGValues.highGamma]];
                    break;
                default:
                    break;
            }
            
            break;
        default:
            break;
    }

  
    return cell;
}
- (UIImage *)updateSignalStatus {
    
    if(poorSignalValue == 0) {
        return [UIImage imageNamed:@"Signal_Connected"];
    }
    else if(poorSignalValue > 0 && poorSignalValue < 50) {
        return [UIImage imageNamed:@"Signal_Connecting3"];
    }
    else if(poorSignalValue > 50 && poorSignalValue < 200) {
        return [UIImage imageNamed:@"Signal_Connecting2"];
    }
    else if(poorSignalValue == 200) {
        return [UIImage imageNamed:@"Signal_Connecting1"];
    }
    else {
        return [UIImage imageNamed:@"Signal_Disconnected"];
    }
}

#pragma mark -
#pragma mark TGAccessoryDelegate protocol methods

//  This method gets called by the TGAccessoryManager when a ThinkGear-enabled
//  accessory is connected.
- (void)accessoryDidConnect:(EAAccessory *)accessory {
    // toss up a UIAlertView when an accessory connects
    /*UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Accessory Connected" 
                                                  message:[NSString stringWithFormat:@"A ThinkGear accessory called %@ was connected to this device.", [accessory name]]
                                                 delegate:nil 
                                        cancelButtonTitle:@"Okay" 
                                        otherButtonTitles:nil];
    [a show];
    [a release];
    */
    
    // start the data stream to the accessory
    [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    
    // set up the current view
    [self setLoadingScreenView];
}

//  This method gets called by the TGAccessoryManager when a ThinkGear-enabled
//  accessory is disconnected.
- (void)accessoryDidDisconnect {
    // toss up a UIAlertView when an accessory disconnects
    /*UIAlertView * a = [[UIAlertView alloc] initWithTitle:@"Accessory Disconnected" 
                                                  message:@"The ThinkGear accessory was disconnected from this device." 
                                                 delegate:nil 
                                        cancelButtonTitle:@"Okay" 
                                        otherButtonTitles:nil];
    [a show];
    [a release];
    */
    // set up the appropriate view
    
    [self setLoadingScreenView];
}

//  This method gets called by the TGAccessoryManager when data is received from the
//  ThinkGear-enabled device.
- (void)dataReceived:(NSDictionary *)data {
    //[data retain];
    //NSLog(@"%@",data);
    //printf("%s",data);
    NSString * temp = [[NSString alloc] init];
    static int count = 0;
    count ++;
    NSDate * date = [NSDate date];
    rawValue = [[data valueForKey:@"raw"] shortValue];
    if ((2048 < count) && (7169 >= count)) {// && 2561 >= count) {
        printf("%d\n", rawValue);
    }
    
    temp = [temp stringByAppendingFormat:@"%f: Raw: %d\n", [date timeIntervalSince1970], rawValue];
    
    if([data valueForKey:@"blinkStrength"])
        blinkStrength = [[data valueForKey:@"blinkStrength"] intValue];
    
    // check to see whether the eSense values are there. if so, we assume that
    // all of the other data (aside from raw) is there. this is not necessarily
    // a safe assumption.
    if([data valueForKey:@"eSenseAttention"]){
        poorSignalValue = [[data valueForKey:@"poorSignal"] intValue];
       
        //temp = [NSString stringWithFormat:@"poorsignal: %02x\n", poorSignalValue];
        temp = [temp stringByAppendingFormat:@"%f: Poor Signal: %d\n", [date timeIntervalSince1970], poorSignalValue];
        
        eSenseValues.attention =    [[data valueForKey:@"eSenseAttention"] intValue];        
        eSenseValues.meditation =   [[data valueForKey:@"eSenseMeditation"] intValue];
        temp = [temp stringByAppendingFormat:@"%f: Attention: %d\n", [date timeIntervalSince1970], eSenseValues.attention];
        temp = [temp stringByAppendingFormat:@"%f: Meditation: %d\n", [date timeIntervalSince1970], eSenseValues.meditation];

       
            eegValues.delta =       [[data valueForKey:@"eegDelta"] intValue];
            eegValues.theta =       [[data valueForKey:@"eegTheta"] intValue];
            eegValues.lowAlpha =    [[data valueForKey:@"eegLowAlpha"] intValue];
            eegValues.highAlpha =   [[data valueForKey:@"eegHighAlpha"] intValue];
            eegValues.lowBeta =     [[data valueForKey:@"eegLowBeta"] intValue];
            eegValues.highBeta =    [[data valueForKey:@"eegHighBeta"] intValue];
            eegValues.lowGamma =    [[data valueForKey:@"eegLowGamma"] intValue];
            eegValues.highGamma =   [[data valueForKey:@"eegHighGamma"] intValue];
        
        rawCount = [[data valueForKey:@"rawCount"] intValue];
        
        copyPoorSignalValue = poorSignalValue;
        copyEEGValues = eegValues;
        copySenseValues= eSenseValues;
        copyRawCount = rawCount;
    }
    
    copyRawValue = rawValue;
    copyBlinkStrength = blinkStrength;

    if(logEnabled) {
        [output release];
        output = [NSString stringWithString:temp];
        [self performSelectorOnMainThread:@selector(writeLog) withObject:nil waitUntilDone:NO];        
    }
        
    [temp release];    
    
    // release the parameter
    //[data release];
}


#pragma mark -
#pragma mark Internal helper methods

- (void)initLog {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/log.txt", documentsDirectory];
    
    //check if the file exists if not create it
    if(![[NSFileManager defaultManager] fileExistsAtPath:fileName])
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];    
    
    logFile = [[NSFileHandle fileHandleForWritingAtPath:fileName] retain];
    [logFile seekToEndOfFile];
    
    output = [[NSString alloc] init];
}

- (void)writeLog {
    if (logEnabled && logFile) {
        [logFile writeData:[output dataUsingEncoding:NSUTF8StringEncoding]];
    }     
}

//  Determine whether to display the blank "Please connect an accessory" screen or the TableView.
- (void)setLoadingScreenView {
    if([[TGAccessoryManager sharedTGAccessoryManager] accessory] == nil){
        [self.view addSubview: loadingScreen];
		[self.tableView setScrollEnabled:NO];
    }
    else {
        [loadingScreen removeFromSuperview];
		[self.tableView setScrollEnabled:YES];
        [self.tableView reloadData];
    }
}

- (void)updateTable {
    while(1) {
        NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
        [[self tableView] performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [pool drain];
        [NSThread sleepForTimeInterval:0.15];
    }
}

@end

