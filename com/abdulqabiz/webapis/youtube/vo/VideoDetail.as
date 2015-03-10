/*  VideoDetail: A value-object that holds details of a YouTube video.
 *  Author:  Abdul Qabiz (mail@abdulqabiz.com) 
 *  Date:    Nov 25, 2006
 *  Version: 0.1
 *
 *  Copyright (c) 2006 Abdul Qabiz (http://www.abdulqabiz.com)
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a
 *  copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *  DEALINGS IN THE SOFTWARE.  
 */

import com.abdulqabiz.vo.*;
import com.abdulqabiz.webapis.youtube.vo.*;

class com.abdulqabiz.webapis.youtube.vo.VideoDetail implements IValueObject
{

	//
	//class attributes
	//
	
	//@see http://www.youtube.com/dev_api_ref?m=youtube.videos.get_details
	public var author:String = null;
	public var title:String = null;
	public var ratingAvg:Number = null;
	public var ratingCount:Number = null;
	public var tags:String = null;
	public var description:String = null;
	public var updateTime:Number = null;	
	public var viewCount:Number = null;
	public var uploadTime:Number = null;
	public var lengthInSeconds:Number = null;
	public var recordingDate:String = null;
	public var recordingLocation:String = null;
	public var recordingCountry:String = null;
	public var commentList:CommentList /* of Comment */ = null;
	public var channelList:ChannelList /* of String */ = null;
	public var thumbnailUrl:String = null;

	public var id:String = null;
	public var url:String = null;
	public var commentCount:Number = null;

	
	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/

	/**
		Method parses the video_details node and populates the properties of VideoDetail vo, i.e. this object.

		@method deserialize (public)
		@usage <code>videoDetail.deserialize (videoDetailsNode);</code>
		@param videoDetailsNode (XMLNode) The video_details xml node in YouTube response xml.
		@return Void
		@example
			<code>
				videoDetail.deserialize (videoDetailNode);
			</code>

		*/
	public function deserialize (videoDetailsNode:XMLNode):Void
	{
		if (videoDetailsNode.hasChildNodes ())
		{
			var childNode:XMLNode = videoDetailsNode.firstChild;
		
			do
			{
				var value = childNode.firstChild.nodeValue;
				switch (childNode.nodeName)
				{
					case "author":
						author = value;
						break;
					case "id":
						id = value;
						break;
					case "title":
						title = value;
						break;
					case "length_seconds":
						lengthInSeconds = Number (value);
						break;
					case "rating_avg":
						ratingAvg = Number (value);
						break;
					case "rating_count":
						ratingCount = Number (value);
						break;
					case "description":
						description = value;
						break;
					case "view_count":
						viewCount = Number (value);
						break;
					case "upload_time":
						uploadTime = Number (value);
						break;
					case "comment_count":
						commentCount = Number (value);
						break;
					case "tags":
						tags = value;
						break;
					case "url":
						url = value;
						break;
					case "thumbnail_url":
						thumbnailUrl = value;
						break;
					case "update_time":
						updateTime = Number (value);
						break;
					case "recording_date":
						recordingDate = value;
						break;
					case "recording_location":
						recordingLocation = value;
						break;
					case "recording_country":
						recordingCountry = value;
						break;
					case "comment_list":
						commentList = new CommentList ();
						commentList.deserialize (childNode);
						break;
					case "channel_list":
						channelList = new ChannelList ();
						channelList.deserialize (childNode);
						break;

				}

				childNode = childNode.nextSibling;

			}while (childNode); 
			
		}
	}
}
