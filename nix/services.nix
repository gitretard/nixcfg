{...}:
{
    services = {
	  pipewire = {
		  enable = true;	
		  alsa.enable = true;
		  pulse.enable = true;
      wireplumber.enable = true;
	  };
    gvfs.enable = true;
    tumbler.enable = true;
};
}