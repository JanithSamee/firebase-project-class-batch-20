import 'package:get/get.dart';

 class ApiService extends GetConnect {
   Future<dynamic> getTodos() async {
    var res = await get("https://weatherapi-com.p.rapidapi.com/alerts.json?q=london",
    
    headers: {
      "Authorization":"Bearer ---token---"
    });

    return res.body;
  }
}
