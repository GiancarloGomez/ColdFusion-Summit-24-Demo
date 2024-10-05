<cfscript>
	// works with variables from the form or url scope
	data = {};
	data.append( url );
	data.append( form );

	// expects a json response with a success key
	response = { "success":false };

	// set up the channels to check against
	// if none are provided, it will check all top level channels only
	channels = len(data.channels ?: "") ?
				listToArray( data.channels) :
				wsGetAllChannels();

	for ( channel in channels ){
		subscribers = wsGetSubscribers( channel );

		for ( subscriber in subscribers ){
			if ( subscriber.clientid == data.clientid ){
				response.success = true;
				// break out if a match is found
				break;
			}
		}
		// break out if a match is found
		if ( response.success )
			break;
	}
	// return response
	cfcontent( type="application/json", reset=true );
	writeOutput( serializeJSON( response ) );
</cfscript>