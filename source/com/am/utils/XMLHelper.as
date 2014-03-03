package com.am.utils {

	/**
	 * @author Adrian C. Miranda <adriancmiranda@gmail.com>
	 */
	public final class XMLHelper {

		public static function cdata(data:String):XML {
			return new XML('<![CDATA[' + data + ']]>');
		}

		public static function mergeXML(source:XML, toMerge:XML):XML {
			// toMerge argument must not be null
			if (source == null) {
				return toMerge;
			}
			var nameSpaces:Array = toMerge.namespaceDeclarations();
			for each (var nameSpace:Namespace in nameSpaces) {
				if (source.namespace(nameSpace) === undefined) {
					source = source.addNamespace(nameSpace);
				}
			}
			var childNodes:XMLList = toMerge.children().copy();
			source.appendChild(childNodes);
			return source;
		}
	}
}
