import 'dart:convert';
import 'package:flutter/material.dart';
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
      debugPrint('Login URL: $url'); // Debug log

      final response = await client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      debugPrint('Response status: ${response.statusCode}'); // Debug log
      debugPrint('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        // Handle empty response
        if (responseBody.isEmpty) {
          throw Exception('Empty response from server');
        }

        try {
          final jsonResponse = json.decode(responseBody);
          debugPrint('Parsed JSON: $jsonResponse'); // Debug log

          // Handle different response structures
          if (jsonResponse is Map<String, dynamic>) {
            // Check if it has the required fields for login response
            if (jsonResponse.containsKey('Token') &&
                jsonResponse.containsKey('Email')) {
              return LoginResponseModel.fromJson(jsonResponse);
            } else {
              throw Exception('Invalid login response structure');
            }
          } else {
            throw Exception(
              'Unexpected response format: ${jsonResponse.runtimeType}',
            );
          }
        } catch (e) {
          debugPrint('JSON parsing error: $e'); // Debug log
          throw Exception('Failed to parse response: $e');
        }
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Login error: $e'); // Debug log
      throw Exception('Network error: $e');
    }
  }
}
