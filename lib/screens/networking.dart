import 'dart:developer';

import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:attendo/networking/networkservicediscovery.dart';

class NetScreen extends StatefulWidget {
  @override
  _NetScreenState createState() => _NetScreenState();
}

class _NetScreenState extends State<NetScreen> {

  Service serviceObj;
  String serviceFound = "Nothing yet";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          FlatButton(
            child: Text("Register service"),
            onPressed: regSer,
          ),
          FlatButton(
            child: Text("Discover service"),
            onPressed: discover,
          ),
          Text("Service = " + serviceFound),
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
        var values_list = result.values.toList();
        var key_list = result.keys.toList();
        String serviceDeets = "";
        for(int i = 0; i < key_list.length; i++)
        {
          serviceDeets += key_list[i] + " : " + values_list[i] + ", ";
        }
        log(serviceDeets);
        if(result == true)
        {
          setState(() {
            serviceFound = serviceDeets;
          });
        }
      }
    });
    



  }
}
//We are using this function because otherwise, we'll have no way to give a name to the service as the onPressed function cant take arguments.
void regSer()
{
  Service serviceObj = new Service();
  serviceObj.registerService("_csn-420._tcp");

}
