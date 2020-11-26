
class RoomDetails {
  static final RoomDetails _roomDetails= RoomDetails._internal();

  factory RoomDetails(){
    return _roomDetails;
  }

  RoomDetails._internal();

  String roomID = "";
  String storyTitle = "";
  String receiverName = "";
  String receiverID = "";
  String status = "";

  void clearDetails()
  {
    roomID = "";
    storyTitle = "";
    receiverName = "";
    receiverID = "";
    status = "";
  }

}