using System;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace ItuNetDataAccessLayer
{
    public class ITUNETModel : DbContext
    {
        public DbSet<Device> Devices { get; set; }
        public DbSet<DeviceType> DeviceTypes { get; set; }
        public DbSet<InterfaceInformation> InterfaceInformations { get; set; }
        public DbSet<Building> Buildings { get; set; }

        public ITUNETModel() : base("name=ITUNETModel")
        { 
        }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}
