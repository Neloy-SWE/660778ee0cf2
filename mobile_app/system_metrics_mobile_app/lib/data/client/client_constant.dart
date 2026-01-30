/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class ClientConstant {
  static const String baseUrl = "http://192.168.0.111:5005/api/";

  // status code:
  static const int statusCode200OK = 200;

  // result:
  static const String created = "created";

  // status:
  static const String dataSavedSuccessfully = "Data saved successfully";
  static const String dataSavedFailed = "Data saved failed, try again";
  static const String dataFetchedFailed = "Data fetch failed, try again";
  static const String networkIssue = "Fix your network, try again";

  // key
  static const String deviceId = "deviceId";
  static const String fromDate = "fromDate";
  static const String toDate = "toDate";
  static const String pageNumber = "pageNumber";
  static const String pageSize = "pageSize";
}
