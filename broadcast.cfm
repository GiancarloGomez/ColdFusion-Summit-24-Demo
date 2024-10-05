<cfscript>
    wsPublish(
        "dashboard",
        "This is from the server at " & dateTimeFormat( now(), "long" )
    );
</cfscript>