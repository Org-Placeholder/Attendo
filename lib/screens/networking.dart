import 'dart:developer';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/networking/networkservicediscovery.dart';
import 'package:attendo/networking/socket.dart';

class NetScreen extends StatefulWidget {
  @override
  _NetScreenState createState() => _NetScreenState();
}

class _NetScreenState extends State<NetScreen> {

  Service serviceObj;
  String serviceFound = "Nothing yet";
  String serverSaid = "Nothing yet";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          FlatButton(
            child: Text("Register service"),
            onPressed: regSer,
          ),
          FlatButton(
            child: Text("Discover service"),
            onPressed: discover,
          ),
          FlatButton(
            child: Text("Start server"),
            onPressed: startSer,
          ),
          FlatButton(
            child: Text("Connect and send"),
            onPressed: connectsend,
          ),
          SizedBox(
            height: 50,
          ),
          Text("Service = " + serviceFound, style: TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent)),
          Text("Server said = " + serverSaid, style: TextStyle(fontSize: 12.0, color: Colors.lightBlueAccent)),
          SizedBox(
            height: 50,
          ),
        ],

      ),
      color: Colors.white,
    );
  }

  void discover() async
  {
    ServiceDiscovery discovery = new ServiceDiscovery();
    
    discovery.discoverServices("_csn-420._tcp").then((result) {
      if(result == null)
      {
        print(":}");
      }
      else{
          setState(() {
            serviceFound = result.toString();
          });
      }
    });
  }

  //We are using this function because otherwise, we'll have no way to give a name to the service as the onPressed function cant take arguments.
  void regSer()
  {
    Service serviceObj = new Service();
    serviceObj.registerService("_csn-420._tcp");
  }

  void startSer()
  {
    Server server = new Server(3030);
  }

  void connectsend() async
  {
    String result = await connect_and_send("127.0.0.1", "3030", "Alu lelo");
    setState(() {
      serverSaid = result;
    });
  }
}

