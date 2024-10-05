<!DOCTYPE html>
<html lang="en" id="advanced">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>AdvancedSocket Example</title>
	<link href="./assets/favicon.ico" rel="shortcut icon">
	<link href="./assets/app.css" rel="stylesheet">
</head>
<body data-auto-connect    = "true"
	  data-channels        = "dashboard"
	  data-debug           = "true"
	  data-do-message      = "onMessage"
	  data-name            = "ws"
	  data-offline-timer   = "2"
	  data-online-timer    = "10"
	  data-ping-url        = "ping.cfm"
	  data-reconnect-timer = "2"
	  data-status-label    = "message"
	  data-ip-api-service  = "ip-api.com"
	  data-ip-api-lookup   = "false"
	  data-ip-api-key      = "">

	<div id="status"></div>
	<div id="message"></div>

	<cfwebsocket name      = "ws"
				 onMessage = "AdvancedSocket.onMessage"
				 onOpen    = "AdvancedSocket.onOpen"
				 onClose   = "AdvancedSocket.onClose"
				 onError   = "AdvancedSocket.onError"
				 secure    = "#cgi.server_port_secure#">

	<script src="./advancedsocket/dist/advancedsocket.min.js"></script>

	<script>
		const ui = {
			status  : document.getElementById('status'),
			message : document.getElementById('message')
		};

		// handle connection states
		AdvancedSocket.disconnected = () =>{
			ui.status.innerHTML     =
			document.body.classList = 'disconnected';
		}

		AdvancedSocket.connected = () => {
			ui.status.innerHTML     =
			document.body.classList = 'connected';
		}

		AdvancedSocket.connecting = () => {
			ui.status.innerHTML     =
			document.body.classList = 'connecting';
		}

		// handle messages received
		function onMessage( message ) {
			if ( message.data ){
				if ( message.data === 'FORCE-RECONNECT' )
					AdvancedSocket.disconnected();
				else
					ui.message.innerHTML = message.data;
			}
		}
	</script>
</body>
</html>