using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetCore
{
    [Serializable]
    public class SwitchBasicInformation
    {
        public string HostName { get; set; }
        public string IPAddress { get; set; }
        public string DeviceType { get; set; }
        public string DeviceKey { get; set; }
    }
}
