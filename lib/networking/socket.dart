import 'dart:io';

class Server
{
  //server is declared here so that we can close it as per need.
  HttpServer server;

  //declare some map or some vector for storing the enrollment numbers of students who marked attendance.
  //Also a vector of ip addresses which would be updated everytime a new student marks attendance successfully.
  //If the ip address already exists, then attendance won't be marked.

  //constructor will directly start server
  Server()
  {
    startServer();
  }

  //this will initialize the server
  void startServer() async
  {
    //yeh loopback ke jagah anyIPv4 dalna hai kya woh dekhna hoga
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8083);
    await for (HttpRequest req in server) {
      if (req.uri.path == '/ws') {
        WebSocket socket = await WebSocketTransformer.upgrade(req);
        socket.listen((data) {
          print("from IP ${req.connectionInfo.remoteAddress.address}:${data}");
          String dataStr = data.toString();
          bool no_problem = true;

          //handle string. Validation and attendance marking logic goes here.

          if(no_problem)
            {
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
  WebSocket socket = await WebSocket.connect('ws://127.0.0.1:8083/ws');
  socket.add('Hello, World!');
  String result;
  await for (var data in socket) {
    print("from Server: $data");
    result = data.toString();
    socket.close();
    return result;
  }
}
