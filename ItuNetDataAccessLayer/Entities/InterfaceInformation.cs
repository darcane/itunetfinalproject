using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetDataAccessLayer
{
    public class InterfaceInformation
    {
        [Key]
        public int InterfaceInformationId { get; set; }
        public string InterfaceName { get; set; }
        public int PortNumber { get; set; }
        public bool HasCdpInfo { get; set; }
        public bool IsOpen { get; set; }
        public DateTime LastCheckTime { get; set; }

        public int DeviceId { get; set; }
        public virtual Device Device { get; set; }
    }
}
