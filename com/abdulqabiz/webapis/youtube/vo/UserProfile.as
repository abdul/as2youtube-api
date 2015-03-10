/*  UserProfile: A value-object that holds user-profile of YouTube user.
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

class com.abdulqabiz.webapis.youtube.vo.UserProfile implements IValueObject
{

	//
	//class attributes
	//

	//@see http://www.youtube.com/dev_api_ref?m=youtube.users.get_profile
	public var firstName:String = null;
	public var lastName:String = null;
	public var aboutMe:String = null;
	public var age:Number = null;
	public var videoUploadCount:Number = null;
	public var videoWatchCount:Number = null;
	public var homepage:String = null;
	public var hometown:String = null;
	public var gender:String = null;
	public var occupations:String = null;
	public var companies:String = null;
	public var city:String = null;
	public var country:String = null;
	public var books:String = null;
	public var hobbies:String = null;
	public var movies:String = null;
	public var relationship:String = null;
	public var friendCount:Number = null;
	public var favoriteVideoCount:Number = null;
	public var currentlyOn:Boolean = null;
	
	
	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/

	/**
		Method parses the user_profile node and populates the properties of UserProfile vo, i.e. this object.

		@method deserialize (public)
		@usage <code>userProfile.deserialize (userProfileNode);</code>
		@param userProfileNode (XMLNode) The user_profile xml node in YouTube response xml.
		@return Void
		@example
			<code>
				userProfile.deserialize (userProfileNode);
			</code>

		*/
	public function deserialize (userProfileNode:XMLNode):Void
	{
		if (userProfileNode.hasChildNodes ())
		{
			var childNode:XMLNode = userProfileNode.firstChild;
		
			do
			{
				var value = childNode.firstChild.nodeValue;
				switch (childNode.nodeName)
				{
					case "first_name":
						firstName = value;
						break;
					case "last_name":
						lastName = value;
						break;
					case "about_me":
						aboutMe = value;
						break;
					case "age":
						age = Number (value);
						break;
					case "video_upload_count":
						videoUploadCount = Number (value);
						break;
					case "video_watch_count":
						videoWatchCount = Number (value);
						break;
					case "homepage":
						homepage = value;
						break;
					case "hometown":
						hometown = value;
						break;
					case "gender":
						gender = value;
						break;
					case "occupations":
						occupations = value;
						break;
					case "companies":
						companies = value;
						break;
					case "city":
						city = value;
						break;
					case "country":
						country = value;
						break;
					case "books":
						books = value;
						break;
					case "hobbies":
						hobbies = value;
						break;
					case "movies":
						movies = value;
						break;
					case "relationship":
						relationship = value;
						break;
					case "friend_count":
						friendCount = Number (value);
						break;
					case "favorite_video_count":
						favoriteVideoCount = Number (value);
						break;
					case "currently_on":
						currentlyOn = value == "true" ? true : false;
						break;

				}

				childNode = childNode.nextSibling;

			}while (childNode); 
			
		}
	}
}
