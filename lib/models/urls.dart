class Urls{
  String small;
  String regular;
  String full;
  String raw;
  String thumb;

  Urls({
    this.small,
    this.regular,
    this.full,
    this.raw,
    this.thumb,
  });

  factory Urls.fromMap(Map<String, dynamic> json) => Urls(
    small: json['small'],
    regular: json['regular'],
    full: json['full'],
    raw: json['raw'],
    thumb: json['thumb'],
  );
}