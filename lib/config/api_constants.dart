class ApiConstants {
  static const isDebugMode = true;
  static const String hubHost = isDebugMode ? _analyticsHubHost : _apiHubHost;
  static const String _analyticsHubHost = "https://analytics.quickfoodmm.com/";
  static const String _apiHubHost = "https://admin.quickfoodmm.com/";

  static const String callHubPath = "hub/call";
  static const String chatHubPath = "hub/chat";
  static const String orderTrackingHubPath = "hub/tracking";
  static const String merchantOrderHubPath = "hub/shop";
}
