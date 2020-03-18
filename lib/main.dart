import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:pigment/pigment.dart';
import 'package:flutter_html/flutter_html.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ndla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Pigment.fromString("a5bcd3"),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Animation bool for the Search bar
  bool isSearching = false;
  bool isSearchingAnim = false;
  // Activating Search and Animation
  void toggleIsSearching() {
    setState(() {
      isSearching = !isSearching;
      Future.delayed(const Duration(milliseconds: 350), () {
        setState(() {
          isSearchingAnim = !isSearchingAnim;
        });
      });
    });
  }

  // Deactivation Search and Reversing the animation
  void toggleIsSearchingReversed() {
    setState(() {
      isSearchingAnim = !isSearchingAnim;
      Future.delayed(const Duration(milliseconds: 350), () {
        setState(() {
          isSearching = !isSearching;
        });
      });
    });
  }

  // Animation bool for the three circular buttons
  bool expandedOne = false;
  bool expandedTwo = false;
  bool expandedThree = false;

  // Animation bool for the two Container Widgets below SIST SETT PÅ & FRA BLOGGEN.
  bool expandedBoxOne = false;
  bool expandedBoxTwo = false;
  bool expandedBoxThree = false;
  bool expandedBoxFour = false;

  // Search API call
  var searchInput;
  var searchResult;

  Future getSearch() async {
    // The reason I need to double up the searchInput check in the Future itself,
    // is so that when a user deletes what they wrote, the Future won't call the API with an empty query.
    if (searchInput.toString().isEmpty) {
      return null;
    } else {
      Map<String, String> queryParameters = {
        // Search Query
        'query': searchInput,
        // Page query, +1 when user scrolls to next page?
        'page': '1',
        // Don't display more than 5 results. Default: 10
        //'page-size': '5',
      };
      var uri = Uri.https('api.ndla.no', '/search-api/v1/search/', queryParameters);
      var response = await http.get(uri, headers: {
        // HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        return json.decode(response.body);
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // For each change in the SearchField, if searchField is longer than 0 characters, search!
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Scaffold(
      backgroundColor: Pigment.fromString("F8F8F8"),
      body: Stack(
        children: <Widget>[
          // Logo
          Container(
            width: wp(100),
            height: hp(30),
            color: Pigment.fromString("deebf6"),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: wp(10), right: wp(10), bottom: hp(2.5)),
                child: SvgPicture.asset('assets/logoWithText.svg', color: Pigment.fromString("20588f")),
              ),
            ),
          ),
          // The three circular buttons
          Stack(
            children: <Widget>[
              // 1
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(top: expandedOne ? hp(0) : hp(37.5), left: expandedOne ? wp(0) : wp(5)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedOne = !expandedOne;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedOne ? hp(100) : hp(15),
                      height: expandedOne ? hp(100) : hp(15),
                      decoration: BoxDecoration(
                        color: Pigment.fromString("deebf6"),
                        borderRadius: BorderRadius.circular(expandedOne ? hp(0) : hp(100)),
                      ),
                    ),
                  ),
                ),
              ),
              // 2
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(top: expandedTwo ? hp(0) : hp(37.5)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedTwo = !expandedTwo;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedTwo ? hp(100) : hp(15),
                      height: expandedTwo ? hp(100) : hp(15),
                      decoration: BoxDecoration(
                        color: Pigment.fromString("deebf6"),
                        borderRadius: BorderRadius.circular(expandedTwo ? hp(0) : hp(100)),
                      ),
                    ),
                  ),
                ),
              ),
              // 3
              Align(
                alignment: Alignment.topRight,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(top: expandedThree ? hp(0) : hp(37.5), right: expandedThree ? wp(0) : wp(5)),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedThree = !expandedThree;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedThree ? hp(100) : hp(15),
                      height: expandedThree ? hp(100) : hp(15),
                      decoration: BoxDecoration(
                        color: Pigment.fromString("deebf6"),
                        borderRadius: BorderRadius.circular(expandedThree ? hp(0) : hp(100)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Sist sett på
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: hp(55), left: wp(2.5)),
                  child: Text(
                    "SIST SETT PÅ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedBoxOne = !expandedBoxOne;
                    // Implement setState
                  });
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    padding:
                        EdgeInsets.only(top: expandedBoxOne ? hp(0) : hp(59), left: expandedBoxOne ? wp(0) : wp(2.5)),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedBoxOne ? wp(100) : wp(46.25),
                      height: expandedBoxOne ? hp(100) : hp(15),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              // 2
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedBoxTwo = !expandedBoxTwo;
                    // Implement setState
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    padding:
                        EdgeInsets.only(top: expandedBoxTwo ? hp(0) : hp(59), right: expandedBoxTwo ? wp(0) : wp(2.5)),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedBoxTwo ? wp(100) : wp(46.25),
                      height: expandedBoxTwo ? hp(100) : hp(15),
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Fra Bloggen
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: hp(77), left: wp(2.5)),
                  child: Text(
                    "FRA BLOGGEN",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                ),
              ),
              // 1
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedBoxThree = !expandedBoxThree;
                    // Implement setState
                  });
                },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.only(
                        top: expandedBoxThree ? hp(0) : hp(81), left: expandedBoxThree ? wp(0) : wp(2.5)),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedBoxThree ? wp(100) : wp(46.25),
                      height: expandedBoxThree ? hp(100) : hp(15),
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
              // 2
              GestureDetector(
                onTap: () {
                  setState(() {
                    expandedBoxFour = !expandedBoxFour;
                    // Implement setState
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    padding: EdgeInsets.only(
                        top: expandedBoxFour ? hp(0) : hp(81), right: expandedBoxFour ? wp(0) : wp(2.5)),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      width: expandedBoxFour ? wp(100) : wp(46.25),
                      height: expandedBoxFour ? hp(100) : hp(15),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // SearchField + Yellow background animation
          // The reason this widget is on the bottom of the stack is for the simple reason that it must overlay the other
          // widgets, when it does its expanding animation. The rest of the widgets have separate animation widgets below.
          Stack(
            children: <Widget>[
              AnimatedPadding(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.only(top: isSearching ? hp(0) : hp(25), left: isSearching ? wp(0) : wp(5)),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  width: isSearching ? wp(100) : wp(90),
                  height: isSearching ? hp(100) : hp(10),
                  color: Pigment.fromString("fde74c"),
                  child: AnimatedAlign(
                    alignment: isSearching ? Alignment.topCenter : Alignment.center,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.only(
                          top: isSearching ? hp(7) : hp(0),
                          left: isSearching ? wp(10) : wp(5),
                          right: isSearching ? wp(10) : wp(5)),
                      child: AnimatedPadding(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                        padding: EdgeInsets.only(left: isSearchingAnim ? wp(5) : wp(0)),
                        child: TextField(
                          onChanged: (input) {
                            searchInput = input;
                            setState(() {});
                          },
                          // If isSearching = true, animate. If not, don't.
                          onTap: isSearching ? null : toggleIsSearching,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide(color: Pigment.fromString("a5bcd3"))),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Hva vil du lære om i dag?",
                            contentPadding: EdgeInsets.only(left: wp(2.5), top: 0),
                            hintStyle: TextStyle(color: Colors.grey),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Expanding white box
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(top: hp(23)),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    width: wp(100),
                    height: isSearchingAnim ? hp(100) : hp(0),
                    color: Colors.white,
                    // Here is the Column Widget of the search results
                    child: FutureBuilder(
                      // If searchInput is empty (aka null), don't call Future.
                      future: searchInput == null ? null : getSearch(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            // If totalCount is larger than 10, then return the pageSize (aka number of search results)
                            // requested by the user. If totalCount is smaller than 10, search results = totalCount.
                            itemCount: snapshot.data['totalCount'] > 10
                                ? snapshot.data['pageSize']
                                : snapshot.data['totalCount'],
                            itemBuilder: (BuildContext context, int i) {
                              // If user has searched something, and there is no search result (aka totalCount), return:
                              return snapshot.data['totalCount'] == 0 && searchInput.toString().isEmpty
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // Transferring the article ID to a new screen, that can then use the
                                                  // id to find the article and display subsequent information.
                                                  ArticlePage(snapshot.data['results'][i]['id'].toString())),
                                        );
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: hp(2.5), left: wp(2.5), right: wp(2.5)),
                                          child: Column(
                                            children: <Widget>[
                                              // Gesture detector for selecting a search result
                                              Row(
                                                children: <Widget>[
                                                  // Title
                                                  Flexible(
                                                    child: Container(
                                                      //width: wp(100),
                                                      child: Text(
                                                        snapshot.data['results'][i]['title']['title'],
                                                        style: TextStyle(
                                                            color: Pigment.fromString("20588f"),
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                  // Content type icon
                                                  Padding(
                                                    padding: EdgeInsets.only(left: wp(2.5), right: wp(5)),
                                                    child: Icon(
                                                      Icons.open_in_new,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Description
                                              Padding(
                                                padding: EdgeInsets.only(top: hp(1)),
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        snapshot.data['results'][i]['metaDescription']
                                                            ['metaDescription'],
                                                        overflow: TextOverflow.clip,
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                    // Image next to the description
                                                    // If there is no image, return an empty Container Widget
                                                    snapshot.data['results'][i]['metaImage'] == null
                                                        ? Container()
                                                        : Padding(
                                                            padding: EdgeInsets.only(left: wp(1.5)),
                                                            child: Container(
                                                              width: wp(22.5),
                                                              height: hp(10),
                                                              child: Image.network(
                                                                snapshot.data['results'][i]['metaImage']['url'],
                                                                semanticLabel: snapshot.data['results'][i]['metaImage']
                                                                    ['alt'],
                                                                fit: BoxFit.contain,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              // Divider
                                              Padding(
                                                padding: EdgeInsets.only(top: hp(2.5)),
                                                child: Container(
                                                  width: wp(100),
                                                  height: 1,
                                                  color: Colors.black38,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner.
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
              // Animated back button
              AnimatedPadding(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                padding:
                    EdgeInsets.only(left: isSearchingAnim ? wp(5.5) : wp(8), top: isSearchingAnim ? hp(8) : hp(10)),
                child: GestureDetector(
                  onTap: toggleIsSearchingReversed,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    width: isSearchingAnim ? wp(8) : 0,
                    height: isSearchingAnim ? hp(5) : 0,
                    child: SvgPicture.asset('assets/arrow_back.svg', color: Pigment.fromString("20588f")),
                  ),
                ),
              ),
              // Expanding blue box
              AnimatedPadding(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.only(top: isSearchingAnim ? hp(19) : hp(23)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    width: wp(80),
                    height: isSearchingAnim ? hp(7.5) : hp(0),
                    color: Pigment.fromString("deebf6"),
                    // Below is the Row Widget that displays the different content types
                    child: Padding(
                      padding: EdgeInsets.only(left: wp(2.5), right: wp(2.5), top: hp(2)),
                      // Disables ListView Overflow animation
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (OverscrollIndicatorNotification o) {
                          o.disallowGlow();
                          return;
                        },
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Alle",
                                  style: TextStyle(
                                      color: Pigment.fromString("20588f"), fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Emne",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Læringssti",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Fagstoff",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Oppgaver og aktiviteter",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Vurderingsressurs",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Kildemateriale",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(2.5)),
                              child: Text("Ekstern læringsressurs",
                                  style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Here are the widgets that allow the animations to flow over each other,
          // no matter where they are placed in the Stack widget above.
          // The three buttons animation
          Padding(
            padding: EdgeInsets.only(top: expandedOne ? hp(0) : expandedTwo ? hp(0) : expandedThree ? hp(0) : hp(100)),
            child: Align(
              alignment: expandedOne
                  ? Alignment.topLeft
                  : expandedTwo ? Alignment.topCenter : expandedThree ? Alignment.topRight : Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    expandedOne = false;
                    expandedTwo = false;
                    expandedThree = false;
                  });
                },
                child: AnimatedPadding(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.only(
                      top: expandedOne ? hp(0) : expandedTwo ? hp(0) : expandedThree ? hp(0) : hp(37.5),
                      left: expandedOne ? wp(0) : expandedTwo ? wp(0) : expandedThree ? wp(0) : wp(5),
                      right: expandedOne ? wp(0) : expandedTwo ? wp(0) : expandedThree ? wp(0) : wp(5)),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.fastOutSlowIn,
                    width: expandedOne ? hp(100) : expandedTwo ? hp(100) : expandedThree ? hp(100) : hp(15),
                    height: expandedOne ? hp(100) : expandedTwo ? hp(100) : expandedThree ? hp(100) : hp(15),
                    decoration: BoxDecoration(
                      color: Pigment.fromString("deebf6"),
                      borderRadius: BorderRadius.circular(
                          expandedOne ? hp(0) : expandedTwo ? hp(0) : expandedThree ? hp(0) : hp(100)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SIST SETT PÅ buttons animation
          Padding(
            padding: EdgeInsets.only(top: expandedBoxOne ? hp(0) : expandedBoxTwo ? hp(0) : hp(100)),
            child: Align(
              alignment: expandedBoxOne ? Alignment.topLeft : expandedBoxTwo ? Alignment.topRight : Alignment.topLeft,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedBoxOne = false;
                        expandedBoxTwo = false;
                      });
                    },
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.only(
                          top: expandedBoxOne ? hp(0) : expandedBoxTwo ? hp(0) : hp(59),
                          left: expandedBoxOne ? wp(0) : expandedBoxTwo ? wp(0) : wp(2.5),
                          right: expandedBoxOne ? wp(0) : expandedBoxTwo ? wp(0) : wp(2.5)),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 350),
                        curve: Curves.fastOutSlowIn,
                        width: expandedBoxOne ? wp(100) : expandedBoxTwo ? wp(100) : wp(46.25),
                        height: expandedBoxOne ? hp(100) : expandedBoxTwo ? hp(100) : hp(15),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // FRA BLOGGEN buttons animation
          Padding(
            padding: EdgeInsets.only(top: expandedBoxThree ? hp(0) : expandedBoxFour ? hp(0) : hp(100)),
            child: Align(
              alignment:
                  expandedBoxThree ? Alignment.topLeft : expandedBoxFour ? Alignment.topRight : Alignment.topLeft,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        expandedBoxThree = false;
                        expandedBoxFour = false;
                      });
                    },
                    child: AnimatedPadding(
                      duration: Duration(milliseconds: 350),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.only(
                          top: expandedBoxThree ? hp(0) : expandedBoxFour ? hp(0) : hp(81),
                          left: expandedBoxThree ? wp(0) : expandedBoxFour ? wp(0) : wp(2.5),
                          right: expandedBoxThree ? wp(0) : expandedBoxFour ? wp(0) : wp(2.5)),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 350),
                        curve: Curves.fastOutSlowIn,
                        width: expandedBoxThree ? wp(100) : expandedBoxFour ? wp(100) : wp(46.25),
                        height: expandedBoxThree ? hp(100) : expandedBoxFour ? hp(100) : hp(15),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState(this.chosenArticle);

  String chosenArticle;
  ArticlePage(this.chosenArticle);
}

class _ArticlePageState extends State<ArticlePage> {
  String chosenArticle;
  _ArticlePageState(this.chosenArticle);

  Future getArticle() async {
    Map<String, String> queryParameters = {
      // Search Query
      //'query': query,
    };
    var uri = Uri.https('api.ndla.no', '/article-api/v2/articles/$chosenArticle', queryParameters);
    var response = await http.get(uri, headers: {
      // HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  var articleImage;
  Future getArticleImage() async {
    Map<String, String> queryParameters = {
      // Search Query
      //'query': query,
    };
    var uri = Uri.https('api.ndla.no', '/image-api/v2/images/$articleImage', queryParameters);
    var response = await http.get(uri, headers: {
      // HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Scaffold(
      backgroundColor: Pigment.fromString("F8F8F8"),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: getArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // A regular expression plucking the visualElement string to feed the getArticleImage Future
                // If visualElement is empty, articleImage == null & the future is not called.
                final text =
                    snapshot.data['visualElement'] == null ? "" : snapshot.data['visualElement']['visualElement'];
                RegExp exp = new RegExp(r'(?:(?:https?|ftp)://)?[w/-?=%.]+.[w/-?=%.]+');
                Iterable matches = exp.allMatches(text);
                matches.forEach((match) {
                  articleImage =
                      text.substring(match.start, match.end).substring(1).replaceAll(">", "").replaceFirst('"', "");
                });
                return ListView(
                  children: <Widget>[
                    Text(
                      chosenArticle,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      snapshot.data['title']['title'],
                      style: TextStyle(fontSize: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        // "Type: Writer": snapshot.data['copyright']['creators'][0]['type']
                        snapshot.data['copyright']['creators'][0]['name'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    // If there is no introduction, return an empty Container Widget
                    snapshot.data['introduction'] == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              // "Type: Writer": snapshot.data['copyright']['creators'][0]['type']
                              snapshot.data['introduction']['introduction'],
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                    // Image under the introduction
                    // If there is no image, return an empty Container Widget
                    articleImage == null
                        ? Container()
                        : FutureBuilder(
                            future: getArticleImage(),
                            builder: (context, snapshot) {
                              return Image.network(
                                snapshot.data['imageUrl'],
                                semanticLabel: snapshot.data['alttext']['alttext'],
                                fit: BoxFit.contain,
                              );
                            }),
                    // Content
                    Html(
                      data: snapshot.data['content']['content'],
                      //Optional parameters:
                      //defaultTextStyle: TextStyle(fontFamily: 'serif'),
                      linkStyle: const TextStyle(
                        color: Colors.redAccent,
                      ),
                      onLinkTap: (url) {
                        // open url in a webview
                      },
                      onImageTap: (src) {
                        // Display the image in large form.
                      },
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: <Widget>[
                    Text("${snapshot.error}"),
                  ],
                );
              }
              // By default, show a loading spinner.
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
