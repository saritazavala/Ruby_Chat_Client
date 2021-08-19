#!/usr/bin/ruby -w
# ------------
# Chat con ruby, le aniadi una funcionalidad
#Refencias: https://www.sitepoint.com/ruby-tcp-chat/
#https://dev.to/sushant12/tcp-chat-app-with-ruby-i88
# --------------

require 'socket'  
require 'thread'
require_relative 'Groups'

class Server

  def initialize(port)
  
    @clientlist = Array.new
    @grouplist = Array.new
    @desc = Array.new
    @server = TCPServer.new( "", port )
    @server.setsockopt( Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
    print("Se inicio el server en el puerto -->", port)
    @desc.push(@server)
    @x = 0
  end
  
  
  def run  
    while true 
      Thread.start(@server.accept) do |client_server| 
        client_server.puts(" ----- Menu ------")
        client_server.puts("1. Ver a usuarios Conectados")
        client_server.puts("2. Terminar chat privado")
        client_server.puts("3. Escribir a un grupo")
        client_server.puts("4. Aniadir grupo")
        client_server.puts("5. Listar grupos")
        client_server.puts("6. Unirme a un grupo")
        client_server.puts("7. Salir")
        client_server.puts("Mensajea a todos predeterminadamente")
        client_server.puts("Recuerda ver la ayuda con /h")
        client_server.puts("Ingresa tu usuario para continuar")
        
        handle = client_server.gets.chomp 
        client = Client.new(handle,client_server)
        @clientlist.push(client)
        client_server.puts("Usuario creado, disfruta del chat!")
     
# ---------------------------------------------------------------------------------------      

        while line = client_server.gets.chomp 
          if client.getChatFlag == 0
            if line == "1"
                @clientlist.each_with_index do |n,i| 
                  temp =  @clientlist[i]
                  client_server.puts temp.getHandle 
                end 

# ---------------------------------------------------------------------------------------   
#Comandos
            elsif line == "/h"
              puts " ------------- Comandos -----------------------"
              puts "/h --> mostrar ayuda de que comandos estan disponibles"
              puts "/u --> mostrar que usuarios estan en linea en el server"
              puts "/c --> <ScreenName> chatear con el usuario especificado "
              puts " ----------------------------------------------- "


            elsif line == "/u"
              @clientlist.each_with_index do |n,i| 
                temp =  @clientlist[i]
                client_server.puts temp.getHandle 
              client_server.puts temp.getSockAddr
              end 

            elsif line == "/c"
              client_server.puts("Ingresa el nombre de usuario para chatear privadamente")


# ---------------------------------------------------------------------------------------            
            elsif line == "3"
              if client.getGflag == 0
                client_server.puts("No estas dentro de un grupo")
              else
                @grouplist.each_with_index do |n,r| 
                client_server.printf("Conversacion grupal: ")
                line = client_server.gets.chomp                   
                if client.getGroup == @grouplist[r].getName
                  @grouplist[r].broadcast(line,client.getHandle)
                end
              end
              end

# ---------------------------------------------------------------------------------------              
            elsif line == "4"
              client_server.puts("Ingresa el nombre del grupo a crear: ")
              gname = client_server.gets.chomp 
              @grouplist.push(Group.new(gname))
              client_server.puts("El grupo #{gname} fue creado")
# ---------------------------------------------------------------------------------------  

            elsif line == "6"              
              client_server.puts("Ingrese el grupo al que se quiere unir")
              gname = client_server.gets.chomp 
              @grouplist.each_with_index do |n,p|
                group = @grouplist[p]
                if gname == group.getName
                  group.add(client)
                  client.setGroup(gname)
                  client_server.puts("#{client.getHandle} se ha unido al grupo #{group.getName}")
                end
              end
# ---------------------------------------------------------------------------------------  

            elsif line == "7"
              client_server.puts("Saliendo del sever ----> Bai")
              @clientlist.each_with_index do |n,k|
                if @clientlist[k].getHandle == client.getHandle
                  @clientlist.delete_at(k)
                end
              end
              break
# ---------------------------------------------------------------------------------------  

            elsif line == "5"
              @grouplist.each_with_index do |n,m| 
                group = @grouplist[m]
                client_server.puts  group.getName
                group.printClients(client_server)
              end
# ---------------------------------------------------------------------------------------  
            else
              @clientlist.each_with_index do |n,i| 
                temp = @clientlist[i]
                if line == temp.getHandle 
                  @x = i
                  client_server.puts("Chateando con --> #{temp.getHandle}")
                  client.setChatPart(temp.getSock)
                  temp.setChatPart(client.getSock)
                  temp.setChatFlag(1)
                  client.setChatFlag(1)
                end
              end 
              @clientlist.each_with_index do |n,j|
                @clientlist[j].getSock.puts("#{client.getHandle}: #{line}")
              end
            end
# ---------------------------------------------------------------------------------------              
          else
            if line == "2"
              client.setChatFlag(0)
              @clientlist[@x].setChatFlag(0)
            else
              chatsock = client.getChatPart
              chatsock.puts("#{client.getHandle}: #{line}")
            end
          end
        end
      end
    end
  end
  
end

class Client

  def initialize(handle, sock)
    @sock = sock 
    @handle = handle 
    @chatflag = 0
    @chatsock = sock 
    @gflag=0
 
  end

  def getChatPart
    return @chatsock
  end

  def setChatPart(chatsocket)
    @chatsock = chatsocket
  end

  def getHandle()
    return @handle
  end


  def setChatFlag(num)
    @chatflag = num
  end
  
  def getChatFlag()
    return @chatflag
  end

 
  def setGroup(name)
    @gflag = 1
    @group = name
    
  end
  
  def getGroup()
    return @group
  end

  def getGflag()
    return @gflag
  end
  
  def getSock()
    return @sock
  end
  
  def getSockAddr()
    return @sock.peeraddr[2]
  end
end


# ---------------------------------------------------------------------------------------   
def main
  serv = Server.new(3000).run 
end 

# ----------------------------------------
main
# ----------------------------------------

    
