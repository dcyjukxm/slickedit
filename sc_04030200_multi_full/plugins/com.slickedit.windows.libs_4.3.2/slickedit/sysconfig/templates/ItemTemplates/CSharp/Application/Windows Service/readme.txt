The following files have been created in the $workspacedir$ directory:

1. $fileinputname$Base.cs : The base implementation for the service.  Your 
service will perform start up initialization in the OnStartup function and 
will perform shut down in the OnStop function.

2. $fileinputname$InstallerBase.cs : Sets the details of the service during 
installation with the Service Control Manager.  Does not require modification.

3. $fileinputname$Main.cs : The main entry point for the service.  This class 
defines a constant named RUN_AS_SERVICE.  If this value is set to true, then 
the executable will run as a service and may be installed with the SCM.  If it 
is set to false, then it will run as a regular console application and may be 
debugged normally.

4. Service Install.bat : Batch file to install the service with the SCM.  Make
sure that installutil.exe is in your PATH.

5. Service Uninstall.bat : Batch file to uninstall the service with the SCM.  
Make sure that installutil.exe is in your PATH.

----------------------------------------------------------------------------

After installation with the SCM, you will find the entry "$1servicename$"
in the list of services (Control Panel->Administrative Tools->Services).
It may be started and stopped through this dialog.