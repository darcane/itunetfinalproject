using ITUBIDB.Net.Management;
using ITUBIDB.Net.Management.MIBS.Enterprise.Cisco.Mgmt;
using ITUBIDB.Net.Management.MIBS.SnmpMIB2;
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
                    fieldAgent = new AgentManager(IPAddressToConnect,"bitirme@302",5000);
                    fieldAgent.Connect();
                }
                return fieldAgent;
            }
        }

        public List<Interface> VlanList {
            get
            {
                return (new Interfaces(Agent)).ifTable.Values.Where(i => i.ifDescr.Contains("Vlan")).ToList();
            }
        }

        public void ReconnectWithVlan(string vlan = "")
        {
            fieldAgent.Disconnect();
            this.fieldAgent = new AgentManager(IPAddressToConnect,string.Concat("bitirme",vlan),5000);
            fieldAgent.Connect();
        }

        public string IPAddressToConnect { get; private set; }

        public FinalAgent(string ipAddress)
        {
            this.IPAddressToConnect = ipAddress;
        }

        public SwitchBasicInformation GetBasicInformation()
        {
            string hostName = Agent.Get("1.3.6.1.2.1.1.5.0").ToString();
            Agent.Walk("1.3.6.1.2.1.17.4.3.1.1");
            SnmpItemList list = Agent.GetWalkResultSet();
            return new SwitchBasicInformation()
            {
                HostName = hostName.Replace("\"","").Replace(".itu.edu.tr",""),
                IPAddress = IPAddressToConnect,
                DeviceType = GetDeviceType()
            };
        }

        public List<BasicInterfaceInformation> GetInterfaceInformation()
        {
            List<BasicInterfaceInformation> toRet = new List<BasicInterfaceInformation>();
            Interfaces ifs = new Interfaces(Agent);
            Cdp cdp = new Cdp(Agent);
            CdpResultSet cdpResult = cdp.GetCdpList();
            List<CdpItem> cdpList = cdpResult.Values.SelectMany(i => i.Values.ToList()).ToList();

            List<Interface> listWithVlan = ifs.ifTable.Values.ToList();
            listWithVlan.RemoveAll(i => i.ifDescr.Contains("Vlan") || i.ifDescr.Contains("Null0"));
            listWithVlan.ForEach(i => toRet.Add(BasicInterfaceInformation.ConvertInterfaceToBasicInterfaceInformation(i)));
            foreach (var item in toRet)
            {
                if (cdpList.Exists(i=>i.cdpIfIndex == item.IfIndex))
                    item.IfCdpExist = true;
            }
            return toRet;
        }

        protected string GetDeviceType()
        {
            Agent.Walk("1.3.6.1.2.1.47.1.1.1.1.13");
            SnmpItemList sil = Agent.GetWalkResultSet();
            SnmpItem si = sil.FirstOrDefault(i => i.Value.Value.ToString() != "");
            return si.Value.Value.ToString();
        }
        
        public SnmpItemList GetWalkResultSet(string oid)
        {
            Agent.Walk(oid);
            return Agent.GetWalkResultSet();
        }
    }
}
