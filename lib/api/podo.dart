class Street {
  int availableSpaces;
  String streetName;
  String id;
  String startLatitude;
  String startLongitude;
  String stopLatitude;
  String stopLongitude;
  List coordinateString;

  Street(
      {this.streetName,this.availableSpaces,
        this.id,
        this.startLatitude,
        this.startLongitude,
        this.stopLatitude,
        this.stopLongitude,this.coordinateString});

  Street.fromJson(Map<String, dynamic> json) {
    streetName=json['streetName'];
    availableSpaces = json['availableSpaces'];
    id = json['id'];
    startLatitude = json['startLatitude'];
    startLongitude = json['startLongitude'];
    stopLatitude = json['stopLatitude'];
    stopLongitude = json['stopLongitude'];
    coordinateString=json['coordinateString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetName']=this.streetName;
    data['availableSpaces'] = this.availableSpaces;
    data['id'] = this.id;
    data['startLatitude'] = this.startLatitude;
    data['startLongitude'] = this.startLongitude;
    data['stopLatitude'] = this.stopLatitude;
    data['stopLongitude'] = this.stopLongitude;
    data['coordinateString']=this.coordinateString;
    return data;
  }
}