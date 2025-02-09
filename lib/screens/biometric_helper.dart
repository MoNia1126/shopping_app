import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      bool canAuthenticate = await auth.canCheckBiometrics;
      if (!canAuthenticate) return false;

      return await auth.authenticate(
        localizedReason: 'Please authenticate to access your profile',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Biometric authentication error: $e');
      return false;
    }
  }
}
