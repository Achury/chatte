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

  En este caso la conexión permanece abierta.

2. El nickname es inválido

    201 Invalid nickname. Please try again. Bye.

  En este caso el servidor cierra la conexión.

3. El nickname ya está siendo utilizado

    202 Nickname already in use. Please try with another one. Bye.

  En este caso el servidor cierra la conexión.

Envío y recepción de mensajes
-----------------------------