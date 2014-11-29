# FlashSocket.IO 1.0.6

This fork of FlashSocket.io adds support for Flash Player 11 with native JSON parsing and updates the Web Socket Library. This version of FlashSocket.io is compatable with Socket.io 1.0.6.

You will need a socket policy server to connect your application to your server. I got you covered here too, check my other repository here, https://github.com/EddieOne/nodejs-flash-socket-policy

In your socket.io server, setup the polling transport

```js
io.set('transports', ['websocket', 'flashsocket', 'htmlfile', 'xhr-polling', 'jsonp-polling', 'polling']);
```

Once you have your policy server up and your socket.io server going, check InOut.as file for useage

###InOut.as

```as3
package  {
	import com.pnwrain.flashsocket.FlashSocket;
	import com.pnwrain.flashsocket.events.FlashSocketEvent;
	import flash.events.*;
	
	public class InOut {
		public var sock:FlashSocket;

		public function InOut() {
			this.sock = new FlashSocket("192.0.0.1:8080", true);
			this.sock.addEventListener(FlashSocketEvent.CONNECT, onConnection);
			this.sock.addEventListener(FlashSocketEvent.MESSAGE, onMessage);
			this.sock.addEventListener(FlashSocketEvent.SECURITY_ERROR, onSecurityError);
			this.sock.addEventListener(FlashSocketEvent.IO_ERROR, onIOError);
			this.sock.addEventListener(FlashSocketEvent.CONNECT_ERROR, onConnectError);
			this.sock.addEventListener(FlashSocketEvent.CLOSE, onClosed);
			this.sock.addEventListener(FlashSocketEvent.DISCONNECT, onDisconnect);

			this.sock.addEventListener("custom event", onLogin);
			
		}
		private function onConnection(e:*){
			trace('connected');
			trace(e);
		}
		private function onMessage(e:*){
			trace('new message');
			trace(e);
		}
		private function onSecurityError(e:*){
			trace('security error');
			trace(e);
		}
		private function onIOError(e:*){
			trace(' io error');
			trace(e);
		}
		private function onConnectError(e:*){
			trace('connection error');
			trace(e);
		}
		private function onClosed(e:*){
			trace('closed');
			trace(e);
		}
		private function onDisconnect(e:*){
			trace('disconnected');
			trace(e);
		}
		private function onLogin(e:*){
			trace(e);
		}
	}
}
```