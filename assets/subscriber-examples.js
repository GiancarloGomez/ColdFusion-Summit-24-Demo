// #1 subscriber in hr department with selector applied
ws.subscribe( 'dashboard', {
    department : 'HR',
    selector   : 'department EQ \'HR\''
} );

// #2 subscriber
ws.subscribe( 'dashboard' );

// #3 subscriber in accounting department and employee information
ws.subscribe( 'dashboard', {
    department : 'Accounting',
    employee   : { firstName: 'John', lastName: 'Doe' }
} );

// publish a message
ws.publish( 'dashboard', 'Hello Everyone!' );

// publish message using a selector
ws.publish( 'dashboard', 'Hello HR Department!', {
    selector : 'department EQ \'HR\''
});

// publish message with a property applied
ws.publish( 'dashboard', 'Hello HR Department!', {
    department : 'HR',
});

ws.publish( 'dashboard', 'Hello HR Department!', {
    department : 'HR',
    selector : 'department EQ \'HR\''
});