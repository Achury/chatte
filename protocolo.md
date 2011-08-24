Protocolo Chatte
=================

Ingreso a la sala
-----------------

Se abre una conexión TCP al servidor.

El servidor responde con:

    0 Hello, nickname please.

El 0 es una petición al cliente para que envíe su apodo. El cliente responde con:

    Achury

El servidor responde con una de tres opciones:

1. El nickname es válido

        200 Welcome to the chatte.

    En este caso la conexión permanece abierta y se puede proceder a enviar y recibir mensajes.

2. El nickname es inválido

        201 Invalid nickname. Please try again. Bye.

    En este caso el servidor cierra la conexión. Los nicknames válidos satisfacen la expresión regular `/\A[a-z0-9\._+-]+\z/i` (nótese que el nickname no puede contener espacios)

3. El nickname ya está siendo utilizado

        202 Nickname already in use. Please try with another one. Bye.

    En este caso el servidor cierra la conexión.
    
Cuando un usuario entra al chat el servidor notifica a los demas usuarios activos 

    150 nickname just join to the chat
    
cuando un usuario sale del chat el servidor notifica a los demas usuarios activos 

    151 nickname just left the chat


Envío de mensajes
-----------------------------

Para enviar un mensaje a toda la sala en general, el cliente debe enviar:

    100 Hola, acabo de llegar. ¿Hay alguien aquí?

Todo lo que venga después de `100` será retransmitido a todos los usuarios conectados.

El servidor responde con

    101 Message sent.

Para enviar un mensaje privado, el cliente debe enviar:

    102 Andy Andy, ¿ya hiciste la tarea de telemática?
    
La primera palabra después del código es el nickname del usuario destinatario del mensaje privado. De ahí en adelante,
es el mensaje a enviar.

Si el usuario destinatario no está conectado, el servidor responde con

    203 Invalid destinatary. Verify the nickname.
    

Si el mensaje privado fue enviado, el servidor responde con

    101 Message sent.
    

Recepción de mensajes
---------------------

Para que el cliente reciba un mensaje público, el servidor le envía:

    100 Andy Hola, ¿hay alguien aquí?
    
El primer token después del código es el nickname de la persona que envió el mensaje. En adelante es el mensaje.

El cliente debe responder con

    101 Message received.
    
Para que el cliente reciba un mensaje privado, el servidor le envía:

    102 Andy Achury, sí, ya hice la tarea.
    
El primer token después del código es el nickname de la persona que envió el mensaje privado. En adelante es el mensaje.

El cliente debe responder con

    101 Message received.