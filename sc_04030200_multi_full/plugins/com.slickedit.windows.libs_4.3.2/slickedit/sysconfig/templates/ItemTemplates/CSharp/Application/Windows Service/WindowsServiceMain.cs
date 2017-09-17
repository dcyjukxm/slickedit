using System;
using System.Diagnostics;

namespace $rootnamespace$
{
    /**
     * This class simply supplies the main entry point for a Windows
     * service.  It sets up tracing then creates the main controller
     * object which coordinates the service processes.
	 */
	public class $safeitemname$Main {
		// Set this to false to run the service from
		// the debugger.  Set this to true when you
		// want the executable to run as a service.
		private const bool RUN_AS_SERVICE = true;

		/**
		 * The main entry point for the process
		 */
		static void Main()
		{
			string msg = "";

			try
			{
				// kick off the services
				if (RUN_AS_SERVICE == true) {
					System.ServiceProcess.ServiceBase[] ServicesToRun;
					ServicesToRun = new System.ServiceProcess.ServiceBase[] { new $safeitemname$Base() };
					System.ServiceProcess.ServiceBase.Run(ServicesToRun);
				} else {
					// this code enables this project to run as a full service in debug mode.
					$safeitemname$Base _$safeitemname$Base = new $safeitemname$Base();
					_$safeitemname$Base.DebugStart();
					// loop infinitely
					while (true) {
						System.Threading.Thread.Sleep(5000);
					}
				}
			}
			catch (Exception e)
			{
				// log the exception
				msg = e.GetType().ToString() + " in $safeitemname$Main::Main : " + e.Message;
				Trace.WriteLine(msg);
				return;
			}
		}

	}
}
