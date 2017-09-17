using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;
using System.ServiceProcess;
using System.Diagnostics;

namespace $rootnamespace$
{
    /**
     * The base class for installing the $itemname$ Windows service
	 */
	[RunInstaller(true)]
	public class $safeitemname$InstallerBase : System.Configuration.Install.Installer
	{
		// required for the service installation process
		private ServiceProcessInstaller m_serviceProcessInstaller = null;
		private ServiceInstaller m_serviceInstaller = null;

        /**
		 * Default constructor
		 */
		public $safeitemname$InstallerBase()
		{
			// initialize the installer
			InitializeInstaller();
		}

        /**
         * Initializes the settings for the service prior to installation
		 */
		private void InitializeInstaller()
		{
			// create the installer components
			m_serviceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
			m_serviceInstaller = new System.ServiceProcess.ServiceInstaller();

			// initialize the process installer
			m_serviceProcessInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
			m_serviceProcessInstaller.Password = null;
			m_serviceProcessInstaller.Username = null;
			
			// initialize the service installer
			m_serviceInstaller.ServiceName = "$itemname$";
			m_serviceInstaller.DisplayName = "$1servicename$";
			m_serviceInstaller.Description = "$2servicedescription$";
			// TODO: uncomment this line if the service depends on another service
			//m_serviceInstaller.ServicesDependedOn = new string[] {"Dependent service name"};
			
			// add them to the installer list
			this.Installers.Add(m_serviceProcessInstaller);
			this.Installers.Add(m_serviceInstaller);
		}

	}
}
