import 'package:ipaddr/ipaddr.dart';

class NetworkData {
  IPv4Network networkData;

  List<IPv4Interface> subnetsData;

  NetworkData({required this.networkData, required this.subnetsData});
}
