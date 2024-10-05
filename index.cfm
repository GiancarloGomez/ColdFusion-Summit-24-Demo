<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>ColdFusion WebSockets</title>
	<link href="./assets/favicon.ico" rel="shortcut icon">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="./assets/app.css" rel="stylesheet">
</head>
<body>
	<main class="container-xxl">
		<div class="d-flex py-2 border-bottom justify-content-between align-items-center bg-body-tertiary">
			<h1 class="h5 m-0">
				ColdFusion WebSocket Test
			</h1>
			<button type="button" class="btn btn-sm btn-secondary" id="clear-log">
				Clear Log
			</button>
		</div>
		<section class="d-flex flex-column">
			<ul id="messages" class="list-unstyled d-flex flex-column gap-2 py-2 overflow-y-scroll m-0"></ul>
			<form class="p-3 border-top bg-body-tertiary" id="form">
				<div class="input-group">
					<input type="text" class="form-control" id="message" placeholder="Type a message" autocomplete="off">
					<button type="submit" class="btn btn-primary">Send</button>
				</div>
			</form>
		</section>
	</main>
	<script src="./assets/app.js"></script>
	<cfwebsocket name      = "ws"
				 onMessage = "SimpleChat.onMessage"
				 onOpen    = "SimpleChat.onOpen"
				 secure    = "#cgi.server_port_secure#">
</body>
</html>