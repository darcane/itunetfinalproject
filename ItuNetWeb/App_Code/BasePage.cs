using ItuNetDataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public partial class BasePage : System.Web.UI.Page
{
    public int TestProperty { get; set; }

    private ITUNETModel fieldDataProvider;
    public ITUNETModel DataProvider {
        get
        {
            if (fieldDataProvider == default(ITUNETModel))
                fieldDataProvider = new ITUNETModel();
            return fieldDataProvider;
        }
    }
}