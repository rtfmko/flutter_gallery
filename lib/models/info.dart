class Info{
  String makeOn;
  String model;
  String exposureTime;
  double aperture;
  double focalLength;
  int iso;

  Info({
    this.makeOn,
    this.model,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso
  });

  factory Info.fromMap(Map<String, dynamic> json) => Info(
    makeOn: json['make'],
    model: json['model'],
    exposureTime: json['exposure_time'],
    aperture: json['aperture'] != null
        ? double.parse(json['aperture'])
        : null,
    focalLength: json['focal_length'] != null
        ? double.parse(json['focal_length'])
        : null,
    iso: json['iso'],
  );
}