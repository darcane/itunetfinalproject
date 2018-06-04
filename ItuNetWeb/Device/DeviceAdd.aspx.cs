using ItuNetCore;
using ItuNetDataAccessLayer;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Device_DeviceAdd : BasePage
{
    public SwitchBasicInformation SwitchInfo {
        get { if (ViewState["SwitchInfo"] == null) return new SwitchBasicInformation(); else return ViewState["SwitchInfo"] as SwitchBasicInformation; }
        set { ViewState["SwitchInfo"] = value; }
    }
    public List<BasicInterfaceInformation> InterfaceInfo
    {
        get { if (ViewState["InterfaceInfo"] == null) return new List<BasicInterfaceInformation>(); else return ViewState["InterfaceInfo"] as List<BasicInterfaceInformation>; }
        set { ViewState["InterfaceInfo"] = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    
    protected void lbAddDevice_Click(object sender, EventArgs e)
    {
        string ip = tbIPAddress.Text.Trim();
        Device d = DataProvider.Devices.FirstOrDefault(i => i.IpAddress == ip);
        FinalAgent fa = new FinalAgent(ip);
        SwitchInfo = fa.GetBasicInformation();
        InterfaceInfo = fa.GetInterfaceInformation();
        pnlAfterAdd.Visible = true;
        ddlBuilding.DataSource = DataProvider.Buildings.ToList();
        ddlBuilding.DataBind();
        if (d == default(Device))
        {
            SwitchInfo.DeviceKey = CreateDeviceKey();
            ddlBuilding.Items.Insert(0, new ListItem() { Value = "-1", Text = "Please Select"});
            ddlBuilding.SelectedIndex = 0;
            pnlDeviceNotExist.Visible = true;
            pnlDeviceExist.Visible = false;
        }
        else
        {
            SwitchBasicInformation sb = new SwitchBasicInformation() { DeviceKey = d.DeviceKey, DeviceType = d.DeviceType.DeviceTypeName, HostName = d.HostName, IPAddress = ip };
            //if (SwitchInfo.Equals(sb)) { string status = "değisiklik var"; }
            SwitchInfo.DeviceKey = d.DeviceKey;
            ddlBuilding.SelectedValue = d.BuildingId.ToString();
            List<BasicInterfaceInformation> listBif = new List<BasicInterfaceInformation>();
            d.InterfaceInformations.ToList().ForEach(i => listBif.Add(new BasicInterfaceInformation()
            {
                IfCdpExist = i.HasCdpInfo,
                IfConnected = i.IsConnected,
                IfDescription = i.InterfaceName,
                IfIndex = i.InterfaceIndex,
                IfNumber = i.PortNumber,
                IfStat = i.IsOpen
            }));
            foreach (BasicInterfaceInformation item in InterfaceInfo)
            {
                BasicInterfaceInformation bif = listBif.FirstOrDefault(i => i.IfIndex == item.IfIndex);
                if(bif == default(BasicInterfaceInformation) ||
                    item.IfCdpExist != bif.IfCdpExist ||
                    item.IfConnected != bif.IfConnected || 
                    item.IfDescription != bif.IfDescription || 
                    item.IfIndex != bif.IfIndex || 
                    item.IfNumber != bif.IfNumber ||
                    item.IfStat != bif.IfStat)
                    item.IsUpdated = true;
            }
            pnlDeviceNotExist.Visible = false;
            pnlDeviceExist.Visible = true;
        }
        tbHostName.Text = SwitchInfo.HostName;
        tbDeviceKey.Text = SwitchInfo.DeviceKey;
        tbDeviceType.Text = SwitchInfo.DeviceType;
        QRCodeGenerate(SwitchInfo.DeviceKey);
        rpInterfaces.DataSource = InterfaceInfo;
        rpInterfaces.DataBind();
    }
    protected void lbSaveDevice_Click(object sender, EventArgs e)
    {
        Device toAdd = new Device();
        DeviceType dt = DataProvider.DeviceTypes.FirstOrDefault(i => i.DeviceTypeName.Trim() == SwitchInfo.DeviceType.Trim());
        if (dt == null)
        {
            dt = DataProvider.DeviceTypes.Add(new DeviceType()
            {
                DeviceTypeName = SwitchInfo.DeviceType.Trim(),
                DeviceTypeKey = SwitchInfo.DeviceType.Trim().ToLower().Replace(" ", "_")
            });
        }
        toAdd.DeviceType = dt;
        toAdd.BuildingId = Convert.ToInt32(ddlBuilding.SelectedValue);
        toAdd.DeviceKey = SwitchInfo.DeviceKey;
        toAdd.HostName = SwitchInfo.HostName;
        toAdd.IpAddress = SwitchInfo.IPAddress;
        toAdd.InterfaceInformations = new List<InterfaceInformation>();
        InterfaceInfo.ForEach(i => toAdd.InterfaceInformations.Add(new InterfaceInformation()
        {
            PortNumber = i.IfNumber,
            HasCdpInfo = i.IfCdpExist,
            InterfaceIndex = i.IfIndex,
            InterfaceName = i.IfDescription,
            IsConnected = i.IfConnected,
            IsOpen = i.IfStat,
            LastCheckTime = DateTime.Now
        }));
        DataProvider.Devices.Add(toAdd);
        DataProvider.SaveChanges();
        Response.Redirect("Default.aspx");
    }
    protected void lbUpdateDevice_Click(object sender, EventArgs e)
    {
        Device toUpdate = DataProvider.Devices.FirstOrDefault(i => i.IpAddress == tbIPAddress.Text.Trim());
        DeviceType dt = DataProvider.DeviceTypes.FirstOrDefault(i => i.DeviceTypeName.Trim() == SwitchInfo.DeviceType.Trim());
        if (dt == null)
        {
            dt = DataProvider.DeviceTypes.Add(new DeviceType()
            {
                DeviceTypeName = SwitchInfo.DeviceType.Trim(),
                DeviceTypeKey = SwitchInfo.DeviceType.Trim().ToLower().Replace(" ", "_")
            });
        }
        toUpdate.DeviceType = dt;
        toUpdate.BuildingId = Convert.ToInt32(ddlBuilding.SelectedValue);
        toUpdate.DeviceKey = SwitchInfo.DeviceKey;
        toUpdate.HostName = SwitchInfo.HostName;
        toUpdate.IpAddress = SwitchInfo.IPAddress;
        //toUpdate.InterfaceInformations = new List<InterfaceInformation>();
        foreach (BasicInterfaceInformation item in InterfaceInfo)
        {
            InterfaceInformation interf = toUpdate.InterfaceInformations.FirstOrDefault(i => i.InterfaceIndex == item.IfIndex);
            interf.PortNumber = item.IfNumber;
            interf.HasCdpInfo = item.IfCdpExist;
            interf.InterfaceIndex = item.IfIndex;
            interf.InterfaceName = item.IfDescription;
            interf.IsConnected = item.IfConnected;
            interf.IsOpen = item.IfStat;
            interf.LastCheckTime = DateTime.Now;
        }
        DataProvider.SaveChanges();
        Response.Redirect("Default.aspx");
    }
    private void QRCodeGenerate(string deviceKey)
    {
        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        string href = "http://local.itunet/Device/Details.aspx?key=" + deviceKey;
        QRCodeData qrCodeData = qrGenerator.CreateQrCode(href, QRCodeGenerator.ECCLevel.L);
        QRCode qrCode = new QRCode(qrCodeData);
        Bitmap qrCodeImage = qrCode.GetGraphic(20,Color.Black,Color.White,false);
        using (MemoryStream ms = new MemoryStream())
        {
            qrCodeImage.Save(ms, ImageFormat.Gif);
            var base64Data = Convert.ToBase64String(ms.ToArray());
            imgQR.Src = "data:image/gif;base64," + base64Data;
            qrHref.HRef = href;
            qrHref.InnerHtml = href;
        }
    }
    private string CreateDeviceKey()
    {
        char[] charArray = { '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'w', 'x', 'y', 'z' };
        Random rnd = new Random();
        string kod = "";
        do
        {
            for (int i = 0; kod.Length < 8; i++)
            {
                kod += charArray[rnd.Next(charArray.Length)];
            }
        } while (DataProvider.Devices.FirstOrDefault(i => i.DeviceKey == kod) != null);
        return kod;
    }

}