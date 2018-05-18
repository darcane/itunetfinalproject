<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content0" ContentPlaceHolderID="cphTitle" runat="server">
    ITUNET - Dashboard
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphBreadcrumb" runat="server">
    <%--<li class="breadcrumb-item">
        <a href="/Default.aspx">Dashboard</a>
    </li>--%>
    <%--<li class="breadcrumb-item active"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</li>--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphContent" runat="Server">
    <div class="jumbotron text-center">
        <h1 class="display-1 logo"><i class="fa fa-ravelry"></i>&nbsp;
            <span style="color:#3689F0">I</span>
            <span style="color:#ED4137">T</span>
            <span style="color:#FEBB35">U</span>
            <span style="color:#3689F0">N</span>
            <span style="color:#2FA85A">E</span>
            <span style="color:#ED4137">T</span>
            <br />
            <span class="text-muted">Dashboard</span>
        </h1>
    </div>
    <div class="row">
        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="card text-white bg-primary o-hidden h-100">
                <div class="card-body">
                    <div class="card-body-icon">
                        <i class="fa fa-fw fa-server fa-rotate-180"></i>
                    </div>
                    <div class="mr-5">Devices</div>
                </div>
                <a class="card-footer text-white clearfix small z-1" href="/Device/Default.aspx">
                    <span class="float-left">Go to page</span>
                    <span class="float-right">
                        <i class="fa fa-angle-right"></i>
                    </span>
                </a>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-warning o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-building"></i>
              </div>
              <div class="mr-5">Buildings</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="/Building/Default.aspx">
              <span class="float-left">Go to page</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-danger o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-cogs"></i>
              </div>
              <div class="mr-5">Data Management</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="#">
              <span class="float-left">Go to page</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
          <div class="card text-white bg-success o-hidden h-100">
            <div class="card-body">
              <div class="card-body-icon">
                <i class="fa fa-fw fa-sitemap"></i>
              </div>
              <div class="mr-5">Find a MAC</div>
            </div>
            <a class="card-footer text-white clearfix small z-1" href="/MacTrace/Default.aspx">
              <span class="float-left">Go to page</span>
              <span class="float-right">
                <i class="fa fa-angle-right"></i>
              </span>
            </a>
          </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphFooterJs" runat="server"></asp:Content>
