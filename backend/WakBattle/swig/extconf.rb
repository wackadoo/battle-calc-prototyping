require 'mkmf'
#$libs = append_library($libs, "supc++")
dir_config("bcdir")
create_makefile('bc')
