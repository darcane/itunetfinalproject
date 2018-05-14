<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SnmpTest.aspx.cs" Inherits="SnmpTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <div class="form-group">
        <asp:TextBox ID="tbOid" runat="server" CssClass="form-control"></asp:TextBox>
        <asp:LinkButton ID="lbGet" runat="server" CssClass="btn btn-danger" OnClick="lbGet_Click">Test Oid</asp:LinkButton>
    </div>
    <asp:GridView ID="gv" runat="server">

    </asp:GridView>
    <div class="card text-center w-50">
        <div class="card-header">
            10.0.100.100 - darcane
        </div>
        <div class="card-body">
            <table class="table table-sm table-bordered bg-secondary text-white p-3">
                <tbody>
                    <tr>
                        <td>Fa0/1<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/2<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/3<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/4<br/><img src="Content/ico_green.png" /></td>
                        <td>Fa0/5<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/6<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/7<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/8<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/9<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/10<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/11<br/><img src="Content/ico_red.png" /></td>
                        <td colspan="2"><img src="https://dwglogo.com/wp-content/uploads/2016/05/Cisco_logo.svg_.png" height="63"/></td>
                        <%--<td rowspan="2" class="align-items-center"><img src="https://dwglogo.com/wp-content/uploads/2016/05/Cisco_logo.svg_.png" height="126"/></td>--%>
                    </tr>
                    <tr>
                        <td>Fa0/12<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/13<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/14<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/15<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/16<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/17<br/><img src="Content/ico_yellow.png" /></td>
                        <td>Fa0/18<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/19<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/20<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/21<br/><img src="Content/ico_red.png" /></td>
                        <td>Fa0/22<br/><img src="Content/ico_red.png" /></td>
                        <td>Gi0/1<br/><img src="Content/ico_red.png" /></td>
                        <td>Gi0/2<br/><img src="Content/ico_red.png" /></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <span id="tableJson" data-content='{"fa": 12, "gi" : 2, "con" : 4}'>
        </span>
    </div>
    

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
    <script type="text/javascript">
        $(document).ready(() => {
            var obj = $("#tableJson").data('content');
            alert(obj.fa);
            //alert($("#tableJson").data('content').fa);
        });
    </script>
</asp:Content>

