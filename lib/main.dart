import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled=false;

    return new MaterialApp(
      title: 'Rota do Mar',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new BrandAppBar(),
          new HomePageBody()
        ]
      )
    );
  }
}

class BrandAppBar extends StatelessWidget {
  final brand = new AssetImage('assets/logo-rota.png');
  //final String title;
  final double barHeight = 50.0;
  
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: barHeight + statusBarHeight,
      //height: 100.0,
      decoration: new BoxDecoration(
        color: Colors.white
      ),
      child: new Center(
        child: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: brand,
            )
          ),
        )
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {

  final Category male = new Category(
    name: 'Masculino',
    products: new List(),
    image: 'assets/maleCategorieBg.jpg'
  );

  final Category female = new Category(
      name: 'Feminino',
      products: new List(),
      image: 'assets/female-categorie.jpg'
  );

  final Category accessory = new Category(
    name: 'AcessórioS',
    products: new List(),
    image: 'assets/acessoryCategory.jpg'
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Expanded(
      child: new ListView(
        children: <Widget>[
          new CategoryRow(male),
          new CategoryRow(female),
          new CategoryRow(accessory),
          new CategoryRow(female),
        ],
      ),
    );
  }
}

class CategoryRow extends StatelessWidget {

  final Category category;

  CategoryRow(this.category);

  final headerTextStyle = const TextStyle(
      fontFamily: 'Exo2-Regular',
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {

    final categoryCard = new Stack(
      children: <Widget>[
        new Container(
          height: 200.0,
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(category.image),
                  fit: BoxFit.cover
              ),
              color: new Color.fromRGBO(58, 140, 178, 0.9),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0)
                )
              ]
          ),
          child: new Container(
            decoration: new BoxDecoration(
                color: new Color.fromRGBO(58, 140, 178, 0.7),
                shape: BoxShape.rectangle,
                borderRadius: new BorderRadius.circular(8.0)
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 90.0),
          child: new Center(
              child: new Text(
                category.name,
                style: const TextStyle(
                  fontFamily: 'Exo2-Regular',
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              )
          ),
        )
      ],
    );

    return new GestureDetector(
        onTap: () => Navigator.of(context).push(new CupertinoPageRoute(
          builder: (_) => new DetailPage(category),
        )),
        child: new Container(
          margin: new EdgeInsets.all(16.0),
          child: new Stack(
            children: <Widget>[
                categoryCard
              ],
           ),
          ),
       );
  }
}

class Category {
  final String name;
  final List products;
  final String image;

  const Category({this.name, this.products, this.image});
}

class DetailPage extends StatefulWidget {
  final Category tappedCategory;

  DetailPage(this.tappedCategory);

  _DetailPageState createState() => new _DetailPageState(tappedCategory);

}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  final Category tappedCategory;

  _DetailPageState(this.tappedCategory);

  Animation<double> animation;
  AnimationController controller;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      
      controller = new AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this
      );

      final CurvedAnimation curve = new CurvedAnimation(
          parent: controller,
          curve: Curves.fastOutSlowIn,
      );

      animation = new Tween(
        begin: 250.0,
        end: 80.0
      ). animate(curve)
      ..addListener((){
        setState(() {
                  
        });
      });

      controller.forward();
    }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Container(
                  height: animation.value + statusBarHeight,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(tappedCategory.image),
                      fit: BoxFit.cover
                    )
                  ),
                child: new Container(
                  decoration: new BoxDecoration(
                    color: new Color.fromRGBO(58, 140, 178, 0.7),
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0)
                  ),
                  child: new Center(
                    child: new Text(
                      tappedCategory.name,
                      style: const TextStyle(
                        fontFamily: 'Exo2-Regular',
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                )
               ),
              ],
            ),
            new Expanded(
              child: new CatalogGridView().build(),
            )
          ],
        ),
      ),
    );
  }

  

}

class CatalogGridView {

  final titleTextStyle = const TextStyle(
      fontFamily: 'Exo2-Regular',
      color: Colors.black,
      fontSize: 12.0,
      fontWeight: FontWeight.w800,
  );

  final priceTextStyle = const TextStyle(
      fontFamily: 'Exo2-Regular',
      color: Colors.black,
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
  );

  Card makeGridCell(String image, String name, String price){
      return new Card(
        elevation: 1.0,
        child: new Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              new Center(
                child: new Image(
                  image: new AssetImage(image),
                  width: 100.0,
                  height:100.0,
                ),
              ),
              new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(name, style: titleTextStyle,),
                    ),
                    new Text(price, style: priceTextStyle)
                  ],
                )
              ),
            ],
          ),
        ),
      );
  }


  GridView build(){
    return GridView.count(
      primary: true,
      padding: new EdgeInsets.all(1.0),
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: <Widget>[
        makeGridCell('assets/productEx.jpeg', 'Bermuda1', 'R\$59.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda2', 'R\$69.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda3', 'R\$89.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda4', 'R\$39.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
        makeGridCell('assets/productEx.jpeg', 'Bermuda5', 'R\$29.90'),
      ],
    );
  }



}