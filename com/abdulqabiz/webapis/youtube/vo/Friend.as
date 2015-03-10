/*  Friend: A value-object that holds details of user's friend in YouTube.
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

class com.abdulqabiz.webapis.youtube.vo.Friend implements IValueObject
{

	//
	//class attributes
	//
	public var user:String = null;
	public var videoUploadCount:Number = null;
	public var favoriteCount:Number = null;
	public var friendCount:Number = null;
	
	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/
	
	/**
		Method parses the friend node and populates Friend value object,i.e. this object

		@method deserialize (public)
		@usage <code>friend.deserialize (friendNode);</code>
		@param friendNode (XMLNode) The friend xml node in YouTube response xml.
		@return Void
		@example
			<code>
				friend.deserialize (friendNode);
			</code>

		*/
	public function deserialize (friendNode:XMLNode):Void
	{
		if (friendNode.hasChildNodes ())
		{
			var childNode:XMLNode = friendNode.firstChild;
		
			do
			{
				var value = childNode.firstChild.nodeValue;
				switch (childNode.nodeName)
				{
					case "user":
						user = value;
						break;
					case "video_upload_count":
						videoUploadCount = Number (value);
						break;
					case "favorite_count":
						favoriteCount = Number (value);
						break;
					case "friend_count":
						friendCount = Number (value);
						break;
				}

				childNode = childNode.nextSibling;

			}while (childNode); 
			
		}
	}
	
}
