import 'dart:async';
import 'dart:math'; // Import dart:math for sqrt.
import 'dart:ui';

import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  final VoidCallback onShake;
  // Lowered the threshold from 2.0 to 1.5 for easier detection.
  final double shakeThresholdGravity;
  final int shakeSlopTimeMS;
  final int shakeCountResetTime;

  DateTime? _lastShakeTime;
  int _shakeCount = 0;
  StreamSubscription<UserAccelerometerEvent>? _subscription;

  ShakeDetector({
    required this.onShake,
    this.shakeThresholdGravity =
        1.5, // Adjust this value to suit your sensitivity needs.
    this.shakeSlopTimeMS = 200,
    this.shakeCountResetTime = 3000,
  });

  void startListening() {
    _subscription = userAccelerometerEventStream().listen(
      (UserAccelerometerEvent event) {
        final double x = event.x;
        final double y = event.y;
        final double z = event.z;

        // Normalize the accelerometer values to gravity (g) units.
        final double gX = x / 9.81;
        final double gY = y / 9.81;
        final double gZ = z / 9.81;

        // Compute the actual g-force magnitude.
        final double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThresholdGravity) {
          final DateTime now = DateTime.now();

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds <
                  shakeSlopTimeMS) {
            return;
          }

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds >
                  shakeCountResetTime) {
            _shakeCount = 0;
          }

          _lastShakeTime = now;
          _shakeCount++;

          if (_shakeCount >= 2) {
            _shakeCount = 0;
            onShake();
          }
        }
      },
      onError: (error) {
        print('Error in shake detection: $error');
      },
      cancelOnError: true,
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
