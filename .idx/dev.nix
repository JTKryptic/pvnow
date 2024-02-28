{pkgs, ...}: {
  channel = "stable-23.11";
  packages = [
    pkgs.flutter
    pkgs.jdk17
  ];
  idx.extensions = [];
  idx.previews = {
    enable = true;
    previews = [
        {
            command = ["flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555"];
            id = "android";
            manager = "flutter";
        }
        {
            id = "ios";
            manager = "ios";
        }
    ];
  };
}