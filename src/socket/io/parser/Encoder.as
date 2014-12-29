package socket.io.parser
{

/**
 * ...
 * @author Robin Wilding
 */
public class Encoder
{
	var debug;
	
	public function Encoder(debug)
	{
		this.debug = debug;
	}
	
	/**
	 * Encode a packet as a single string if non-binary, or as a
	 * buffer sequence, depending on packet type.
	 *
	 * @param {Object} obj - packet object
	 * @param {Function} callback - function to handle encodings (likely engine.write)
	 * @return Calls callback with Array of encodings
	 * @api public
	 */
	public function encode(obj:*, callback:Function):void
	{
		if(debug){
			trace('encoding packet ', obj);
		}
		
		if (obj.type == null)
			throw(new Error("Incorrect object type"));
		
		if (Parser.BINARY_EVENT == obj.type || Parser.BINARY_ACK == obj.type)
		{
			throw(new Error("Encoder Does not support binary data"));
		}
		else
		{
			var encoding:String = encodeAsString(obj);
			callback([encoding]);
		}
	}
	
	public function encodeAsString(obj:*):String
	{
		var str:String = '4';
		var nsp:Boolean = false;
		
		// first is type
		str += obj.type;
		
		// attachments if we have them
		// RW Unsupported Binary
		/*if (exports.BINARY_EVENT == obj.type || exports.BINARY_ACK == obj.type)
		   {
		   str += obj.attachments;
		   str += '-';
		 }*/
		
		// if we have a namespace other than `/`
		// we append it followed by a comma `,`
		if (obj.nsp && '/' != obj.nsp)
		{
			nsp = true;
			if(debug){
				trace( "nsp : " + nsp );
			}
			str += obj.nsp;
			if(debug){
				trace( "obj.nsp : " + obj.nsp );
			}
		}
		
		// immediately followed by the id
		if (null != obj.id)
		{
			if (nsp)
			{
				str += ',';
				nsp = false;
			}
			str += obj.id;
		}
		
		// json data
		if (null != obj.data)
		{
			if (nsp)
				str += ',';
			str += JSON.stringify(obj.data);
		}
		
		if(debug){
			trace('encoded ' + obj + ' as ' + str);
		}
		return str;
	}

}

}