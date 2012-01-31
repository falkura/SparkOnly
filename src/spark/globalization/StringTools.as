////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package spark.globalization
{
	
	import flash.globalization.StringTools;
	
	import mx.core.mx_internal;
	
	import spark.globalization.supportClasses.GlobalizationBase;
	
	use namespace mx_internal;
	
	/**
	 *  The <code>StringTools</code> class provides locale-sensitve case
	 *  conversion methods.
	 *
	 *  <p>This class is a wrapper class around the
	 *  <code>flash.globalization.StringTools</code>.
	 *  Therefore, the case conversion functionality is provided by the
	 *  <code>flash.globalization.StringTools</code> class.
	 *  However, this <code>StringTools</code> class can be used in MXML
	 *  declartions, uses the locale style for the requested Locale ID name, and
	 *  has methods and properties that are bindable.
	 *  Additionally, events are generated if there is an error or warning
	 *  generated by the flash.globalization class.</p>
	 *
	 *  <p>The <code>flash.globalization.StringTools</code> class uses the
	 *  underlying operating system for the case conversion functionality and
	 *  on some operating systems, the <code>flash.globalization</code> classes
	 *  are unsupported, this wrapper class provides fallback that makes use of
	 *  the case conversion provided by the <code>String</code> class.</p>
	 *
	 *  @includeExample examples/StringToolsExample.mxml
	 *
	 *  @see flash.globalization.StringTools
	 * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.1
	 *  @playerversion AIR 2.5
	 *  @productversion Flex 4.5
	 */
	public class StringTools extends GlobalizationBase
	{
		include "../core/Version.as";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructs a new StringTools object that provides case conversion and
		 *  other utilities according to the conventions of a given locale.
		 *
		 *  The locale for this class is supplied by the locale style.
		 *  The locale style can be set in several ways:
		 *
		 *  <ul>
		 *  <li>Inheriting the style from a <code>UIComponent</code> by calling the
		 *  UIComponent's addStyleClient method.</li>
		 *
		 *  <li>By using the class in an MXML declaration and inheriting the
		 *  locale from the document that contains the declaration.
		 *  Example:
		 *  <pre>
		 *  &lt;fx:Declarations&gt;
		 *         &lt;s:StringTools id="st" /&gt;
		 *  &lt;/fx:Declarations&gt;
		 *  </pre>
		 *  </li>
		 *
		 *  <li>By using an MXML declaration and specifying the locale value in
		 *  the list of assignments.
		 *  Example:
		 *  <pre>
		 *  &lt;fx:Declarations&gt;
		 *      &lt;s:StringTools id="st_turkish" locale="tr-TR" /&gt;
		 *  &lt;/fx:Declarations&gt;
		 *  </pre>
		 *  </li>
		 *
		 *  <li>Calling the setStyle method, e.g.
		 *  <code>st.setStyle("locale", "tr-TR")</code></li>
		 *  </ul>
		 *
		 *  <p>
		 *  If the <code>locale</code> style is not set by one of the above 
		 *  techniques, the instance of this class will be added as a 
		 *  <code>StyleClient</code> to the <code>topLevelApplication</code> and 
		 *  will therefore inherit the <code>locale</code> style from the 
		 *  <code>topLevelApplication</code> object when the <code>locale</code> 
		 *  dependent property getter or <code>locale</code> dependent method is 
		 *  called.
		 *  </p>   
		 *
		 *  @see flash.globalization.StringTools
		 *  
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		public function StringTools()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Actual instance of the working flash.globalization.StringTools
		 *  instance.
		 */
		private var _g11nWorkingInstance:flash.globalization.StringTools;
		
		/**
		 *  @private
		 *  If the g11nWorkingInstance has not been defined. Call
		 *  ensureStyleSource to ensure that there is a styleParent. If there is
		 *  not a style parent, then this instance will be added as a style client
		 *  to the topLevelApplication. As a side effect of this, the styleChanged
		 *  method will be called and if there is a locale style defined for the
		 *  topLevelApplication, the createWorkingInstance method will be
		 *  executed creating a g11nWorkingInstance.
		 */
		private function get g11nWorkingInstance ():
			flash.globalization.StringTools
		{
			if (!_g11nWorkingInstance)
				ensureStyleSource();
			
			return _g11nWorkingInstance;
		}
		
		private function set g11nWorkingInstance 
			(flashStringTools:flash.globalization.StringTools): void 
		{
			_g11nWorkingInstance = flashStringTools;
		}
		//--------------------------------------------------------------------------
		//
		//  Overridden Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  actualLocaleIDName
		//----------------------------------
		
		[Bindable("change")]
		
		/**
		 *  @inheritDoc
		 *
		 *  @see flash.globalization.StringTools.actualLocaleIDName
		 *  @see #StringTools()
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		override public function get actualLocaleIDName():String
		{
			if (g11nWorkingInstance)
				return g11nWorkingInstance.actualLocaleIDName;
			
			if ((localeStyle === undefined) || (localeStyle === null))
			{
				fallbackLastOperationStatus
				= LastOperationStatus.LOCALE_UNDEFINED_ERROR;
				return undefined;
			}
			
			fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;
			
			return "en-US";
		}
		
		//----------------------------------
		//  lastOperationStatus
		//----------------------------------
		
		[Bindable("change")]
		
		/**
		 *  @inheritDoc
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		override public function get lastOperationStatus():String
		{
			return g11nWorkingInstance ?
				g11nWorkingInstance.lastOperationStatus :
				fallbackLastOperationStatus;
		}
		
		//----------------------------------
		//  useFallback
		//----------------------------------
		
		[Bindable("change")]
		
		/**
		 *  @private
		 */
		override mx_internal function get useFallback():Boolean
		{
			return g11nWorkingInstance == null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override mx_internal function createWorkingInstance():void
		{
			if ((localeStyle === undefined) || (localeStyle === null))
			{
				fallbackLastOperationStatus
				= LastOperationStatus.LOCALE_UNDEFINED_ERROR;
				g11nWorkingInstance = null;
				return;
			}
			
			if (enforceFallback)
			{
				fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;
				g11nWorkingInstance = null;
				return;
			}
			
			g11nWorkingInstance = new flash.globalization.StringTools(localeStyle);
			if (g11nWorkingInstance
				&& (g11nWorkingInstance.lastOperationStatus
					!= LastOperationStatus.UNSUPPORTED_ERROR))
			{
				propagateBasicProperties(g11nWorkingInstance);
				return;
			}
			
			fallbackLastOperationStatus = LastOperationStatus.USING_FALLBACK_WARNING;
			g11nWorkingInstance = null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		[Bindable("change")]
		
		/**
		 *  Converts a string to lowercase according to language conventions.
		 *
		 *  Depending on the locale, the output string length can differ from the
		 *  input string length.
		 *
		 *  @param s <code>String</code> to convert to lowercase.
		 *  @return The converted lowercase string.
		 *
		 *  @see flash.globalization.StringTools
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		public function toLowerCase(s:String):String
		{
			
			if (g11nWorkingInstance)
				return g11nWorkingInstance.toLowerCase(s);
			
			if ((localeStyle === undefined) || (localeStyle === null))
			{
				fallbackLastOperationStatus
				= LastOperationStatus.LOCALE_UNDEFINED_ERROR;
				return undefined;
			}
			
			fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;
			
			return s.toLowerCase();
		}
		
		[Bindable("change")]
		
		/**
		 *  Converts a string to uppercase according to language conventions.
		 *
		 *  Depending on the locale, the output string length can differ from the
		 *  input string length.
		 *
		 *  @param s <code>String</code> to convert to uppercase.
		 *  @return The converted uppercase string.
		 *
		 *  @see flash.globalization.StringTools
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		public function toUpperCase(s:String):String
		{
			if (g11nWorkingInstance)
				return g11nWorkingInstance.toUpperCase(s);
			
			if ((localeStyle === undefined) || (localeStyle === null))
			{
				fallbackLastOperationStatus
				= LastOperationStatus.LOCALE_UNDEFINED_ERROR;
				return undefined;
			}
			
			fallbackLastOperationStatus = LastOperationStatus.NO_ERROR;
			
			return s.toUpperCase();
		}
		
		/**
		 *  @copy spark.globalization.supportClasses.CollatorBase#getAvailableLocaleIDNames()
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.1
		 *  @playerversion AIR 2.5
		 *  @productversion Flex 4.5
		 */
		public static function getAvailableLocaleIDNames():Vector.<String>
		{
			const locales:Vector.<String>
			= flash.globalization.Collator.getAvailableLocaleIDNames();
			
			return locales ? locales : new Vector.<String>["en-US"];
		}
	}
}