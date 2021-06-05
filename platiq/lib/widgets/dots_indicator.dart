import 'package:flutter/material.dart';
import 'package:platiq/animations/scale_animation.dart';

class DotsIndicator extends StatelessWidget {
  final Function(int index) onPageChanged;
  final int currentIndex, length;

  const DotsIndicator(
      {Key? key,
      required this.onPageChanged,
      required this.currentIndex,
      required this.length})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) {
            return index == currentIndex
                ? _buildIndicator(context, index)
                : _buildPlaceHolder(context, index);
          },
        ),
      ),
    );
  }

  Widget _buildPlaceHolder(context, index) {
    return IconButton(
      splashRadius: 20,
      onPressed: () => onPageChanged(index),
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(context, index) {
    return ScaleAnimation(
      timeDuration: Duration(milliseconds: 1000),
      delay: Duration(milliseconds: 100),
      child: InkWell(
        onTap: () => onPageChanged(index),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 15,
            width: 35,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 3),
                  blurRadius: 5,
                )
              ],
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(500),
            ),
          ),
        ),
      ),
    );
  }
}
