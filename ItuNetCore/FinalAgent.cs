using ITUBIDB.Net.Management;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AgentManager = ITUBIDB.Net.Management.SnmpClient;

namespace ItuNetCore
{
    public class FinalAgent
    {
        private AgentManager fieldAgent;
        public AgentManager Agent
        {
            get
            {
                if(fieldAgent == default(AgentManager))
                {
                    fieldAgent = new AgentManager(IPAddressToConnect,"bitirme",5000);
                }
                return fieldAgent;
            }
        }

        public string IPAddressToConnect { get; private set; }

        public FinalAgent(string ipAddress)
        {
            this.IPAddressToConnect = ipAddress;
        }

        public SwicthBasicInformation GetBasicInformation()
        {
            Agent.Connect();
            string hostName = Agent.Get("1.3.6.1.2.1.1.5.0").ToString();
            Agent.Walk("1.3.6.1.2.1.17.4.3.1.1");
            SnmpItemList list = Agent.GetWalkResultSet();
            return new SwicthBasicInformation()
            {
                HostName = hostName.Replace("\"","").Replace(".itu.edu.tr",""),
                IPAddress = IPAddressToConnect,
                DeviceType = GetDeviceType()
            };
        }
        public string GetDeviceType()
        {
            Agent.Walk("1.3.6.1.2.1.47.1.1.1.1.13");
            SnmpItemList sil = Agent.GetWalkResultSet();
            SnmpItem si = sil.FirstOrDefault(i => i.Value.Value.ToString() != "");
            return si.Value.Value.ToString();
        }
    }
}
