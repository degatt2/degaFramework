package dega.xml {
/**
 * Conjunto de métodos que extienden la funcionalidad de la clase XML
 * @author raohmaru
 * @version 1.2
 */
public class XMLUtil 
{
	/**
	 * Serializa un objeto y devuelve un XML con las propiedades del objeto como pares nodo / valor.
	 * @param source Objeto origen a serializar	 * @param rootNodeName Nombre del nodo principal del XML resultante
	 * @param ns Un nombre de espacios a asignar al XML resultante
	 * @return Un objeto XML creado a partir del objeto especificado 
	 * @example El siguiente ejemplo muestra como se serializa un objeto que contiene otro objeto y una matriz:
	<listing version="3.0">
	import jp.raohmaru.utils.XMLUtil;		var weapons :Object = {
		first : "sword",
		second : "bow",
		shield : false
	}
	var o :Object = {
		name : "Aloê",
		age : 55,
		status : "medium",
		pow : [100, 1290],
		weapons : weapons
	};
	
	var ns :Namespace = new Namespace("rol", "http://raohmaru.com/2008/test")
	var xml :XML = XMLUtil.serialize(o, "character", ns);
		trace( xml.toXMLString() );
	// Outputs:	// &lt;rol:character xmlns:rol=&quot;http://raohmaru.com/2008/test&quot;&gt;
	//   &lt;rol:pow&gt;
	//     &lt;rol:0&gt;100&lt;/rol:0&gt;
	//     &lt;rol:1&gt;1290&lt;/rol:1&gt;
	//   &lt;/rol:pow&gt;
	//   &lt;rol:status&gt;medium&lt;/rol:status&gt;
	//   &lt;rol:weapons&gt;
	//     &lt;rol:second&gt;bow&lt;/rol:second&gt;
	//     &lt;rol:shield&gt;false&lt;/rol:shield&gt;
	//     &lt;rol:first&gt;sword&lt;/rol:first&gt;
	//   &lt;/rol:weapons&gt;
	//   &lt;rol:name&gt;Aloê&lt;/rol:name&gt;
	//   &lt;rol:age&gt;55&lt;/rol:age&gt;
	// &lt;/rol:character&gt;		trace( xml.ns::status );  // medium
	</listing>
	 */
	public static function serialize(source :Object, rootNodeName :String, ns :Namespace = null) :XML
	{
		var xml :XML = new XML(<{rootNodeName}></{rootNodeName}>),
			count :int = 0;
		
		for(var i:String in source)
		{
			xml.appendChild( serialize(source[i], i, ns) );
			count++;
		}
		
		if(count == 0) xml = new XML(<{rootNodeName}>{source}</{rootNodeName}>);
			
		if(ns) xml.setNamespace(ns);
		
		return xml;
	}
	
	/**
	 * Comprueba si el objeto XML o XMLList contiene un nodo del nombre especificado.
	 * @param xml Un objeto XML o XMLList.
	 * @param name El nombre del nodo secundario.
	 * @return Un valor booleano, verdadero si lo contiene y falso en caso contrario.
	 */
	public static function hasNode(xml :Object, name :String) :Boolean
	{
		if( !(xml is XML) && !(xml is XMLList) ) return false;
		
		return (xml[name].length() > 0);
	}

	/**
	 * Comprueba si el objeto XML o XMLList contiene un atributo del nombre especificado.
	 * @param xml Un objeto XML o XMLList.
	 * @param name El nombre del atributo.
	 * @return Un valor booleano, verdadero si lo contiene y falso en caso contrario.
	 */
	public static function hasAttribute(xml :Object, name :String) :Boolean
	{
		if( !(xml is XML) && !(xml is XMLList) ) return false;
		
		return (xml.@[name].length() > 0);
	}
	
	/**
	 * Comprueba si el objeto XML existe, es decir, si es un nodo real de un XML padre.
	 * @param xml Un objeto XML o XMLList.
	 * @return Un valor booleano, verdadero si lo existe y falso en caso contrario.
	 */
	public static function exists(xml :Object) :Boolean
	{
		if( !(xml is XML) && !(xml is XMLList) ) return false;
		
		//return (xml.text().length() > 0 || xml.attributes().length() > 0 || xml.hasComplexContent());
		// Simple pero eficaz
		return (xml.toXMLString() != "");
	}
}
}