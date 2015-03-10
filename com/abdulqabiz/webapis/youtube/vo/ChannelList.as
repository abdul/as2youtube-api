/*  ChannelList: A value object that represent a list of channels.
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

class com.abdulqabiz.webapis.youtube.vo.ChannelList extends Array implements IValueObject
{
	/*__________________________________________________________________________________________________________________

		Public Methods
		__________________________________________________________________________________________________________________
	*/


	/**
		Method parses the channel_list node and populates the properties in ChannelList value-object.

		@method deserialize (public)
		@usage <code>channelList.deserialize (channelListNode);</code>
		@param channelListNode (XMLNode) The channel_list xml node in YouTube response xml
		@return Void
		@example
			<code>
				channelList.deserialize (channelListNode);
			</code>

		*/
	public function deserialize (channelListNode:XMLNode):Void
	{
		var channelNode:XMLNode = channelListNode.firstChild;
		while (channelNode)
		{
			//doesn't contain any child element, just textnode
			push (channelNode.firstChild.nodeValue);
			channelNode = channelNode.nextSibling;		
		
		}
	}
}

