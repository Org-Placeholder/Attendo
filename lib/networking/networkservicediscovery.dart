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
  Future < Map <String, dynamic> > discoverServices(String service_name) async
  {

    // This is the type of service we're looking for :
    String type = service_name;
    // Once defined, we can start the discovery :
    BonsoirDiscovery discovery = BonsoirDiscovery(type: type);
    await discovery.ready;
    await discovery.start();
    var result;
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
    while(result == null)
      {
        await new Future.delayed(const Duration(seconds : 1));
      }
    print('Service found : ${result}');
    return result;
  }
}
