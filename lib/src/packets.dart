import 'package:raw/raw.dart';

class LapData {
  double lastLapTime;
  double currentLapTime;
  double bestLapTime;
  double sector1Time;
  double sector2Time;
  double lapDistance;
  double totalDistance;
  double safetyCarDelta;
  int carPosition;
  int currentLapNum;
  int pitStatus;
  int sector;
  int currentLapInvalid;
  int penalties;
  int gridPosition;
  int driverStatus;
  int resultStatus;

  LapData(RawReader reader) {
    lastLapTime = reader.readFloat32();
    currentLapTime = reader.readFloat32();
    bestLapTime = reader.readFloat32();
    sector1Time = reader.readFloat32();
    sector2Time = reader.readFloat32();
    lapDistance = reader.readFloat32();
    totalDistance = reader.readFloat32();
    safetyCarDelta = reader.readFloat32();
    carPosition = reader.readUint8();
    currentLapNum = reader.readUint8();
    pitStatus = reader.readUint8();
    sector = reader.readUint8();
    currentLapInvalid = reader.readUint8();
    penalties = reader.readUint8();
    gridPosition = reader.readUint8();
    driverStatus = reader.readUint8();
    resultStatus = reader.readUint8();
  }
}

class MarshalZone {
  double zoneStart;
  int zoneFlag;

  MarshalZone(RawReader reader) {
    zoneStart = reader.readFloat32();
    zoneFlag = reader.readInt8();
  }
}

class PacketHeader {
  int packetFormat;
  int gameMajorVersion;
  int gameMinorVersion;
  int packetVersion;
  int packetId;
  double sessionUID;
  double sessionTime;
  int frameIdentifier;
  int playerCarIndex;

  PacketHeader(RawReader reader) {
    packetFormat = reader.readUint16();
    gameMajorVersion = reader.readUint8();
    gameMinorVersion = reader.readUint8();
    packetVersion = reader.readUint8();
    packetId = reader.readUint8();
    sessionUID = reader.readFloat64();
    sessionTime = reader.readFloat32();
    frameIdentifier = reader.readUint32();
    playerCarIndex = reader.readUint8();
  }
}

class PacketLapData {
  List<LapData> lapData;

  PacketLapData(RawReader reader) {
    final List<LapData> tempLapData = <LapData>[];
    for (int i = 0; i < 20; i += 1) {
      tempLapData.add(LapData(reader));
    }
    lapData = tempLapData;
  }
}

class PacketSessionData {
  int weather;
  int trackTemperature;
  int airTemperature;
  int totalLaps;
  int trackLength;
  int sessionType;
  int trackId;
  int formula;
  int sessionTimeLeft;
  int sessionDuration;
  int pitSpeedLimit;
  int gamePaused;
  int isSpectating;
  int spectatorCarIndex;
  int sliProNativeSupport;
  int numMarshalZones;
  List<MarshalZone> marshalZones;
  int safetyCarStatus;
  int networkGame;

  PacketSessionData(RawReader reader) {
    weather = reader.readUint8();
    trackTemperature = reader.readInt8();
    airTemperature = reader.readInt8();
    totalLaps = reader.readUint8();
    trackLength = reader.readUint16();
    sessionType = reader.readUint8();
    trackId = reader.readInt8();
    formula = reader.readUint8();
    sessionTimeLeft = reader.readUint16();
    sessionDuration = reader.readUint16();
    pitSpeedLimit = reader.readUint8();
    gamePaused = reader.readUint8();
    isSpectating = reader.readUint8();
    spectatorCarIndex = reader.readUint8();
    sliProNativeSupport = reader.readUint8();
    numMarshalZones = reader.readUint8();
    final List<MarshalZone> tempMarshalZones = <MarshalZone>[];
    for (int i = 0; i < numMarshalZones; i += 1) {
      tempMarshalZones.add(MarshalZone(reader));
    }
    marshalZones = tempMarshalZones;
    safetyCarStatus = reader.readUint8();
    networkGame = reader.readUint8();
  }
}

class ParticipantData {
  int aiControlled;
  int driverId;
  int teamId;
  int raceNumber;
  int nationality;
  String name;
  int yourTelemetry;

  ParticipantData(RawReader reader) {
    aiControlled = reader.readUint8();
    driverId = reader.readUint8();
    teamId = reader.readUint8();
    raceNumber = reader.readUint8();
    nationality = reader.readUint8();
    name = reader.readUtf8(48);
    yourTelemetry = reader.readUint8();
  }
}

class PacketParticipantsData {
  int numActiveCars;
  List<ParticipantData> participants;

  PacketParticipantsData(RawReader reader) {
    numActiveCars = reader.readUint8();
    final List<ParticipantData> tempParticipants = <ParticipantData>[];
    for (int i = 0; i < 20; i += 1) {
      tempParticipants.add(ParticipantData(reader));
    }
    participants = tempParticipants;
  }
}

class CarTelemetryData {
  int speed;
  double throttle;
  double steer;
  double brake;
  int clutch;
  int gear;
  int engineRPM;
  int drs;
  int revLightsPercent;
  List<int> brakesTemperature;
  List<int> tyresSurfaceTemperature;
  List<int> tyresInnerTemperature;
  int engineTemperature;
  List<double> tyresPressure;
  List<int> surfaceType;

  CarTelemetryData(RawReader reader) {
    speed = reader.readUint16();
    throttle = reader.readFloat32();
    steer = reader.readFloat32();
    brake = reader.readFloat32();
    clutch = reader.readUint8();
    gear = reader.readInt8();
    engineRPM = reader.readUint16();
    drs = reader.readUint8();
    revLightsPercent = reader.readUint8();
    brakesTemperature = [reader.readUint16(), reader.readUint16(), reader.readUint16(), reader.readUint16()];
    tyresSurfaceTemperature = [reader.readUint16(), reader.readUint16(), reader.readUint16(), reader.readUint16()];
    tyresInnerTemperature = [reader.readUint16(), reader.readUint16(), reader.readUint16(), reader.readUint16()];
    engineTemperature = reader.readUint16();
    tyresPressure = [reader.readFloat32(), reader.readFloat32(), reader.readFloat32(), reader.readFloat32()];
    surfaceType = [reader.readUint8(), reader.readUint8(), reader.readUint8(), reader.readUint8()];
  }
}

class PacketCarTelemetryData {
  List<CarTelemetryData> carTelemetryData;
  int buttonStatus;

  PacketCarTelemetryData(RawReader reader) {
    final List<CarTelemetryData> tempCarTelemetryData = <CarTelemetryData>[];
    for (int i = 0; i < 20; i += 1) {
      tempCarTelemetryData.add(CarTelemetryData(reader));
    }
    carTelemetryData = tempCarTelemetryData;
    buttonStatus = reader.readUint32();
  }
}

class CarStatusData {
  int tractionControl;
  int antiLockBrakes;
  int fuelMix;
  int frontBrakeBias;
  int pitLimiterStatus;
  int fuelInTank;
  double fuelCapacity;
  double fuelRemainingLaps;
  int maxRPM;
  int idleRPM;
  int maxGears;
  int drsAllowed;
  List<int> tyresWear;
  int actualTyreCompound;
  int tyreVisualCompound;
  List<int> tyresDamage;
  int frontLeftWingDamage;
  int frontRightWingDamage;
  int rearWingDamage;
  int engineDamage;
  int gearBoxDamage;
  int vehicleFiaFlags;
  double ersStoreEnergy;
  int ersDeployMode;
  double ersHarvestedThisLapMGUK;
  double ersHarvestedThisLapMGUH;
  double ersDeployedThisLap;

  CarStatusData(RawReader reader) {
    tractionControl = reader.readUint8();
    antiLockBrakes = reader.readUint8();
    fuelMix = reader.readUint8();
    frontBrakeBias = reader.readUint8();
    pitLimiterStatus = reader.readUint8();
    fuelInTank = reader.readUint8();
    fuelCapacity = reader.readFloat32();
    fuelRemainingLaps = reader.readFloat32();
    maxRPM = reader.readUint16();
    idleRPM = reader.readUint16();
    maxGears = reader.readUint8();
    drsAllowed = reader.readUint8();
    tyresWear = [reader.readUint8(), reader.readUint8(), reader.readUint8(), reader.readUint8()];
    actualTyreCompound = reader.readUint8();
    tyreVisualCompound = reader.readUint8();
    tyresDamage = [reader.readUint8(), reader.readUint8(), reader.readUint8(), reader.readUint8()];
    frontLeftWingDamage = reader.readUint8();
    frontRightWingDamage = reader.readUint8();
    rearWingDamage = reader.readUint8();
    engineDamage = reader.readUint8();
    gearBoxDamage = reader.readUint8();
    vehicleFiaFlags = reader.readInt8();
    ersStoreEnergy = reader.readFloat32();
    ersDeployMode = reader.readUint8();
    ersHarvestedThisLapMGUK = reader.readFloat32();
    ersHarvestedThisLapMGUH = reader.readFloat32();
    ersDeployedThisLap = reader.readFloat32();
  }
}


class PacketCarStatusData {
  List<CarStatusData> carStatusData;

  PacketCarStatusData(RawReader reader) {
    final List<CarStatusData> tempCarStatusData = <CarStatusData>[];
    for (int i = 0; i < 20; i += 1) {
      tempCarStatusData.add(CarStatusData(reader));
    }
    carStatusData = tempCarStatusData;
  }
}