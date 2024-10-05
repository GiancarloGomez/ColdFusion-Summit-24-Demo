component extends="CFIDE.websocket.ChannelListener" {

	/**
	 * Invoked before subscribing to a channel/sub-channel to check if the
	 * requested client can be allowed to subscribe.
	 */
	public boolean function allowSubscribe( struct subscriberInfo ) {
		if ( arguments.subscriberInfo.connectionInfo.authenticated ){
			wsPublish(
				"protected",
				arguments.subscriberInfo.connectionInfo.clientID & " : " &
				arguments.subscriberInfo.connectionInfo.username & " joined the channel"
			);
		}
		return arguments.subscriberInfo.connectionInfo.authenticated;
	}

	/**
	 * Invoked before publishing to a channel/sub-channel to check if the
	 * requested client can be allowed to publish.
	 */
	public boolean function allowPublish( struct publisherInfo ) {
		return arguments.publisherInfo.connectionInfo.authenticated;
	}

	/**
	 * Invoked before publishing the message on requested channel/sub-channel.
	 * Used to execute a business logic if required and to format messages.
	 */
	public any function beforePublish( any message, struct publisherInfo ){
		// Transforms the message into a struct that is used by beforeSendMessage
		var messageData = {
			message       : arguments.message,
			publisherInfo : arguments.publisherInfo.connectionInfo
		};
		return messageData;
	}

	/**
	 * Invoked before sending the message to a subscribed client.
	 * Can be used to format the message as per client requirement before sending.
	 */
	public any function beforeSendMessage( any message, struct subscriberInfo ){
		// publisher info is empty on server side messages
		var isMe = arguments.message.publisherInfo.keyExists("clientid") &&
					arguments.subscriberInfo.connectioninfo.clientid == arguments.message.publisherInfo.clientid ?
					true :
					false;

		return isMe ?
				"You: " & arguments.message.message :
				arguments.message.message;
	}

	/**
	 * Invoked before sending the message to a subscribed client.
	 * Used to decide whether the message should be sent to a specific client.
	 */
	public boolean function canSendMessage( any message, struct subscriberInfo, struct publisherInfo ) {
		return true;
	}

	/**
	 * Invoked after client unsubscribes from a channel/sub-channel.
	 * Used to clear the settings if necessary.
	 */
	public function afterUnsubscribe( struct subscriberInfo ){
		wsPublish(
			"protected",
			arguments.subscriberInfo.connectionInfo.clientID & " : " &
			arguments.subscriberInfo.connectionInfo.username & " left the channel"
		);
	}
}