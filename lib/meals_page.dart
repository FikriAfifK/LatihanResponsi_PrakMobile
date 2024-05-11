import 'package:flutter/material.dart';
import 'package:latihan_responsi/load_data_source.dart';
import 'package:latihan_responsi/detail_meals.dart';
import 'package:latihan_responsi/meals_model.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({Key? key, required this.strCategory}) : super(key: key);
  final String strCategory;

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.strCategory + " Meals"),
        centerTitle: true,
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.strCategory),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
            return _buildSuccessSection(mealsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealsModel data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5,),
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemMeals(data.meals![index]);
      },
    );
  }

  Widget _buildItemMeals(Meals mealsData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailMeals(
                idMeals: mealsData.idMeal!,
              )
          )
      ),
      child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Image.network(mealsData.strMealThumb!),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(mealsData.strMeal!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}