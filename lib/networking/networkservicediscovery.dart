import 'package:bonsoir/bonsoir.dart';
class Service
{
  BonsoirBroadcast broadcast;
  BonsoirService service;
   Future <void> registerService(String service_name) async
  {
    service = BonsoirService(
      name: service_name, // Put your service name here.
      type: service_name, // Put your service type here. Syntax : _ServiceType._TransportProtocolName. (see http://wiki.ros.org/zeroconf/Tutorials/Understanding%20Zeroconf%20Service%20Types).
      port: 3030, // Put your service port here.
    );

    broadcast = BonsoirBroadcast(service: service);
    await broadcast.ready;
    broadcast.start();
  }

  void deregisterService()
  {
    broadcast.stop();
  }
}

class ServiceDiscovery
{
  int wait_time = 5;
  //Implementation needs to be modified to terminate after wait_time seconds if service isn't discovered
  Future < Map <String, dynamic> > discoverServices(String service_name) async
  {

    // This is the type of service we're looking for :
    String type = service_name;
    // Once defined, we can start the discovery :
    BonsoirDiscovery discovery = BonsoirDiscovery(type: type);
    var result;
    await discovery.ready;
    await discovery.start();
    // If you want to listen to the discovery :
    discovery.eventStream.listen((event) {
      if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_RESOLVED) {
        print('Service found : ${event.service.toJson()}');
        discovery.stop();
        result =  event.service.toJson();
      } else if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_LOST) {
        print('Service found : ${event.service.toJson()}');
        discovery.stop();
        result = event.service.toJson();
      }
    });
    int time_elapsed = 0;
    while(result == null && time_elapsed<= wait_time) {
      await new Future.delayed(const Duration(seconds : 1));
    }
    if(result == null) {
        print("Service not found");
        discovery.stop();
    } else {
      print('Service found : ${result}');
    }
    return result;
  }
}
