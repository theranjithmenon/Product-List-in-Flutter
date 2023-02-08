import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:product_list/Models/productModel.dart';

class productList extends StatelessWidget {
  const productList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Catalog App",
              style: TextStyle(fontSize: 35),
            ),
            Text(
              "Trending Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: Products.length,
          itemBuilder: (context, index) {
            return tile(index: index, context: context);
          }),
    );
  }

  Widget tile({index, context}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  Products[index]["image"],
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: MediaQuery.of(context).size.width * 0.3,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Products[index]["name"],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        Products[index]["description"],
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Products[index]["price"],
                          style: const TextStyle(fontSize: 18),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          textColor: Colors.white,
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Lottie.asset("assets/pay.json",
                                        height: 150, width: 150),
                                    content: Text(
                                      Products[index]["name"],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    actions: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        textColor: Colors.white,
                                        color: Colors.greenAccent,
                                        onPressed: () {},
                                        child: const Text(
                                          "Pay",
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text("Buy"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
