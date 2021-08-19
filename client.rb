#!/usr/bin/ruby -w
# Chat con ruby, le aniadi una funcionalidad
#Refencias: https://www.sitepoint.com/ruby-tcp-chat/
#https://dev.to/sushant12/tcp-chat-app-with-ruby-i88
require 'socket'     
require 'thread'

host = 'localhost'
port = 3000
s = TCPSocket.open(host, port)

Thread.start() do |client_server|
  while read = s.gets   
    puts read.chop     
  end
end
  
while line = gets
  s.puts("#{line}")
end

s.close      
