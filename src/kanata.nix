{
  config,
  lib,
  pkgs,
  ...
}:
{

  services.kanata = {
    enable = true;

    keyboards.default = {
      config = ''
        (defsrc
          caps a s d f j k l scln apos
        )


        (defalias
          ;; tap-hold <tap-timeout> <hold-timeout> <tap-action> <hold-action>
          caps-mod (tap-hold-press 0 200 esc lmet)
          a-mod    (tap-hold-release 0 200 a lalt)
          s-mod    (tap-hold-release 0 200 s lalt)
          d-mod    (tap-hold-release 0 200 d lctl)
          f-mod    (tap-hold-release 0 200 f lsft)
          
          j-mod    (tap-hold-release 0 200 j rsft)
          k-mod    (tap-hold-release 0 200 k rctl)
          l-mod    (tap-hold-release 0 200 l ralt)
          semi-mod (tap-hold-release 0 200 scln ralt)
          apos-mod (tap-hold-release 0 200 apos rmet)
        )

        (deflayer base
          @caps-mod @a-mod @s-mod @d-mod @f-mod @j-mod @k-mod @l-mod @semi-mod @apos-mod
        )
      '';
      # devices = [];
      extraDefCfg = "process-unmapped-keys yes";
    };
  };

}
