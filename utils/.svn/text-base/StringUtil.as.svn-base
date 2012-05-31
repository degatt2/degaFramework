package dega.utils {


public class StringUtil {
	
	/**
	 * Especifica que la primera letra de cada palabra se convertirá en mayúscula (como en un titular).
	 * <i>"La Casa Gris Del Llano"</i>
	 */
	public static const TITLE : String = "title";
	/**
	 * Especifica que la primera letra de una sentencia, seperada por puntos, será mayúscula.
	 * <i>"Bajó del coche. Piso un charco. Maldijo."</i>
	 */
	public static const SENTENCE : String = "sentence";

	/**
	 * Devuelve una copia de esta cadena capitalizada según el tipo especificado (convierte la primera letra de una palabra en mayúscula, dado el caso).
	 * @param s Cadena de texto
	 * @param type Forma en que se capitalizará la cadena (por defecto sólo la primera letra)
	 * @return Una copia de esta cadena
	 * @example
	 * <listing version="3.0">
	 * import jp.raohmaru.utils.StringUtils;<br>	 * StringUtils.capitalize("En un agujero en el suelo, vivía un hobbit", StringUtil.TITLE);  // "En Un Agujero En El Suelo, Vivía Un Hobbit"	 * StringUtils.capitalize("empezó a contar: uno. dos. tres.", StringUtil.SENTENCE);  // "Empezó a contar: uno. Dos. Tres."</listing>
	 */
	public static function capitalize(str : String, type : String = null) : String {
		var arr : Array;

		switch(type)
		{
			case "title":		//"La Casa Gris Del Llano"
				arr = str.split(" ");
				arr.forEach(toUpperCaseFirstLetter);
				str = arr.join(" ");
				break;

			case "sentence":	//"Bajó del coche. Piso un charco. Maldijo."
				arr = str.split(". ");
				arr.forEach(toUpperCaseFirstLetter);
				str = arr.join(". ");
				break;

			default:			//"Torre en la montaña. disparos..."
				str = toUpperCaseFirstLetter(str);
		}

		return str;
	}

	/**
	 * Convierte en mayúscula la primera letra de la cadena y devuelve una copia. Utilizada en el método <code>Array.forEach</code> de la función <code>capitalize</code>
	 * @param str Cadena a modificar
	 * @return Cadena modificada
	 * @see #capitalize()
	 */
	public static function toUpperCaseFirstLetter(str:String, index:int=0, arr:Array=null) : String
	{
		str = str.replace( /([a-zA-ZàáäèéëìíïòóöùúüÀÁÄÈÉËÌÍÏÒÓÖÙÚÜ])/, function() : String
		{
			return arguments[1].toUpperCase();
		} );

		if(arr) arr[index] = str;

		return str;
	}

	/**
	 * Convierte un valor numérico en un cadena con el número de dígitos especificados, añadiendo "0" hasta llegar a la longitud deseada.
	 * @param number Número a convertir.
	 * @param num_digits Número de dígitos que tendrá la cadena resultante.
	 * @param suffix Indica si los nuevos dígitos se deben insertar antes (<code>false</code>) o después (<code>true</code>) del número.
	 * @return La cadena resultante
	 * @example
	 * <listing version="3.0">StringUtils.toDigits(4, 2);  // "04"</listing>
	 */
	public static function toDigits(number : Object, num_digits : int = 2, suffix :Boolean = false) : String
	{
		var str : String = number.toString();
		while(str.length < num_digits)
			str = (!suffix) ? "0" + str : str + "0";
		return str;
	}

	/**
	 * Devuelva una copia de la cadena con el orden invertido.
	 * @param str Cadena original
	 * @return Cadena invertida
	 */
	public static function reverse(str : String) : String
	{
		return str.split("").reverse().join("");
	}

	/**
	 * Elimina de la cadena los caracteres especificados, y devuelva una copia.<br>Por defecto elimina los espacios.
	 * @param str Cadena original
	 * @param char Matriz con los caracteres a eliminar
	 * @return Una cadena sin los caracteres especificados
	 */
	public static function trim(str : String, chars : Array = null) : String
	{
		if(!chars) chars = [" "];

		for(var i:int=0; i<chars.length; i++)
			str = str.split(chars [i]).join("");

		return str;
	}

    /**
     * Quita las etiquetas HTML de la cadena especificada y devuelve una nueva cadena sin formato HTML.
     * @param source Una cadena con etiquetas HTML
     * @return Una nueva cadena sin formato HTML
     * @source Basado en el método com.ericfeminella.utils.StringUtils.removeHTML() de Eric J. Feminella <http://www.newcommerce.ca/>
     */
    public static function removeHTML(source :String) :String
    {
        var pattern:RegExp = /<[^>]*>/g;
        return source.replace(pattern, "");
    }

	/**
	 * Reemplaza los caracteres HTML de una cadena por valores Unicode que sí puede renderizar correctamente Flash.
	 * También reemplaza las etiquetas <code>&lt;strong&gt;</code> y <code>&lt;em&gt;</code> por <code>&lt;b&gt;</code> e <code>&lt;i&gt;</code> respectivamente.
	 * @param str Cadena a analizar y reemplazar las ocurrencias.
	 * @return Una nueva cadena con los caracteres HTML reemplazados por valores Unicode.
	 */
	public static function parseHTML(str :String) : String
	{
		// Remplaza las etiquetas <strong> y <em> que dreamweaver utiliza en lugar de <b> y <i>
		str = str.replace(new RegExp("strong>", "g"), "b>").replace(new RegExp("em>", "g"), "i>");
		var regexp :RegExp;

		for each (var ent : XML in HTMLEntities.ENTITIES.entity)
		{
			regexp = new RegExp("&"+ent.@code+";", "g");
			str = str.replace(regexp, ent.text());
		}

		return str;
	}

	/**
	 * Elimina los saltos de carro "extra" de una cadena obtenida de un nodo de texto de un XML.
	 * Por alguna razón, Flash Player interpreta los saltos de carro en un nodo texto de XML como dobles.
	 * @param str Cadena con saltos de carro "extra" procedene de un XML.
	 * @return Una nueva cadena con los saltos de carro adicionales eliminados.
	 * @example
	 * <listing version="3.0">
	 var str :String = someXML.thenode.text();
	 trace(str);
	 // Lorem ipsum dolor sit amet,	 // 	 // consectetur adipiscing elit. Nam malesuada laoreet purus...	 // 	 // Nam malesuada laoreet purus...
	  
	 str = StringUtil.removeXMLNewLines(str)
	 trace(str);
	 // Lorem ipsum dolor sit amet, 
	 // consectetur adipiscing elit. Nam malesuada laoreet purus... 
	 // Nam malesuada laoreet purus...</listing>
	 */
	public static function removeXMLNewLines(str :String) : String
	{
		return str.replace(/\r/g, "");
	}
}
}