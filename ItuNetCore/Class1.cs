using ITUBIDB.Net.Management;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AgentManager = ITUBIDB.Net.Management.SnmpClient;

namespace ItuNetCore
{
    public class Class1
    {
        public string HelloWorld()
        {
            AgentManager agent = new AgentManager("test", "asdasd");
            agent.Walk("1.3.6.1.2.1.17.4.3.1.1");
            SnmpItemList list = agent.GetWalkResultSet();
            return "test successfull";
        }
    }
}
