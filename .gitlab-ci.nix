{
  one = {
    stage = "build";
    script = ''
      echo script from nix defined pipeline ONE
    '';
  };
  two = {
    stage = "build";
    script = ''
      echo script from nix defined pipeline TWO
      exit 1
    '';
  };
}
