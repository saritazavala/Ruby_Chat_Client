# Ruby Chat Client
Simple chat that allows you to send general and private messages. It allows users to create groups and interact with them, also, it is posible to use some commands to allow some actions

## Instructions
1.  El server debe mostar a primera conexion dos opciones
	1. Login
	2. Registrarse
2.  Si el usuario escoge la opcion 2 le debe pedir los siguientes parametros
	1. ScreenName
	2. Password
		(El password debe ser guardado de forma hasheada)
	3. Confirmación del password
3.  Si el usuario escoge la opcion 1 le debe pedir:
	1. ScreenName
	2. Password
		Si el password es correcto completar el login
		Si el password es incorrecto enviar el siguiente mensaje "El usuario y/o password estan incorrectos"
4.  El usuario tiene ciertos comandos a su disposición 
	1. \h -> mostrar ayuda de que comandos estan disponibles
	2. \u -> mostrar que usuarios estan en linea en el server
	3. \c <ScreenName> -> chatear con el usuario especificado
5.  En caso de que se reciba un chat de un usuario con el cual no se esta hablando, el server debe de enviar un mensaje generico con el siguiente formato
	El usuario <ScreenName> le ha enviado un mensaje.
6.  Cada minuto enviar un mensaje que tenga mensajes pendientes al usuario con el siguiente contenido
	Tiene <cantidad de mensajes pendientes> mensajes de <cantidad de usuarios con mensajes pendientes> usuarios por leer
7.  Al momento de entrar al chat con el usuario que se tiene mensajes pendientes, el server debe enviar todos los mensajes de ese usuario especifico
8.  Crear los siguientes comandos
	\p -> mostrar una lista que muestre cuantos mensajes tiene pendientes y de que usuarios como se muestra abajo
	Tiene 10 mensajes pendientes
	Usuario			Cantidad de mensajes
	Phoenixrbrth		10
	Alfatrots		54
	ElPatitoFeo		2
	\n <tiempo en segundos>-> configurar en segundos cada cuanto se envia la notificacion de mensajes pendientes del punto 6
	\n -> mostrar el tiempo en segundos que se envia la notificacion de mensajes pendientes del punto 6
