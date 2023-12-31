{ config, pkgs, ... }:
{ 

  home.packages = with pkgs; [
    swww
  ];

  wayland.windowManager.hyprland = {	
		enable = true;
		xwayland.enable = true;
    settings = {
      "$mod" = "Alt";
      "$terminal" = "alacritty";

      exec-once = [
        "swww init && swww img ~/w.png"
      ];

      bind = [
        "$mod, space, exec, $terminal"
        "$mod, Tab, exec, wofi --show drun --allow-images"
        "$mod, q, killactive"
        "$mod, p, exec, poweroff"
        "$mod, l, exec, reboot"
        "$mod, k, exec, hyprctl dispatch exit"
      ] ++ 
      (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );

      monitor = "HDMI-A-1,1920x1080@144,0x0,1";

      input = {
        kb_layout = "us";
      };

      general = {
        gaps_in = 10;
        gaps_out = 15;
        border_size = 0;
        "col.active_border" = "rgba(88888888)";
        "col.inactive_border" = "rgba(00000088)";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
        blur = {
          enabled = true;
          new_optimizations = true;
          passes = 3;
          size = 3;
        };
      };

      animations = {
        enabled = true;
      };


    };
    # bindm later
		extraConfig = "
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
    ";
	};
}