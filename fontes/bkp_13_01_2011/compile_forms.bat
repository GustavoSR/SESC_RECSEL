::compile_forms.bat 
cls 
Echo compiling Forms....
for %%f IN (*.fmb) do frmcmp userid=usr_sesc_recsel/oracle@d2  module=%%f batch=yes 
    module_type=form compile_all=yes window_state=minimize 
ECHO FINISHED COMPILING