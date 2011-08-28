# Instalación y ejecución

## Instalación de Ruby

La aplicación está escrita en el lenguaje de programación Ruby. Esto implica que se necesita instalar la máquina virtual de Ruby para poderla ejecutar.

La manera más fácil de instalar Ruby es usando RVM (Ruby Version Manager). Instrucciones detalladas sobre como instalar RVM se encuentran en http://beginrescueend.com/rvm/install/.

Una vez instalado RVM, debe instalarse la versión más reciente de Ruby 1.9.2. Esto puede hacerse ejecutando el comando:

    $ rvm install ruby-1.9.2-head
    
Después puede comprobarse que se instaló correctamente Ruby 1.9.2, corriendo el comando:

    $ ruby -v
    
La salida debería ser algo como esto (puede variar según el sistema operativo):

    ruby 1.9.2p180 (2011-02-18 revision 30909) [x86_64-darwin10.7.0]

¡Listo! Ya se puede ejecutar el servidor.

## Ejecución del servidor

El servidor recibe un parámetro desde la línea de comando correspondiente al puerto dónde debe escuchar. Se ejecuta corriendo el comando:

    $ ruby server.rb 1234
    Starting Chatte server. Listening for connections on port 1234...

En este momento el servidor se encuentra aceptando conexiones entrantes y se puede continuar ejecutando el cliente.

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