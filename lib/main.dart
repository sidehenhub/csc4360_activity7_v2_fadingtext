import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: FadingTextAndImageAnimation(),
    );
  }
}

class FadingTextAndImageAnimation extends StatefulWidget {
  @override
  _FadingTextAndImageAnimationState createState() => _FadingTextAndImageAnimationState();
}

class _FadingTextAndImageAnimationState extends State<FadingTextAndImageAnimation> with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
   
    _controller=AnimationController(vsync:this,duration: Duration(seconds: 2));

   
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(_controller);
    _controller.repeat();
  }

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Fading Text and Image Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Hello, Flutter..Animation Time!',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20), 
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 3),
              child: Image.asset(
                'assets/fadeimg1.jpg', 
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20), 
            AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: Duration(seconds: 5),
                  child: Transform.rotate(
                    angle: _isVisible ? 0 : _rotationAnimation.value,
                    child: Image.asset(
                      'assets/fadeimg2.jpg', // Second local image
                      width: 200,
                      height: 200,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
