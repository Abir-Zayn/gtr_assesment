import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gtr_assessment/data/model/customer_list.dart';

abstract class CustomerDataSrc {
  Future<CustomerListModel> getCustomerList({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  });
}

class CustomerDataSrcImpl implements CustomerDataSrc {
  final http.Client client;
  static const String baseUrl = 'https://www.pqstec.com/InvoiceApps/Values/';
  CustomerDataSrcImpl({required this.client});

  @override
  Future<CustomerListModel> getCustomerList({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  }) async {
    final queryParams = {
      'searchquery': searchQuery,
      'pageNo': pageNo.toString(),
      'pageSize': pageSize.toString(),
      'SortyBy': sortBy,
    };

    final uri = Uri.parse('${baseUrl}GetCustomerList')
        .replace(queryParameters: queryParams);

    try {
      debugPrint('Customer List URL: $uri'); // Debug log
      debugPrint('Using token: $token'); // Debug log

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Customer Response status: ${response.statusCode}'); // Debug log
      debugPrint('Customer Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        if (responseBody.isEmpty) {
          throw Exception('Empty response from server');
        }

        try {
          final jsonResponse = json.decode(responseBody);
          debugPrint('Customer Parsed JSON: $jsonResponse'); // Debug log

          if (jsonResponse is Map<String, dynamic>) {
            // Check for success
            final success = jsonResponse['Success'];
            final error = jsonResponse['error'];
            
            if (success == 1 && error == false) {
              // Extract customer list
              final customerListData = jsonResponse['CustomerList'];
              final pageInfo = jsonResponse['PageInfo'];
              
              if (customerListData is List) {
                // Extract pagination info
                int currentPage = pageNo;
                int totalCount = 0;
                bool hasNextPage = false;
                
                if (pageInfo is Map<String, dynamic>) {
                  currentPage = pageInfo['PageNo'] ?? pageNo;
                  totalCount = pageInfo['TotalRecordCount'] ?? customerListData.length;
                  final pageCount = pageInfo['PageCount'] ?? 1;
                  hasNextPage = currentPage < pageCount;
                }
                
                return CustomerListModel.fromJsonWithPagination(
                  customerListData,
                  currentPage,
                  pageSize,
                  totalCount,
                  hasNextPage,
                );
              } else {
                throw Exception('CustomerList is not an array');
              }
            } else {
              throw Exception('API returned error: Success=$success, Error=$error');
            }
          } else {
            throw Exception('Response is not a JSON object');
          }
        } catch (e) {
          debugPrint('JSON parsing error: $e'); // Debug log
          throw Exception('Failed to parse customer data: $e');
        }
      } else {
        final errorBody = response.body;
        debugPrint('Error response body: $errorBody'); // Debug log

        if (response.statusCode == 401) {
          throw Exception('Authentication failed. Please login again.');
        } else if (response.statusCode == 403) {
          throw Exception('Access denied. Insufficient permissions.');
        } else {
          throw Exception('Failed to load customers: HTTP ${response.statusCode}');
        }
      }
    } catch (e) {
      debugPrint('Customer API error: $e'); // Debug log
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception(
          'Network connection error. Please check your internet connection.',
        );
      } else {
        throw Exception('Network error: $e');
      }
    }
  }
}