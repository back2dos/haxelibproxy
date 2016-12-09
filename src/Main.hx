package;

import haxe.io.BytesOutput;
import haxe.remoting.Context;
import haxe.remoting.HttpConnection;
import haxe.zip.Entry;
import haxe.zip.Tools;
import haxe.zip.Writer;

class Main {
	static var SERVER = {
		host : "lib.haxe.org",
		port : 80,
		dir : "",
		url : "index.n",
		apiVersion : "3.0",
	};  
	
	static function main() {
    
    var ctx = new Context();
		var siteUrl = "http://" + SERVER.host + ":" + SERVER.port + "/" + SERVER.dir;
		var remotingUrl =  siteUrl + "api/" + SERVER.apiVersion + "/" + SERVER.url;
    
    var proxy = new Proxy(haxe.remoting.HttpConnection.urlConnect(remotingUrl).api);
    ctx.addObject("api",proxy );
		
    foxhole.Web.run({
      handler: function () {
        switch foxhole.Web.getParams()['__x'] {
          case null:
            switch (foxhole.Web.getURI() : tink.Url).path.parts().map(function (s):String return s) {
              case ['files', '3.0', file]: 
                Sys.print(proxy.getZip(file));
              default:
                Sys.println('hoho!');
            }
          case v:
            Sys.println(HttpConnection.processRequest(v, ctx));
        }
      },
      port: 8000,
      watch: true,
    });
	}
	
}