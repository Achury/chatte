# Chatte

## Ejecución del servidor

El servidor recibe un parámetro desde la línea de comando correspondiente al puerto dónde debe escuchar. Se ejecuta corriendo el comando:

    $ ruby server.rb 1234
    Starting Chatte server. Listening for connections on port 1234...

En este momento el servidor se encuentra aceptando conexiones entrantes y se puede continuar a ejecutar el cliente.

## Ejecución del cliente

El cliente recibe dos parámetros desde la línea de comandos: el host y el puerto del servidor. Luego el cliente lee el nickname del usuario desde la entrada estándar y se conecta a dicho host y puerto. Veamos un ejemplo:

    $ ruby client.rb localhost 1234
    Enter your nickname:
    Andy
    Connecting...
    Andy just joined the chatte

## Terminación del servidor

Para terminar el servidor, hay que enviarle la señal SIGINT. Esto puede hacerse presionando las teclas Ctrl+C en la consola donde está corriendo el servidor (en sistemas Unix).

## Terminación del cliente

Para terminar el cliente, se le puede enviar la señal SIGINT similiar a como se hace con el servidor o se puede escribir `/quit` ó `/exit` en el cliente.