//
//  KwickieTableViewDataSource.m
//  kwickieTim
//
//  Created by Test on 13/03/2016.
//  Copyright © 2016 Tim. All rights reserved.
//

#import "KwickieTableViewDataSource.h"
#import "KwickieTableViewCell.h"
#import "myURLSession.h"


@implementation KwickieTableViewDataSource


//-------------UITableViewDelegate starts

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%s row=[%ld]",__PRETTY_FUNCTION__, (long)indexPath.row);
    
    NSInteger row = indexPath.row;
    
    NSMutableArray *videoUrl = [self.myLibrary valueForKeyPath:@"kwickieVideo.playlistUrl"];
    NSString *videoUrlStr = [NSString stringWithFormat:@"%@", [videoUrl objectAtIndex:row] ];
    
    [self playVideo:videoUrlStr];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//-------------UITableViewDelegate ends



- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    KwickieTableViewCell *cell = (KwickieTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[KwickieTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //default color
    cell.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *thumbUrl = [self.myLibrary valueForKeyPath:@"kwickieVideo.thumbUrl"];
    NSMutableArray *answerFirstName = [self.myLibrary valueForKeyPath:@"answerUser.firstName"];
    NSMutableArray *answerLastName = [self.myLibrary valueForKeyPath:@"answerUser.lastName"];
    NSMutableArray *questionFirstName = [self.myLibrary valueForKeyPath:@"questionUser.firstName"];
    NSMutableArray *questionLastName = [self.myLibrary valueForKeyPath:@"questionUser.lastName"];
    
    
    NSString *thumbUrlStr = [NSString stringWithFormat:@"%@", [thumbUrl objectAtIndex:row] ];
    NSString *answerFirstNameStr = [NSString stringWithFormat:@"%@", [answerFirstName objectAtIndex:row] ];
    NSString *answerLastNameStr = [NSString stringWithFormat:@"%@", [answerLastName objectAtIndex:row] ];
    NSString *questionFirstNameStr = [NSString stringWithFormat:@"%@", [questionFirstName objectAtIndex:row] ];
    NSString *questionLastNameStr = [NSString stringWithFormat:@"%@", [questionLastName objectAtIndex:row] ];
    
    cell.questionLabel.text = [NSString stringWithFormat:@"Q: %@ %@", questionFirstNameStr, questionLastNameStr];
    cell.answerLabel.text = [NSString stringWithFormat:@"A: %@ %@", answerFirstNameStr, answerLastNameStr];

    
    //Image thumbnail
    NSData *thumbImageData = [self.myLibraryImages valueForKeyPath:thumbUrlStr];
  
    if (!thumbImageData)
    {
        //NSLog(@"image NOT found: [%@]", thumbUrlStr);
        [self downloadImage:thumbUrlStr];
    }
    else
    {
        //NSLog(@"image found: [%@]", thumbUrlStr);
        UIImage *thumbImage = [UIImage imageWithData:thumbImageData];
        [cell.kwickieImageView setImage:thumbImage];
    }
    
    
    
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.myLibrary count];
}

- (void) startObserver:(NSString *)notificationsName;
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newTableViewData:) name:notificationsName object:nil];
    
}

-(void)newTableViewData:(NSNotification *)notification  //This notification will be received in the background
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSDictionary *myDict = [notification userInfo];
    
    self.myLibrary = myDict;
    
    self.myLibraryImages = [[NSMutableDictionary alloc] init];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:self userInfo:nil];
}

- (void) downloadImage:(NSString *)imageURL
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    //URL
    NSMutableString *serverAddress = [NSMutableString stringWithFormat:@"%@", imageURL];
    
    //connect
    self.myConnection = [[myURLSession alloc] init];
    
    NSString *methodServerReplied = @"serverReplyReceived_thumbImage";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(serverReplyReceivedImage:) name:methodServerReplied object:nil];
    
    //Initiate connection to server. Response is received in method specified
    [self.myConnection connectUrl:serverAddress notifyMethodName:methodServerReplied];
    
    
}

-(void)serverReplyReceivedImage:(NSNotification *)notification  //This notification will be received in the background
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
    
    NSDictionary *notification_dict = [notification userInfo];
    NSData *serverReplyData = [notification_dict objectForKey:@"NSData"];
  // NSError *serverError = [notification_dict objectForKey:@"NSError"];
    NSString *serverURL = [notification_dict objectForKey:@"URL"];
    
  // NSLog(@"[serverReplyReceivedImage] error = [%@] URL=[%@]", serverError.debugDescription, serverURL);
    
    id id_data = serverReplyData;
    [self.myLibraryImages setObject:id_data forKey:serverURL];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:self userInfo:nil];
}



- (void) playVideo:(NSString *)videoURL
{
    NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
    id id_url = videoURL;
    [myDict setObject:id_url forKey:@"URL"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"streamVideo" object:self userInfo:myDict];
  
  
}





@end
