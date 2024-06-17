{
  programs.git = {
    enable = true;
    userName = "Atreya Shankar";
    userEmail = "35427332+atreyasha@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      credential.helper = "cache";
      commit.gpgsign = true;
    };
    lfs.enable = true;
  };
}
