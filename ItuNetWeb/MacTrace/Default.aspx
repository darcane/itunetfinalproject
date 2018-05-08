<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="MacTrace_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    ITUNET - Find MAC
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashcube"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-sitemap"></i>&nbsp;Find a MAC</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <h2>Find a MAC Address</h2>
    <div class="row">
        <div class="col col-xl-6">
            <div class="form-group">
                <span class="">MAC Address</span>
            </div>
            <div class="form-group input-group">
                <asp:TextBox ID="tbMacAddress" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                <div class="input-group-append">
                    <asp:LinkButton ID="lbFindMac" CssClass="btn btn-success" runat="server" OnClick="lbFindMac_Click" ClientIDMode="Static">
                        <i class="fa fa-search"></i> Find MAC
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
</asp:Content>

