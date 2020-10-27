class Materials{
 final String id;

 final String title;
 final String description;
  List<Stain> stain;
  Materials({this.id, this.title, this.stain,this.description, });
}


class Stain {
 final  String stainId;
  final String stainTitle;
 final  double stainPrice;
   bool isSelected;

 Stain({this.stainId, this.stainTitle, this.stainPrice, this.isSelected});

}