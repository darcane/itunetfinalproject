using System;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace ItuNetDataAccessLayer
{
    public partial class ITUNETModel : DbContext
    {
        public DbSet<Device> Devices { get; set; }
        public DbSet<DeviceType> DeviceTypes { get; set; }

        public ITUNETModel() : base("name=ITUNETModel")
        { 
        }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}
