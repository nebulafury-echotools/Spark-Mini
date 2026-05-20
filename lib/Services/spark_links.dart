String getFormattedLink(
    String? sessionid,
    bool angleBrackets,
    int linkType,
    bool appendTeamNames,
    Map<String, dynamic> orangeVRMLTeamInfo,
    Map<String, dynamic> blueVRMLTeamInfo,
    [bool echoTaxiPrefix = false]) {
  sessionid ??= '**********************';

  String link = "";

  switch (linkType) {
    case 0:
      link = "spark://c/$sessionid";
      break;
    case 1:
      link = "spark://j/$sessionid";
      break;
    case 2:
      link = "spark://s/$sessionid";
      break;
  }

  if (echoTaxiPrefix) {
    link = "https://echo.taxi/$link";
  }

  if (angleBrackets) {
    link = "<$link>";
  }

  if (appendTeamNames) {
    String orangeName = '?';
    String blueName = '?';
    if (orangeVRMLTeamInfo.containsKey('team_name') &&
        orangeVRMLTeamInfo['team_name'] != '') {
      orangeName = orangeVRMLTeamInfo['team_name'];
    }
    if (blueVRMLTeamInfo.containsKey('team_name') &&
        blueVRMLTeamInfo['team_name'] != '') {
      blueName = blueVRMLTeamInfo['team_name'];
    }

    // if at least one team name exists
    if (orangeName != '?' || blueName != '?') {
      link = "$link $orangeName vs $blueName";
    }
  }

  return link;
}
