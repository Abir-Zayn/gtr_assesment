import 'dart:convert';

import 'package:gtr_assessment/data/model/login_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:gtr_assessment/data/model/login_response_model.dart';

abstract class AuthDataSrc {
  Future<LoginResponseModel> login(LoginRequestModel req);
}

class AuthRemoteDataSrcImpl implements AuthDataSrc {
  final http.Client client;
  static const String baseURL = 'https://www.pqstec.com/InvoiceApps/Values/';

  AuthRemoteDataSrcImpl({required this.client});

  @override
  Future<LoginResponseModel> login(LoginRequestModel req) async {
    final url = Uri.parse('${baseURL}LogIn?${req.queryString()}');

    try {
      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        //Handle different response structures
        if (jsonResponse is Map<String, dynamic>) {
          // If response contains user data
          if (jsonResponse.containsKey('Id') ||
              jsonResponse.containsKey('Email')) {
            return LoginResponseModel.fromJson(jsonResponse);
          }
          // If response is just a success message, create user from request
          return LoginResponseModel(
            id: '1',
            email: req.userName,
            name: req.userName.split('@')[0],
            token: jsonResponse['token'] ?? 'login_success_token',
          );
        } else if (jsonResponse is String) {
          // If response is just a string (success message)
          return LoginResponseModel(
            id: '1',
            email: req.userName,
            name: req.userName.split('@')[0],
            token: 'login_success_token',
          );
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
