import 'dart:io';

class Server
{
  //server is declared here so that we can close it as per need.
  HttpServer server;

  List<String> students; // Stores enrollment numbers of students who marked their attendance
  List<String> ipAddresses; // Stores IPv4 addresses from which attendance has been marked


  //constructor will directly start server
  Server(int port)
  {
    startServer(port);
  }

  //this will initialize the server
  void startServer(int port) async
  {
    //yeh loopback ke jagah anyIPv4 dalna hai kya woh dekhna hoga
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, port);
    await for (HttpRequest req in server) {
      if (req.uri.path == '/ws') {
        WebSocket socket = await WebSocketTransformer.upgrade(req);
        socket.listen((data) {
          print("from IP ${req.connectionInfo.remoteAddress.address}:${data}");
          String dataStr = data.toString();
          bool noProblem = true;
          String address = req.connectionInfo.remoteAddress.address;

          //Verify that attendance from this address has not been marked previously
          noProblem = ipAddresses.every((ip) => ip != address);

          //if attendance has not been marked from address
          if(noProblem)
            {
              //Add address to the list of addresses so far, and mark student present
              ipAddresses.add(address);
              students.add(dataStr);
              socket.add("OK");
            }
          else
            {
              socket.add("Error");
            }

        });
      }
    };
  }

  //this can be used to close the server once the stipulated time is over.
  void closeServer()
  {
    server.close();
  }
}

//This will connect to the server, send the message, close the socket and return the message recieved from server
Future <String> connect_and_send(String host, String port, String message) async
{
  WebSocket socket = await WebSocket.connect('ws://' + host + ':' + port +'/ws');
  socket.add(message);
  String result;
  await for (var data in socket) {
    print("from Server: $data");
    result = data.toString();
    socket.close();
  }
  while(result == null)
    {
      await new Future.delayed(const Duration(seconds : 1));
    }
  print('Server said : ${result}');
  return result;
}
