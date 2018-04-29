using ItuNetCore;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }
    
    protected void lbAddDevice_Click(object sender, EventArgs e)
    {
        FinalAgent fa = new FinalAgent(tbIPAddress.Text.Trim());
        SwicthBasicInformation sbi = fa.GetBasicInformation();
        pnlAfterAdd.Visible = true;
        string deviceKey = CreateDeviceKey();
        QRCodeGenerate(deviceKey);
        tbHostName.Text = sbi.HostName;
        tbDeviceKey.Text = deviceKey;
        tbDeviceType.Text = sbi.DeviceType;
        ddlBuilding.DataSource = DataProvider.Buildings.ToList();
        ddlBuilding.DataBind();
        ddlBuilding.Items.Insert(0, new ListItem() { Value = "-1", Text = "Please Select"});
        ddlBuilding.SelectedIndex = 0;
    }
    protected void lbSaveDevice_Click(object sender, EventArgs e)
    {
        
    }
    private void QRCodeGenerate(string deviceKey)
    {
        QRCodeGenerator qrGenerator = new QRCodeGenerator();
        QRCodeData qrCodeData = qrGenerator.CreateQrCode("http://local.itunet/Device/DeviceDetail.aspx?" + deviceKey, QRCodeGenerator.ECCLevel.Q);
        QRCode qrCode = new QRCode(qrCodeData);
        Bitmap qrCodeImage = qrCode.GetGraphic(20,Color.Black,Color.White,false);
        using (MemoryStream ms = new MemoryStream())
        {
            qrCodeImage.Save(ms, ImageFormat.Gif);
            var base64Data = Convert.ToBase64String(ms.ToArray());
            imgQR.Src = "data:image/gif;base64," + base64Data;
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