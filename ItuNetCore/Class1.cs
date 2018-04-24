using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItuNetCore
{
    public class Class1
    {
        public string HelloWorld()
        {
            ITUBIDB.Net.Management.SnmpClient client = new ITUBIDB.Net.Management.SnmpClient("test.address", "communityPass123");
            client.Walk("1.3.6.1.2.1.17.4.3.1.1");
            return "test successfull";
        }
    }
}
