component {
	this.name       = "websocket-example";
	this.wschannels = [
		{ name:"dashboard" },
		{ name:"protected", cfclistener:"ProtectedChannelListener" }
	];

	public boolean function onRequestStart( string targetPage ) {
		if ( url.keyExists( "reload" ) ){
			wsPublish( "dashboard", "FORCE-RECONNECT" );
			applicationStop();
			location( cgi.script_name.replace( "index.cfm", "" ), false );
		}
		return true;
	}

	public boolean function onWSAuthenticate( string username, string password, struct connectionInfo ) {
		var users = [
			{ username : "admin", password: "system" },
			{ username : "employee", password: "password" },
			{ username : "hr", password: "1234567" }
		];

		// default to false
		arguments.connectionInfo.authenticated = false;

		for ( var user in users ){
			if ( user.username == arguments.username && user.password == arguments.password ){
				arguments.connectionInfo.authenticated = true;
				arguments.connectionInfo.username = arguments.username;
				break;
			}
		}

		return arguments.connectionInfo.authenticated;
	}
}