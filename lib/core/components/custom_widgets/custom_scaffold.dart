import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'error_screen.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.drawer,
    this.bottomNavigationBar,
    this.appBar,
  });

  final Widget body;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  bool isDeviceConnected = false;
  bool isLoading = true;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> initConnectivity() async {
    try {
      setState(() => isLoading = true);

      // Updated API - now returns List<ConnectivityResult>
      List<ConnectivityResult> results =
          await _connectivity.checkConnectivity();
      if (!mounted) return;

      await _updateConnectionStatus(results);
    } catch (e) {
      debugPrint('Connectivity check failed: $e');
      if (mounted) {
        setState(() {
          isDeviceConnected = false;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    // Check if any of the connectivity results indicate connection
    bool hasConnection = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (hasConnection) {
      try {
        // Double-check with actual internet connection
        bool isConnected = await InternetConnectionChecker().hasConnection;
        if (mounted) {
          setState(() {
            isDeviceConnected = isConnected;
            isLoading = false;
          });
        }
      } catch (e) {
        debugPrint('Internet connection check failed: $e');
        if (mounted) {
          setState(() {
            isDeviceConnected = false;
            isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          isDeviceConnected = false;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _retryConnection() async {
    await initConnectivity();
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    // Listen to connectivity changes with updated API
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
      onError: (error) {
        debugPrint('Connectivity stream error: $error');
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while checking connectivity
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Show connectivity error
    if (!isDeviceConnected) {
      return ErrorScreen(
        message: "الجهاز غير متصل بالانترنت",
        onRetry: _retryConnection,
        icon: Icons.wifi_off,
      );
    }

    // Show main content
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButton: widget.floatingActionButton,
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.body,
      appBar: widget.appBar,
    );
  }
}
