
class RoomDetails {
  static final RoomDetails _roomDetails= RoomDetails._internal();

  factory RoomDetails(){
    return _roomDetails;
  }

  RoomDetails._internal();

  String roomID = "";
  String storyTitle = "";
  String receiverName = "";

  void clearDetails()
  {
    roomID = "";
    storyTitle = "";
    receiverName = "";
  }

}