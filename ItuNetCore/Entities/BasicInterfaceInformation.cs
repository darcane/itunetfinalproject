using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetCore
{
    [Serializable]
    public class BasicInterfaceInformation
    {
        public int IfIndex { get; set; }
        public string IfDescription { get; set; }
        public string IfNumber { get; set; }
        public bool IfCdpExist { get; set; }
        public bool IfStat { get; set; }
        public bool IfConnected { get; set; }
        public bool IsUpdated { get; set; }


        public static BasicInterfaceInformation ConvertInterfaceToBasicInterfaceInformation(ITUBIDB.Net.Management.MIBS.SnmpMIB2.Interface ifInfo)
        {
            return new BasicInterfaceInformation()
            {
                IfDescription = ifInfo.ifDescr,
                IfIndex = Convert.ToInt32(ifInfo.ifIndex),
                IfNumber = ifInfo.ifDescr.Substring(ifInfo.ifDescr.IndexOf('0'), ifInfo.ifDescr.Length - ifInfo.ifDescr.IndexOf('0')), //düzeltilecek
                IfStat = ifInfo.IsAdminUp(),
                IfConnected = ifInfo.IsOperUp(),
                IfCdpExist = false,
                IsUpdated = false
            };
        }
    }
}
