
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Subscribers</title>
	<link href="./assets/favicon.ico" rel="shortcut icon">
	<style>
		body table[class^="cfdump"] {
			font-family : 'JetBrains Mono', monospace;
			font-size   : .875rem;
			line-height : 1.42;
		}
	</style>
</head>
<body>
	<cfscript>
		function getSubChannels( channel ){
			var obj = {
				"name"        : channel,
				"subscribers" : wsGetSubscribers( channel ),
				"subchannels" : []
			};

			for ( var subChannel in wsGetAllChannels( channel ) )
				obj.subchannels.append( getSubChannels( subChannel ) );

			if ( !obj.subchannels.len() )
				obj.delete( "subchannels" );

			return obj;

		}

		channels = [];

		for ( channel in wsGetAllChannels() )
			channels.append( getSubChannels( channel ) );

		writeDump( channels );
	</cfscript>
</body>
</html>