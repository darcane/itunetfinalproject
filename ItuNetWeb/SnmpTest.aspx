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

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
</asp:Content>

