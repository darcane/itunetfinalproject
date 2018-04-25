using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetDataAccessLayer
{
    public class Device
    {
        [Key]
        public int DeviceId { get; set; }
        public string HostName { get; set; }
        public string IpAddress { get; set; }
        public string DeviceKey { get; set; }

        public int DeviceTypeId { get; set; }
        public virtual DeviceType DeviceTypes { get; set; }

        public int BuildingId { get; set; }
        public virtual Building Building {get;set;}

        public virtual List<InterfaceInformation> InterfaceInformations { get; set; }
    }
}
