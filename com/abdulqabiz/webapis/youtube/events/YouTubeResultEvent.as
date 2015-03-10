/*  YouTubeResultEvent: YouTube result event class
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


import com.abdulqabiz.events.*;
import com.abdulqabiz.vo.*;

class com.abdulqabiz.webapis.youtube.events.YouTubeResultEvent extends Event
{
	//static attributes - event types
	public static var USER_PROFILE_RECIEVED:String = "userProfileRecieved";
	public static var USER_FAVORITE_VIDEO_LIST_RECIEVED:String = "userFavoriteVideoListRecieved";
	public static var USER_FRIEND_LIST_RECIEVED:String = "userFriendListRecieved";
	public static var VIDEO_DETAILS_RECIEVED:String = "videoDetailsRecieved";
	public static var VIDEO_LIST_BY_TAG_RECIEVED:String = "videoListByTagRecieved";
	public static var VIDEO_LIST_BY_USER_RECIEVED:String = "videoListByUserRecieved";
	public static var FEATURED_VIDEO_LIST_RECIEVED:String = "featuredVideoListRecieved";

	//
	//class attributes
	//
	//data holder, it would hold the data recieved by different YouTube events
	public var data:Object = null;	

	/**
		YouTubeResultEvent's constructor function

		@example
			<code>
				new YouTubeResultEvent (YouTubeResultEvent.USER_PROFILE_RECIEVED, data);
			</code>

		*/
	public function YouTubeResultEvent (type:String, data:Object)
	{
		super (type);
		this.data = data;
	}
}
