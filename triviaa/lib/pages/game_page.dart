import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triviaa/providers/game_page_provider.dart';

class GamePage extends StatelessWidget {
  final String difficultyLevel;
  double? _deviceHeight, _deviceWidth;
  GamePageProvider? _pageProvider;

  GamePage({required this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_context) => GamePageProvider(context: context, difficultyLevel: difficultyLevel),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (_context) {
        _pageProvider = _context.watch<GamePageProvider>();
        if (_pageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
                child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
            child: _gameUI(),
          ),
        )));
        }else{
          return const Center(child: CircularProgressIndicator(color: Colors.white,),);
        }
      }
    );
  }

  Widget _gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        Column(
          children: [
            _trueButton(),
            SizedBox(
              height: _deviceHeight! * 0.01,
            ),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestionText(),
      style: const TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("True");
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "True",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider?.answerQuestion("False");
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "False",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
