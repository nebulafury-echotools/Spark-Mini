class APIFrame {
  int? err_code;
  final String? err_description;
  final String? sessionid;
  final String sessionip;
  final String game_status;
  final double game_clock;
  final String match_type;
  final bool? private_match;
  final String client_name;
  final String game_clock_display;
  final int blue_points;
  final int orange_points;
  final List<APITeam> teams;
  final APILastThrow last_throw;
  final String rules_changed_by;
  final int rules_changed_at;
  final Map<String, dynamic> raw;

  APIFrame({
    this.err_code,
    this.err_description,
    this.sessionid,
    this.sessionip = '',
    this.game_status = '',
    this.game_clock = 0,
    this.match_type = '',
    this.private_match,
    this.client_name = '',
    this.game_clock_display = '',
    this.blue_points = 0,
    this.orange_points = 0,
    List<APITeam>? teams,
    APILastThrow? last_throw,
    this.rules_changed_by = '',
    this.rules_changed_at = 0,
    Map<String, dynamic>? raw,
  })  : teams = teams ??
            <APITeam>[
              APITeam(team: '', players: <APIPlayer>[]),
              APITeam(team: '', players: <APIPlayer>[]),
              APITeam(team: '', players: <APIPlayer>[]),
            ],
        last_throw = last_throw ?? APILastThrow.empty(),
        raw = raw ?? <String, dynamic>{};

  factory APIFrame.fromJson(Map<String, dynamic> json) {
    var teamsMap = <APITeam>[
      APITeam(team: "", players: <APIPlayer>[]),
      APITeam(team: "", players: <APIPlayer>[]),
      APITeam(team: "", players: <APIPlayer>[]),
    ];
    if (json['teams'] != null) {
      teamsMap = json['teams']
          .map<APITeam>((teamJSON) => APITeam.fromJson(teamJSON))
          .toList();
    }
    var lastThrowMap = APILastThrow(
      arm_speed: 0,
      total_speed: 0,
      off_axis_spin_deg: 0,
      wrist_throw_penalty: 0,
      rot_per_sec: 0,
      pot_speed_from_rot: 0,
      speed_from_arm: 0,
      speed_from_movement: 0,
      speed_from_wrist: 0,
      wrist_align_to_throw_deg: 0,
      throw_align_to_movement_deg: 0,
      off_axis_penalty: 0,
      throw_move_penalty: 0,
    );
    if (json['last_throw'] != null) {
      lastThrowMap = APILastThrow.fromJson(json['last_throw']);
    }
    return APIFrame(
      err_code: json['err_code'],
      err_description: json['err_description'],
      sessionid: json['sessionid'],
      sessionip: json['sessionip'] ?? '',
      match_type: json['match_type'] ?? '',
      game_status: json['game_status'] ?? '',
      game_clock: (json['game_clock'] ?? 0).toDouble(),
      private_match: json['private_match'],
      client_name: json['client_name'] ?? '',
      game_clock_display: json['game_clock_display'] ?? '',
      blue_points: json['blue_points'] ?? 0,
      orange_points: json['orange_points'] ?? 0,
      teams: teamsMap,
      last_throw: lastThrowMap,
      rules_changed_by: json['rules_changed_by'] ?? '',
      rules_changed_at: json['rules_changed_at'] ?? 0,
      raw: json,
    );
  }
}

class APITeam {
  final String team;
  final List<APIPlayer> players;

  APITeam({this.team = '', this.players = const <APIPlayer>[]});

  factory APITeam.fromJson(Map<String, dynamic> json) {
    return APITeam(
      team: json['team'] ?? '',
      players: json.containsKey('players')
          ? json['players']
              .map<APIPlayer>((playerJSON) => APIPlayer.fromJson(playerJSON))
              .toList()
          : <APIPlayer>[],
    );
  }
}

class APIPlayer {
  final String name;
  final int ping;
  final APIStats stats;

  APIPlayer({this.name = '', this.ping = 0, APIStats? stats})
      : stats = stats ?? APIStats();

  factory APIPlayer.fromJson(Map<String, dynamic> json) {
    return APIPlayer(
      name: json['name'] ?? '',
      ping: json['ping'] ?? 0,
      stats: APIStats.fromJson(json['stats'] ?? <String, dynamic>{}),
    );
  }
}

class APIStats {
  final double possession_time;
  final int points;
  final int saves;
  final int goals;
  final int stuns;
  final int steals;
  final int blocks;
  final int assists;
  final int shots_taken;

  APIStats(
      {this.possession_time = 0,
      this.points = 0,
      this.saves = 0,
      this.goals = 0,
      this.stuns = 0,
      this.steals = 0,
      this.blocks = 0,
      this.assists = 0,
      this.shots_taken = 0});

  factory APIStats.fromJson(Map<String, dynamic> json) {
    return APIStats(
      possession_time: (json['possession_time'] ?? 0).toDouble(),
      points: json['points'] ?? 0,
      saves: json['saves'] ?? 0,
      goals: json['goals'] ?? 0,
      stuns: json['stuns'] ?? 0,
      steals: json['steals'] ?? 0,
      blocks: json['blocks'] ?? 0,
      assists: json['assists'] ?? 0,
      shots_taken: json['shots_taken'] ?? 0,
    );
  }
}

class APILastThrow {
  final double arm_speed;
  final double total_speed;
  final double off_axis_spin_deg;
  final double wrist_throw_penalty;
  final double rot_per_sec;
  final double pot_speed_from_rot;
  final double speed_from_arm;
  final double speed_from_movement;
  final double speed_from_wrist;
  final double wrist_align_to_throw_deg;
  final double throw_align_to_movement_deg;
  final double off_axis_penalty;
  final double throw_move_penalty;

  APILastThrow(
      {this.arm_speed = 0,
      this.total_speed = 0,
      this.off_axis_spin_deg = 0,
      this.wrist_throw_penalty = 0,
      this.rot_per_sec = 0,
      this.pot_speed_from_rot = 0,
      this.speed_from_arm = 0,
      this.speed_from_movement = 0,
      this.speed_from_wrist = 0,
      this.wrist_align_to_throw_deg = 0,
      this.throw_align_to_movement_deg = 0,
      this.off_axis_penalty = 0,
      this.throw_move_penalty = 0});

  factory APILastThrow.empty() => APILastThrow();

  factory APILastThrow.fromJson(Map<String, dynamic> json) {
    return APILastThrow(
      arm_speed: (json['arm_speed'] ?? 0).toDouble(),
      total_speed: (json['total_speed'] ?? 0).toDouble(),
      off_axis_spin_deg: (json['off_axis_spin_deg'] ?? 0).toDouble(),
      wrist_throw_penalty: (json['wrist_throw_penalty'] ?? 0).toDouble(),
      rot_per_sec: (json['rot_per_sec'] ?? 0).toDouble(),
      pot_speed_from_rot: (json['pot_speed_from_rot'] ?? 0).toDouble(),
      speed_from_arm: (json['speed_from_arm'] ?? 0).toDouble(),
      speed_from_movement: (json['speed_from_movement'] ?? 0).toDouble(),
      speed_from_wrist: (json['speed_from_wrist'] ?? 0).toDouble(),
      wrist_align_to_throw_deg:
          (json['wrist_align_to_throw_deg'] ?? 0).toDouble(),
      throw_align_to_movement_deg:
          (json['throw_align_to_movement_deg'] ?? 0).toDouble(),
      off_axis_penalty: (json['off_axis_penalty'] ?? 0).toDouble(),
      throw_move_penalty: (json['throw_move_penal'] ?? 0).toDouble(),
    );
  }
}
