using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;

namespace $rootnamespace$
{
	/**
     * The base class for the $itemname$ Windows Service
	 * @author   $username$
	 */
	public class $safeitemname$Base : System.ServiceProcess.ServiceBase {
		// OnStartup delegate
		private delegate void OnStartupDelegate(string[] args);

        /**
		 * Default constructor
		 */
		public $safeitemname$Base() {
			// set the service name
			this.ServiceName = "$itemname$";
		}

        /**
         * Make sure we stop the service when the service is being disposed
		 * 
         * @param disposing  A flag indicating whether the function is 
         *                   being called manually (true) or by the
         *                   garbage collector via the destructor 
         *                   (false).
         */
		protected override void Dispose(bool disposing) {
            // If disposing equals false, the method has been called by the
            // runtime from inside the finalizer and you should not reference 
            // other objects. Only unmanaged resources can be disposed.
			if (disposing == true) {
				// free your managed resources here
			}
			// free your unmanaged resources here
			// shut down our resources cleanly
			DebugStop();
			// call the base implementation
			base.Dispose(disposing);
		}

        /**
         * The default overridden version of OnStart is required to run 
         * this object as a service from the SCM.  Since we can't debug 
         * if it is a service and OnStart i protected, the DebugStart
         * method is defined so that the "service process" can be
         * started from the app's Main proc.
         */
		public void DebugStart() {
			string msg = "";

			// log that we are entering DebugStart
			msg = "$safeitemname$Base::DebugStart invoked";
			Trace.WriteLine(msg);
			// call OnStartup synchronously
			OnStartup(null);
		}

        /**
         * This overridden version of OnStart is called when the service
         * is started by the SCM.  It calls the OnStartup delegate
         * asynchronously so that the SCM is not blocked by a potentially 
         * length initialization process.
		 * 
         * @param args	Any arguments passed by the SCM
		 */
		protected override void OnStart(string[] args) {
			OnStartupDelegate onStartupDelegate = null;
			string msg = "";

			// log that we are entering OnStart
			msg = "$safeitemname$Base::OnStart invoked";
			Trace.WriteLine(msg);
			// create the OnStartup delegate
			onStartupDelegate = new OnStartupDelegate(OnStartup);
			// call OnStartup asynchronously
			onStartupDelegate.BeginInvoke(args, null, null);
		}

        /**
		 * The true start up method that is called by either OnStart or 
         * DebugStart.
		 * 
		 * @param args	Any arguments passed by the SCM
		 */
		protected virtual void OnStartup(string[] args) {
			string msg = "";

			try
			{
				// log that we are entering OnStartup
				msg = "$safeitemname$Base::OnStartup invoked";
				Trace.WriteLine(msg);
				// TODO: Add your service startup code here
			}
			catch (Exception e)
			{
				// log the exception
				msg = e.GetType().ToString() + " in $safeitemname$Base::OnStartup : " + e.Message;
				Trace.WriteLine(msg);
			}
		}

        /**
         * The default overridden version of OnStop is required to stop
         * this object as a service from the SCM.  Since OnStop is
         * protected, the DebugStop method is defined so that the 
         * "service process" can be stopped from the app's Main proc.
		 */
		public void DebugStop() {
			string msg = "";

			// log that we are entering DebugStop
			msg = "$safeitemname$Base::DebugStop invoked";
			Trace.WriteLine(msg);
			// call the protected implementation of OnStop
			OnStop();
		}

        /**
         * The true stopping method that is called by either OnStop
         * or DebugStop.
		 */
		protected override void OnStop() {
			string msg = "";

			try
			{
				// log that we are entering OnStop
				msg = "$safeitemname$Base::OnStop invoked";
				Trace.WriteLine(msg);
				// TODO: Add your service shut down code here
			}
			catch (Exception e)
			{
				// log the exception
				msg = e.GetType().ToString() + " in $safeitemname$Base::OnStop : " + e.Message;
				Trace.WriteLine(msg);
			}
		}
	}
}
