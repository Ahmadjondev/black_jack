import 'dart:math';

import 'package:flutter/material.dart';

class BlackJackScreen extends StatefulWidget {
  const BlackJackScreen({Key? key}) : super(key: key);

  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  final Map<String, int> deckOfCards = {
    "assets/2.1.png": 2,
    "assets/2.2.png": 2,
    "assets/2.3.png": 2,
    "assets/2.4.png": 2,
    "assets/3.1.png": 3,
    "assets/3.2.png": 3,
    "assets/3.3.png": 3,
    "assets/3.4.png": 3,
    "assets/4.1.png": 4,
    "assets/4.2.png": 4,
    "assets/4.3.png": 4,
    "assets/4.4.png": 4,
    "assets/5.1.png": 5,
    "assets/5.2.png": 5,
    "assets/5.3.png": 5,
    "assets/5.4.png": 5,
    "assets/6.1.png": 6,
    "assets/6.2.png": 6,
    "assets/6.3.png": 6,
    "assets/6.4.png": 6,
    "assets/7.1.png": 7,
    "assets/7.2.png": 7,
    "assets/7.3.png": 7,
    "assets/7.4.png": 7,
    "assets/8.1.png": 8,
    "assets/8.2.png": 8,
    "assets/8.3.png": 8,
    "assets/8.4.png": 8,
    "assets/9.1.png": 9,
    "assets/9.2.png": 9,
    "assets/9.3.png": 9,
    "assets/9.4.png": 9,
    "assets/10.1.png": 10,
    "assets/10.2.png": 10,
    "assets/10.3.png": 10,
    "assets/10.4.png": 10,
    "assets/J1.png": 10,
    "assets/J2.png": 10,
    "assets/J3.png": 10,
    "assets/J4.png": 10,
    "assets/Q1.png": 10,
    "assets/Q2.png": 10,
    "assets/Q3.png": 10,
    "assets/Q4.png": 10,
    "assets/K1.png": 10,
    "assets/K2.png": 10,
    "assets/K3.png": 10,
    "assets/K4.png": 10,
    "assets/A1.png": 11,
    "assets/A2.png": 11,
    "assets/A3.png": 11,
    "assets/A4.png": 11,
  };
  bool isGameStart = false;

  Map<String, int> playingCards = {};

  List<Image> myCards = [];
  List<Image> dealersCards = [];

  String? playersFirstCard;
  String? playersSecondCard;

  String? dealersFirstCard;
  String? dealersSecondCard;

  int playerScore = 0;
  int dealerScore = 0;

  @override
  void initState() {
    super.initState();
    playingCards.addAll(deckOfCards);
  }

  void addCard() {
    Random random = Random();

    if (playingCards.length > 0) {
      String cardKey =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => cardKey == key);
      myCards.add(Image.asset(cardKey));
      playerScore = playerScore + deckOfCards[cardKey]!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Black Jack")),
      body: isGameStart
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Dealer cards
                    Column(
                      children: [
                        Text(
                          "Dealer Score: $dealerScore",
                          style: TextStyle(
                              color: dealerScore <= 21
                                  ? Colors.green.shade900
                                  : Colors.red.shade900,fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 20),
                        CardWidget(dealersCards: dealersCards)
                      ],
                    ),
                    //player cards
                    Column(
                      children: [
                        Text(
                          "Player Score: $playerScore",
                          style: TextStyle(
                              color: dealerScore <= 21
                                  ? Colors.green.shade900
                                  : Colors.red.shade900,fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 20),
                        CardWidget(dealersCards: myCards)
                      ],
                    ),
                    // 2 button
                    IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MaterialButton(
                            onPressed: addCard,
                            color: Colors.blue.shade300,
                            child: Text("Another Card"),
                          ),
                          MaterialButton(
                            onPressed: changeCards,
                            color: Colors.blue.shade200,
                            child: Text("Next Round"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: MaterialButton(
                onPressed: changeCards,
                color: Colors.brown.shade200,
                child: Text("Start Game"),
              ),
            ),
    );
  }

  void changeCards() {
    setState(() {
      isGameStart = true;
    });
    playingCards.clear();
    playingCards.addAll(deckOfCards);
    myCards = [];
    dealersCards = [];

    Random random = Random();

    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardOneKey);

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    dealersSecondCard = cardTwoKey;

    playersFirstCard = cardThreeKey;
    playersSecondCard = cardFourKey;

    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));

    dealerScore =
        (deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!)!;

    myCards.add(Image.asset(playersFirstCard!));
    myCards.add(Image.asset(playersSecondCard!));

    playerScore =
        (deckOfCards[playersFirstCard]! + deckOfCards[playersSecondCard]!)!;

    if (dealerScore <= 14) {
      String card =
          playingCards.keys.elementAt(random.nextInt(playingCards.length));
      playingCards.removeWhere((key, value) => key == card);
      dealerScore += deckOfCards[card]!;
      dealersCards.add(Image.asset(card));
    }
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.dealersCards,
  });

  final List<Image> dealersCards;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
        itemCount: dealersCards.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return dealersCards[index];
        },
      ),
    );
  }
}
