using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetDataAccessLayer
{
    public class DeviceType
    {
        [Key]
        public int DeviceTypeId { get; set; }
        public string DeviceTypeName { get; set; }
        public string DeviceTypeKey { get; set; }

        public virtual List<Device> Devices { get; set; }
    }
}