/*  YouTubeService: This is main class that can be used to access YouTube webservices. Check out Public Methods sections.
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

import com.abdulqabiz.webapis.*;
import com.abdulqabiz.vo.*;
import com.abdulqabiz.webapis.youtube.vo.*;
import com.abdulqabiz.webapis.youtube.events.*;
import mx.utils.*;

class com.abdulqabiz.webapis.youtube.YouTubeService extends com.abdulqabiz.webapis.ServiceBase
{
	//static attributes

	//YouTube REST endpoint
	public static var YOUTUBE_ENDPOINT:String = "http://www.youtube.com/api2_rest";

	//
	//static methods
	//

	public static function constructRestUrl (params:Object):String
	{
		var url:String = YOUTUBE_ENDPOINT + "?";

		for (var p in params)
		{
			url += p + "=" + params[p] + "&";
		}
		return url;
	}



	//
	//class attributes
	//
	private var devId:String = null;
	private var parser:XML;
	private var loader:LoadVars;

	//event handler delegates, this avoids delegate creation again and again.
	private var getUserProfileDelegate:Function;
	private var getUserFavoriteVideoListDelegate:Function;
	private var getVideoDetailsDelegate:Function;
	private var getUserFriendListDelegate:Function;
	private var getVideoListByTagDelegate:Function;
	private var getVideoListByUserDelegate:Function;
	private var getFeaturedVideoListDelegate:Function;

	/**
		YouTubeService's constructor function
		@param devId (String) YouTube developer id, this is mandatory param,
				if it's wrong or not passed, none of methods would work
		@example
			<code>
				new YouTubeService (devId);
			</code>

		*/

	public function YouTubeService (devId:String)
	{
		super ();
		this.devId = devId;
		parser = new XML ();
		parser.ignoreWhite = true;

		getUserProfileDelegate = Delegate.create (this, getUserProfileResult);
		getUserFavoriteVideoListDelegate = Delegate.create (this, getUserFavoriteVideoListResult);
		getVideoDetailsDelegate = Delegate.create (this, getVideoDetailsResult);
		getUserFriendListDelegate = Delegate.create (this, getUserFriendListResult);
		getVideoListByTagDelegate = Delegate.create (this, getVideoListByTagResult);
		getVideoListByUserDelegate = Delegate.create (this, getVideoListByUserResult);
		getFeaturedVideoListDelegate = Delegate.create (this, getFeaturedVideoListResult);
	}

	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/


	/**
		Method invokes youtube.users.get_profile method of YouTube webservice and gets the details of a user.
		@method getUserProfile (public)
		@usage <code>service.getUserProfile (username);</code>
		@param userName (String) The username of YouTube user, you wish to get details of.
		@return Void
		@example
			<code>
				service.getUserProfile ("abdulqabiz");
			</code>
		@see YouTubeResultEvent#USER_PROFILE_RECIEVED

		*/
	public function getUserProfile (userName:String):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =  getUserProfileDelegate;
		loader.load (constructRestUrl ({method:"youtube.users.get_profile", user:userName, dev_id:devId}));
	}
	/**
		Method invokes youtube.users.list_favorite_videos method of YouTube webservice and gets favorite video list.
		@method getUserFavoriteVideoList (public)
		@usage <code>service.getUserFavoriteVideoList (username);</code>
		@param userName (String) The username of YouTube user, whose favorite video list you are requesting.
		@return Void
		@example
			<code>
				service.getUserFavoriteVideoList ("abdulqabiz");
			</code>
		@see YouTubeResultEvent#USER_FAVORITE_VIDEO_LIST_RECIEVED

		*/
	public function getUserFavoriteVideoList (userName:String):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =   getUserFavoriteVideoListDelegate;
		loader.load (constructRestUrl ({method:"youtube.users.list_favorite_videos", user:userName, dev_id:devId}));
	}
	/**
		Method invokes youtube.users.list_friends method of YouTube webservice and gets list of friend for a YouTube user.
		@method getUserFriendList (public)
		@usage <code>service.getUserFriendList (username);</code>
		@param userName (String) The username of YouTube user, whose friend list you are requesting.
		@return Void
		@example
			<code>
				service.getUserFriendList ("abdulqabiz");
			</code>
		@see YouTubeResultEvent#USER_FRIEND_LIST_RECIEVED

		*/
	public function getUserFriendList (userName:String):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =   getUserFriendListDelegate;
		loader.load (constructRestUrl ({method:"youtube.users.list_friends", user:userName, dev_id:devId}));
	}
	/**
		Method invokes youtube.videos.get_details method of YouTube webservice and gets details of a video.
		@method getVideoDetails (public)
		@usage <code>service.getVideoDetails (username);</code>
		@param videoId (String) The video_id of YouTube video.
		@return Void
		@example
			<code>
				service.getVideoDetails ("2z2kcVn_ID0");
			</code>
		@see YouTubeResultEvent#VIDEO_DETAILS_RECIEVED

		*/
	public function getVideoDetails (videoId:String):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =   getVideoDetailsDelegate;
		loader.load (constructRestUrl ({method:"youtube.videos.get_details", video_id:videoId, dev_id:devId}));
	}
	/**
		Method invokes youtube.videos.list_by_tag method of YouTube webservice and gets video-list by tags.
		@method getVideoListByTag (public)
		@usage <code>service.getVideoListByTag (username);</code>
		@param tag (String) The space separated list of tags. This is required.
		@param pageSize (Number) The page-size of a page if there are many results. Optional.
		@param currentPage (Number) The current page, if there are many pages. Optinal.
		@return Void
		@example
			<code>
				service.getVideoListByTag ("india pune", 20, 1);
			</code>
		@see YouTubeResultEvent#VIDEO_LIST_BY_TAG_RECIEVED

		*/
	public function getVideoListByTag (tag:String, pageSize:Number, currentPage:Number):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =  getVideoListByTagDelegate;
		var params:Object = {method:"youtube.videos.list_by_tag", tag:tag, dev_id:devId};

		if (!isNaN (pageSize))
		{getUserProfile
			params.per_page = pageSize;
		}

		if (!isNaN (currentPage))
		{
			params.page = currentPage;
		}
		loader.load (constructRestUrl (params));
	}

	/**
		Method invokes youtube.videos.list_by_user method of YouTube webservice and gets video-list by user name.
		@method getVideoListByUser (public)
		@usage <code>service.getVideoListByTag (username);</code>
		@param userName (String) The YouTube user name, whose video list you are requesting.
		@return Void
		@example
			<code>
				service.getVideoListByUser ("abdulqabiz");
			</code>
		@see YouTubeResultEvent#VIDEO_LIST_BY_USER_RECIEVED

		*/
	public function getVideoListByUser (userName:String):Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =  getVideoListByUserDelegate;
		loader.load (constructRestUrl ({method:"youtube.videos.list_by_user", user:userName, dev_id:devId}));
	}
	/**
		Method invokes youtube.videos.list_featured method of YouTube webservice
			 to get the list oftop twenty-five (25) YouTube Videos.
		@method getFeaturedVideoList (public)
		@usage <code>service.getFeaturedVideoList ();</code>
		@return Void
		@example
			<code>
				service.getFeaturedVideoList ();
			</code>
		@see YouTubeResultEvent#FEATURED_VIDEO_LIST_RECIEVED

		*/
	public function getFeaturedVideoList ():Void
	{
		var loader:LoadVars = getLoader ();
		loader.busy = true;
		loader.onData =  getFeaturedVideoListDelegate;
		loader.load (constructRestUrl ({method:"youtube.videos.list_featured", dev_id:devId}));
	}
	
	/*__________________________________________________________________________________________________________________

		Private Methods
		__________________________________________________________________________________________________________________
	*/

	/* 
		Helper function to create loader (LoadVars in this case)
		*/
	private function getLoader ():LoadVars
	{
		if (!loader)
		{
			loader = new LoadVars ();
		}
		else if (loader.busy)
		{
			dispatchYouTubeFaultEvent (YouTubeFaultEvent.ERROR, -1, "Another request is in progress, please try later..");
			return;
			//return new LoadVars ();
		}
		
		return loader;
		
	}

	/* 
		Helper function to create XML object.
		*/

	private function getParser ():XML
	{
		if (!parser)
		{
			parser = new XML ();
			parser.ignoreWhite = true;
		}
		else if (parser["busy"])
		{
			new XML ();
		}

		return parser;
	}

	/*
		Handles the result corresponding to getUserProfile (..) call.
		Dispatches YouTubeResultEvent#USER_PROFILE_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	private function getUserProfileResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var userProfile:UserProfile = new UserProfile ();
			userProfile.deserialize (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.USER_PROFILE_RECIEVED, userProfile);
		}
		else
		{
			handleError (resultObject.result);
		}
	}
	/*
		Handles the result corresponding to getUserFavoriteVideoList (..) call.
		Dispatches YouTubeResultEvent#USER_FAVORITE_VIDEO_LIST_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	private function getUserFavoriteVideoListResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var videoList:Array = getVideoList (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.USER_FAVORITE_VIDEO_LIST_RECIEVED, videoList);
		}
		else
		{
			handleError (resultObject.result);
		}
	}

	/*
		Handles the result corresponding to getUserFriendList (..) call.
		Dispatches YouTubeResultEvent#USER_FRIEND_LIST_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	public function getUserFriendListResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var friendList:Array = new FriendList ();
			friendList.deserialize (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.USER_FRIEND_LIST_RECIEVED, friendList);
		}
		else
		{
			handleError (resultObject.result);
		}
	}
	/*
		Handles the result corresponding to getVideoDetails (..) call.
		Dispatches YouTubeResultEvent#VIDEO_DETAILS_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	public function getVideoDetailsResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var videoDetail:VideoDetail = new VideoDetail ();
			videoDetail.deserialize (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.VIDEO_DETAILS_RECIEVED, videoDetail);
		}
		else
		{
			handleError (resultObject.result);
		}
	}
	/*
		Handles the result corresponding to getVideoListByTag (..) call.
		Dispatches YouTubeResultEvent#VIDEO_LIST_BY_TAG_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	public function getVideoListByTagResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var videoList:VideoList = getVideoList (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.VIDEO_LIST_BY_TAG_RECIEVED, videoList);
		}
		else
		{
			handleError (resultObject.result);
		}
	}
	/*
		Handles the result corresponding to getVideoListByUser (..) call.
		Dispatches YouTubeResultEvent#VIDEO_LIST_BY_USER_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	public function getVideoListByUserResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var videoList:VideoList = getVideoList (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.VIDEO_LIST_BY_USER_RECIEVED, videoList);	
		}
		else
		{
			handleError (resultObject.result);
		}
	}
	/*
		Handles the result corresponding to getFeaturedVideoList (..) call.
		Dispatches YouTubeResultEvent#FEATURED_VIDEO_LIST_RECIEVED or YouTubeFaultEvent#ERROR.
		*/
	public function getFeaturedVideoListResult (result:String):Void
	{
		loader.busy = false;
		var resultObject:Object = getResultObject (result);
		if (resultObject.status == "ok")
		{
			var videoList:VideoList = getVideoList (resultObject.result);
			dispatchYouTubeResultEvent (YouTubeResultEvent.FEATURED_VIDEO_LIST_RECIEVED, videoList);

		}
		else
		{
			handleError (resultObject.result);
		}
	}

	/*
		Helper function used to dispatch different YouTubeResultEvent.
		*/

	private function dispatchYouTubeResultEvent (type:String, data:Object):Void
	{
		var event:YouTubeResultEvent = new YouTubeResultEvent ();
		event.type = type;
		event.target = this;
		event.data = data;
		dispatchEvent (event);
	}

	/*
		Helper function used to dispatch different YouTubeFaultEvent.
		*/

	private function dispatchYouTubeFaultEvent (type:String, code:Number, description:String):Void
	{
		var event:YouTubeFaultEvent = new YouTubeFaultEvent ();
		event.type = type;
		event.target = this;
		event.code = code;
		event.description = description;
		dispatchEvent (event);
	}
	
	/*
		Helper that returns an object with status code and content xml.
		*/
	private function getResultObject (result:String):Object
	{
		var parser:XML = getParser ();
		parser["busy"] = true;
		parser.parseXML (result);
		parser["busy"] = false;
		var responseNode:XMLNode = parser.firstChild;
		var status:String = responseNode.attributes.status;
		return {status:status, result:responseNode.firstChild};
	}

	private function handleError (errorXML:XMLNode):Void
	{
		if (errorXML.hasChildNodes ())
		{
			var childNode:XMLNode = errorXML.firstChild;
			var code:Number = null;
			var description:String = null;
			do 
			{
				var value = childNode.firstChild.nodeValue;
				switch (childNode.nodeName)
				{
					case "code":
						code = Number (value);
						break;
					case "description":
						description = value;
						break
				}
				childNode = childNode.nextSibling;
			}while (childNode);

			dispatchYouTubeFaultEvent (YouTubeFaultEvent.ERROR, code, description);
		}


	}

	/*
		Helper function to get the VideoList. Used in many occasions, hence logic is separated.
		*/
	private function getVideoList (videoListNode:XMLNode):VideoList
	{
		var videoList = new VideoList ();
		videoList.deserialize (videoListNode);
		return videoList;
	}



}

