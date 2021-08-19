#!/usr/bin/ruby -w

# Solo es una funcionalidad extra, 
# Me dejaron la misma tarea en la univesidad
# Y se me hizo curioso probarla en Ruby xD
# Aun tiene algunos bugs
#Refencias: https://www.sitepoint.com/ruby-tcp-chat/
#https://dev.to/sushant12/tcp-chat-app-with-ruby-i88
class Group
    def initialize(name)
      @name = name
      @clist = Array.new
    end
    
    def add(client)
      @clist.push(client)
    end
    
    def getName
      return @name
    end

    def printClients(csock)
      @clist.each_with_index do |n,o|
        csock.puts @clist[o].getHandle 
      end
    end


    def broadcast(line,handle)
      @clist.each_with_index do |n,q|
        csock =  @clist[q].getSock
        csock.puts("#{handle}: #{line}")
      end
    end
end