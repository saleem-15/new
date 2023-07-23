import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';

class BackToTopButton extends StatefulWidget {
  final ScrollController scrollController;

  const BackToTopButton({
    super.key,
    required this.scrollController,
  });

  @override
  State<BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<BackToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _isVisible =
          widget.scrollController.offset > 200; // Adjust this value to control when the button appears
    });
  }

  void _backToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final animationDuration = const Duration(milliseconds: 400);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: animationDuration,
      child: AnimatedContainer(
        duration: animationDuration,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        width: _isVisible ? 56.0 : 0.0,
        height: _isVisible ? 56.0 : 0.0,
        child: _isVisible
            ? FloatingActionButton(
                backgroundColor: ManagerColors.purplePrimary,
                // mini: true,
                isExtended: true,

                onPressed: _backToTop,
                shape: const CircleBorder(),
                child: const Icon(Icons.arrow_upward),
              )
            : Container(),
      ),
    );
  }
}
