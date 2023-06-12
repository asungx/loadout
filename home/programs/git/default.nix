# Reference: https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ pkgs, ... } :
let
  gitConfig = {
    core = {
      editor = "nvim";
    };
    init.defaultBranch = "main";
  };

  deltaConfig = {
    enable = true;
    options = {
      line-numbers = true;
      navigate = true;
      side-by-side = true;
      syntax-theme = "Dracula";
    };
  };
in
{
  programs.git = {
    delta = deltaConfig;
    enable = true;
    extraConfig = gitConfig;
    userEmail = "98825515+asungx@users.noreply.github.com";
    userName = "asungx";
  };
}
