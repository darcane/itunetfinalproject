using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetDataAccessLayer
{
    public class Building
    {
        [Key]
        public int BuildingId { get; set; }
        public string BuildingName { get; set; }
        public string BuildingKey { get; set; }

        public virtual List<Device> Devices { get; set; }
    }
}