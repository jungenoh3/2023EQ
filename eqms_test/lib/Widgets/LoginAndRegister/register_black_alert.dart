import 'package:flutter/material.dart';
import '../../style/color_guide.dart';

class RegisterBlackWidget extends StatelessWidget {
  const RegisterBlackWidget({
    super.key,
    required bool isErrorMessageVisible,
    required String serverErrorMessage,
  }) : _isErrorMessageVisible = isErrorMessageVisible, _serverErrorMessage = serverErrorMessage;

  final bool _isErrorMessageVisible;
  final String _serverErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedOpacity(
          opacity: _isErrorMessageVisible ? 1.0 : 0.0, // Visible or Invisible
          duration: const Duration(milliseconds: 1000), // You can set your desired duration
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: primaryDark,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Text(
              _serverErrorMessage,
              style: const TextStyle(color: Colors.white), // 오류 메시지 스타일
            ),
          ),
        ),
      ),
    );
  }
}