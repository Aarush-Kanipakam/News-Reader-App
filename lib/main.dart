//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DummyDataClass.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MyApp(),
    ),
  );
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF7E21CC),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 45, 107, 56),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: appState.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: ChangeNotifierProvider(
        create: (BuildContext context) => appState,
        child: MyHomePage(),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier {
  var bookmarks = [];
  bool darkMode = false;

  void toggleBookmark(dynamic p, dynamic q) {
    if (bookmarks.contains(p)) {
      bookmarks.remove(p);
    } else {
      bookmarks.add(p);
    }
    notifyListeners();
  }

  void toggleDarkMode() {
    darkMode = !darkMode;
    notifyListeners();
  }
}



class MyHomePage extends StatefulWidget {
  @override
  
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context);

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MainPage(); // Main page
        break;
      case 1:
        page = BookmarksPage(); // Bookmarks
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS READER APP'),
        backgroundColor: Color(0xFFD4D7DF),
        actions: [
          Switch(
            value: appState.darkMode,
            onChanged: (value) {
              appState.toggleDarkMode();
            },
          ),
        ],
      ),
      body: Row(
        children: [
          SafeArea(
            child: NavigationRail(
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: const Text('Home'),
                ),
                NavigationRailDestination(
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Bookmarks'),
                ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
        ],
      ),
    );
  }
}


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => In()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
                backgroundColor: Theme.of(context).primaryColor, // Use primary color
              ),
              child: Text(
                'INTERNATIONAL NEWS',
                
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Sp()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'SPORTS NEWS',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Bu()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'BUSINESS NEWS',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Te()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                'TECHNOLOGY NEWS',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class In extends StatelessWidget {
  const In();
  @override
  Widget build(BuildContext context) {
    
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = Provider.of<MyAppState>(context, listen: false);

    List<dummyData> a= newsArticles.where((article)=> article.category == 'International').toList();
    String p = '';
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('INTERNATIONAL NEWS',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      fontSize: 26.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Set to bold
                      color: Colors.black, // Set the text color
                    ),
                  ),
                    tileColor: Color(0xFFCC9768), 
                  ),
                ),
                
              ),
              for(var article in a)
                Column(
                  children: [
                    Card(
                      child: ListTile(
                         title: Text(article.title),
                         
                         
                         tileColor: Color(0XFFCCC67C),
                         ),
                        ),
                  
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){ 
                              p=article.title;
                              Navigator.push(context,
                            MaterialPageRoute(builder: (context) => intnews(p)));
                            },
                            
                            child: Text('Go'),
                          ),
                          ElevatedButton.icon(
                            onPressed: (){
                              appState.toggleBookmark(article.title,article.category);
                            } ,
                            icon: Icon(
                            
                               appState.bookmarks.contains(article.title)
                                  ?Icons.bookmark
                                  :Icons.bookmark_border, 
                            ),
                            label: Text('Bookmark'),
                            ),
                   SizedBox(height: 20),
                        ],
                      ), 
                      SizedBox(height: 60),
                   ],
                ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text('Back'),
              ),
            ],
          ),
        )
      ),
    );
  }
}
class Sp extends StatelessWidget {
  const Sp();
  @override
  Widget build(BuildContext context) {
    
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = Provider.of<MyAppState>(context, listen: false); // 

    List<dummyData> a= newsArticles.where((article)=> article.category == 'Sports').toList();
    String p = '';
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('SPORTS NEWS',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      fontSize: 26.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Set to bold
                      color: Colors.black, // Set the text color
                    ),
                  ),
                    tileColor: Color(0xFFCC9768), 
                  ),
                ),
                
              ),
              for(var article in a)
                Column(
                  children: [
                    Card(
                      child: ListTile(
                         title: Text(article.title),
                         
                         
                         tileColor: Color(0XFFCCC67C),
                         ),
                        ),
                  
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){ 
                              p=article.title;
                              Navigator.push(context,
                            MaterialPageRoute(builder: (context) => sponews(p)));
                            },
                            
                            child: Text('Go'),
                          ),
                          ElevatedButton.icon(
                            onPressed: (){
                              appState.toggleBookmark(article.title,article.category);
                            } ,
                            icon: Icon(
                            
                               appState.bookmarks.contains(article.title)
                                  ?Icons.bookmark
                                  :Icons.bookmark_border, 
                            ),
                            label: Text('Bookmark'),
                            ),
                        ],
                      ), 
                      SizedBox(height: 60),
                   ],
                ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text('Back'),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class Bu extends StatelessWidget {
  const Bu();
  @override
  Widget build(BuildContext context) {
    
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = Provider.of<MyAppState>(context, listen: false); // 

    List<dummyData> a= newsArticles.where((article)=> article.category == 'Business').toList();
    String p = '';
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('BUSINESS NEWS',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      fontSize: 26.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Set to bold
                      color: Colors.black, // Set the text color
                    ),
                  ),
                    tileColor: Color(0xFFCC9768),  
                  ),
                ),
                
              ),
              for(var article in a)
                Column(
                  children: [
                    Card(
                      child: ListTile(
                         title: Text(article.title),
                         
                         
                         tileColor: Color(0XFFCCC67C),
                         ),
                        ),
                  
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){ 
                              p=article.title;
                              Navigator.push(context,
                            MaterialPageRoute(builder: (context) => bunews(p)));
                            },
                            
                            child: Text('Go'),
                          ),
                          ElevatedButton.icon(
                            onPressed: (){
                              appState.toggleBookmark(article.title,article.category);
                            } ,
                            icon: Icon(
                            
                               appState.bookmarks.contains(article.title)
                                  ?Icons.bookmark
                                  :Icons.bookmark_border, 
                            ),
                            label: Text('Bookmark'),
                            ),
                        ],
                      ), 
                      SizedBox(height: 60),
                   ],
                ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text('Back'),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class Te extends StatelessWidget {
  const Te();
  @override
  Widget build(BuildContext context) {
    
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = Provider.of<MyAppState>(context, listen: false); // 

    List<dummyData> a= newsArticles.where((article)=> article.category == 'Technology').toList();
    String p = '';
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text('TECHNOLOGY NEWS',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      fontSize: 26.0, // Adjust the font size as needed
                      fontWeight: FontWeight.bold, // Set to bold
                      color: Colors.black, // Set the text color
                    ),
                  ),
                    tileColor: Color(0xFFCC9768),  
                  ),
                ),
                
              ),
              for(var article in a)
                Column(
                  children: [
                    Card(
                      child: ListTile(
                         title: Text(article.title),
                         
                         
                         tileColor: Color(0XFFCCC67C),
                         ),
                        ),
                  
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: (){ 
                              p=article.title;
                              Navigator.push(context,
                            MaterialPageRoute(builder: (context) => tecnews(p)));
                            },
                            
                            child: Text('Go'),
                          ),
                          ElevatedButton.icon(
                            onPressed: (){
                              appState.toggleBookmark(article.title,article.category);
                            } ,
                            icon: Icon(
                            
                               appState.bookmarks.contains(article.title)
                                  ?Icons.bookmark
                                  :Icons.bookmark_border, 
                            ),
                            label: Text('Bookmark'),
                            ),
                        ],
                      ), 
                      SizedBox(height: 60),
                   ],
                ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                child: Text('Back'),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class tecnews extends StatelessWidget {
  final String p;
  tecnews(this.p);
  
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    List<dummyData> b= newsArticles.where((article)=> article.title == p).toList();
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
            for(var article in b)
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                             title: Text(article.title,
                             style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                             ),
                             
                             ),
                             tileColor: Color(0xFF70BBCC),
                             ),
                             ),
                      
                    
                    Card(
                      child: ListTile(
                         title: Text(article.data),
                         tileColor: Color(0xFFCCB373),
                         ),
                         ),
                         SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Te()),
                );
                },
                child: Text('Back'),
                                  ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}     
class bunews extends StatelessWidget {
  final String p;
  bunews(this.p);
  
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    List<dummyData> b= newsArticles.where((article)=> article.title == p).toList();
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            for(var article in b)
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                             title: Text(article.title,
                             style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                             ),
                             
                             ),
                             tileColor: Color(0xFF70BBCC),
                             ),
                             ),
                      
                    
                    Card(
                      child: ListTile(
                         title: Text(article.data),
                         tileColor: Color(0xFFCCB373),
                         ),
                         ),
                         SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Bu()),
                );
                },
                child: Text('Back'),
                                  ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}   
class sponews extends StatelessWidget {
  final String p;
  sponews(this.p);
  
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    List<dummyData> b= newsArticles.where((article)=> article.title == p).toList();
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            for(var article in b)
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                             title: Text(article.title,
                             style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                             ),
                             
                             ),
                             tileColor: Color(0xFF70BBCC),
                             ),
                             ),
                      
                    
                    Card(
                      child: ListTile(
                         title: Text(article.data),
                         tileColor: Color(0xFFCCB373),
                         ),
                         ),
                         SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => Sp()),
                );
                },
                child: Text('Back'),
                                  ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}   

class intnews extends StatelessWidget {
  final String p;
  intnews(this.p);
  
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    List<dummyData> b= newsArticles.where((article)=> article.title == p).toList();
    return SingleChildScrollView(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            for(var article in b)
                    Column(
                      children: [
                        Card(
                          child: ListTile(
                             title: Text(article.title,
                             style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                             ),
                             
                             ),
                             tileColor: Color(0xFF70BBCC),
                             ),
                             ),
                      
                    
                    Card(
                      child: ListTile(
                         title: Text(article.data),
                         tileColor: Color(0xFFCCB373),
                         ),
                         ),
                         SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => In()),
                );
                },
                child: Text('Back'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}    

class BookmarksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<MyAppState>(context, listen: false);

    if (appState.bookmarks.isEmpty) {
      return Center(
        child: Text('No bookmarks yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${appState.bookmarks.length} bookmarks:'),
        ),
        for (var m in appState.bookmarks)
          Column(
            
            children: [
              
              ListTile(
                leading: Icon(Icons.bookmark),






                
                title: Text(m),
              ),
              ElevatedButton(
                
                onPressed: () {
                  var matchingArticles = newsArticles.where((article) => article.title == m).toList();
                  if (matchingArticles.isNotEmpty) {
                    var category = matchingArticles.first.category;
                    if (category == 'International'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => intnews(m)));
                    } else if(category == 'Sports'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => sponews(m)));
                    } else if(category == 'Business'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => bunews(m)));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => tecnews(m)));
                    }
                  }

                  
                },
                child: Text('Go'),
              ),
              SizedBox(height: 60),
            ],
          ),
      ],
    );
  }
}
