{
  programs.git = {
    enable = true;
    userName = "Atreya Shankar";
    userEmail = "35427332+atreyasha@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      credential.helper = "cache";
      user.signingkey = "0xFB88142808F7FAE8!";
      commit.gpgsign = true;
    };
    lfs.enable = true;
  };
}
