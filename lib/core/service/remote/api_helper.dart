class ApiHelper {
 static Future<Map<String, String>> getHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add 'Authorization': 'Bearer token' if needed
    };
  }
}
