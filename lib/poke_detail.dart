import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  const PokeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png',
              height: 300,
              width: 300,
            ),
            const Text(
              'pikachu',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Chip(
              label: Text(
                'electric',
                style: TextStyle(
                    color: Colors.yellow.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white),
              ),
              backgroundColor: Colors.yellow,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}