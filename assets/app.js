const ui = {
    view : {},
    init : () => {

        ui.view = {
            form     : document.getElementById('form'),
            message  : document.getElementById('message'),
            messages : document.getElementById('messages'),
            clearBtn : document.getElementById('clear-log')
        };
        ui.view.form.addEventListener('submit', event => {
            event.preventDefault();
            ui.sendMessage();
        });
        ui.view.clearBtn.addEventListener('click', ui.clearLog);
    },
    clearLog    : () => {
        ui.view.messages.innerHTML = '';
    },
    sendMessage : () => {
        const message = ui.view.message.value.trim();
        if ( message ) {
            ws.publish( 'dashboard', message );
            ui.view.message.value = '';
        }
    },
    writeLine   : ( channelname, message, type ) => {
        const li = document.createElement('li');
        li.classList.add('rounded-2');
        if ( type === 'sent' )
            li.classList.add('text-end','bg-primary','text-white');
        else
            li.classList.add('bg-secondary-subtle','text-body-emphasis');
        li.innerHTML = `<small class="py-1 px-2">${channelname}</small>
                        <div class="py-1 px-2">${message}</div>`;
        ui.view.messages.appendChild(li);
        ui.view.messages.scrollTo({
            top      : ui.view.messages.scrollHeight,
            behavior : 'smooth'
        });
    },
};

const SimpleChat = {
    id        : null,
    onOpen    : () => ws.subscribe( 'dashboard' ),
    onMessage : message => {
        console.log( message );
        switch( message.reqType || message.type ){
            case 'welcome':
                SimpleChat.id = message.clientid;
                break;
            case 'data':
                ui.writeLine(
                    message.channelname,
                    message.data,
                    message.publisherid === SimpleChat.id ? 'sent' : 'received'
                );
                break;

        }
    }
};

ui.init();
