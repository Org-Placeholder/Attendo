import 'dart:io';
import 'dart:convert';
class Server
{
  //server is declared here so that we can close it as per need.
  HttpServer server;
  List<String> students = []; // Stores enrollment numbers of students who marked their attendance
  List<String> ipAddresses = []; // Stores IPv4 addresses from which attendance has been marked


  //constructor will directly start server
  Server(int port)
  {
    startServer(port);
  }

  //this will initialize the server
  void startServer(int port) async
  {
    ServerSocket serverSocket = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    await for(Socket socket in serverSocket)
    {
      socket.cast<List<int>>().transform(utf8.decoder).listen((data)
      {
        //print("from ${socket.remoteAddress.address} data:" + data);
        print("from IP ${socket.remoteAddress.address}:${data}");
        String dataStr = data.toString();
        bool noProblem = true;
        String address = socket.remoteAddress.address;

        //Verify that attendance from this address has not been marked previously
        noProblem = ipAddresses.every((ip) => ip != address);

        //if attendance has not been marked from address
        if(noProblem)
        {
          //Add address to the list of addresses so far, and mark student present
          ipAddresses.add(address);
          students.add(dataStr);
          socket.add(utf8.encode('OK'));
        }
        else
        {
          socket.add(utf8.encode('Error'));
        }

      });
    }
  }

  //this can be used to close the server once the stipulated time is over.
  void closeServer()
  {
    server.close();
  }
}

//This will connect to the server, send the message, close the socket and return the message recieved from server
Future <String> connect_and_send(String host, int port, String message) async
{

  Socket socket = await Socket.connect(host, port);
  socket.write(message);
  String result;
  socket.cast<List<int>>().transform(utf8.decoder).listen((data) {
    print("from ${socket.remoteAddress.address} data:" + data);
    result = data.toString();
    socket.close();
  });
  while(result == null) {
    await new Future.delayed(const Duration(seconds : 1));
  }
  print('Server said : ${result}');
  return result;
}
