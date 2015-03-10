/*  VideoList: YouTube video list. This class extends array and holds VideoDetail objects
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

class com.abdulqabiz.webapis.youtube.vo.VideoList extends Array implements IValueObject
{

	//static attributes

	//
	//class attributes
	//

	//@see http://www.youtube.com/dev_api_ref?m=youtube.videos.list_by_user
	//@see http://www.youtube.com/dev_api_ref?m=youtube.videos.list_featured
	//@see http://www.youtube.com/dev_api_ref?m=youtube.users.list_favorite_videos
	//@see http://www.youtube.com/dev_api_ref?m=youtube.videos.list_by_tag

	
	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/

	/**
		Method parses the video_list node of YouTube response and populates the VideoList object.

		@method deserialize (public)
		@usage <code>videoList.deserialize (commentNode);</code>
		@param videoListNode (XMLNode) The video_list xml node in YouTube response xml
		@return Void
		@example
			<code>
				videoList.deserialize (videoListNode);
			</code>

		*/
	public function deserialize (videoListNode:XMLNode):Void
	{
		var videoNode:XMLNode = videoListNode.firstChild;
		while (videoNode)
		{
			trace (videoNode.nodeName);
			var videoDetail:VideoDetail = new VideoDetail ();
			videoDetail.deserialize (videoNode);
			push (videoDetail);
			videoNode = videoNode.nextSibling;		
		
		}
	}
}
