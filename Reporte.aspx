<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reporte.aspx.cs" Inherits="PerfilesSA_WebApp.Reporte" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Reporte de Empleados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        :root {
            --sidebar-bg: #1e293b;
/*          --sidebar-active: #f97316;*/
            --primary-color: #1e40af;
            --success-color: #10b981;
            --text-muted: #64748b;
        }

        body {
            background-color: #f8fafc;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 228px;
            background-color: var(--sidebar-bg);
            color: white;
            padding: 0;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background-color: var(--primary-color);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .logo-text {
            font-weight: 700;
            font-size: 16px;
            letter-spacing: 0.5px;
        }

        .logo-subtitle {
            font-size: 11px;
            color: #94a3b8;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-label {
            padding: 8px 20px;
            font-size: 11px;
            font-weight: 600;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.2s;
            gap: 12px;
            font-size: 14px;
        }

        .menu-item:hover {
            background-color: rgba(255, 255, 255, 0.05);
            color: white;
        }

        .menu-item.active {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        .menu-icon {
            font-size: 18px;
            width: 20px;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 12px;
            color: #94a3b8;
        }

        /* Top Breadcrumb */
        .top-breadcrumb {
            background: white;
            padding: 20px 32px;
            margin-left: 228px;
            color: #0f172a;
            display: flex;
            align-items: center;
            font-size: 22px;
            font-weight: 600;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid #e2e8f0;
        }

        /* Main Content */
        .main-content {
            margin-left: 228px;
            padding: 32px;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .page-header h1 {
            font-size: 28px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 0;
        }

        /* Filter Section */
        .filter-card {
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            margin-bottom: 24px;
        }

        .filter-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 8px;
        }

        .filter-header h3 {
            font-size: 16px;
            font-weight: 600;
            color: #0f172a;
            margin: 0;
        }

        .filter-subtitle {
            color: var(--text-muted);
            font-size: 13px;
            margin-bottom: 20px;
        }

        .filter-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }

        .filter-group label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 6px;
        }

        .filter-group input[type="date"],
        .filter-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
        }

        .filter-group input:focus,
        .filter-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
        }

        .filter-actions {
            display: flex;
            gap: 12px;
        }

        /* Results Summary */
        .results-summary {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px;
            background: #f8fafc;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 14px;
            color: #475569;
        }

        .results-summary i {
            color: #64748b;
        }

        .results-count {
            font-weight: 600;
            color: #0f172a;
        }

        .status-count {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-count.active {
            color: #059669;
        }

        .status-count.inactive {
            color: #64748b;
        }

        .status-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
        }

        .status-dot.active {
            background-color: #10b981;
        }

        .status-dot.inactive {
            background-color: #94a3b8;
        }

        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background-color: #f8fafc;
        }

        .table thead th {
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            padding: 16px;
            border-bottom: 2px solid #e2e8f0;
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #0f172a;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-badge.active {
            background-color: #d1fae5;
            color: #059669;
        }

        .status-badge.active::before {
            content: '';
            width: 6px;
            height: 6px;
            background-color: #10b981;
            border-radius: 50%;
        }

        .status-badge.inactive {
            background-color: #f1f5f9;
            color: #64748b;
        }

        /* Buttons */
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 10px 28px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1e3a8a;
        }

        .btn-secondary {
            background-color: white;
            color: #64748b;
            border: 1px solid #d1d5db;
            padding: 10px 28px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
        }

        .btn-secondary:hover {
            background-color: #f8fafc;
        }

        .btn-export {
            background-color: var(--primary-color);
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 16px;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-export:hover {
            background-color: #1e3a8a;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- TOP BREADCRUMB -->
        <div class="top-breadcrumb">
            Reportes
        </div>

        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="bi bi-bar-chart-fill"></i>
                    </div>
                    <div>
                        <div class="logo-text">PERFILES</div>
                        <div class="logo-subtitle">S.A.</div>
                    </div>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="menu-label">MÓDULOS</div>
                <a href="Empleados.aspx" class="menu-item">
                    <i class="bi bi-people-fill menu-icon"></i>
                    <span>Empleados</span>
                </a>
                <a href="Departamentos.aspx" class="menu-item">
                    <i class="bi bi-building menu-icon"></i>
                    <span>Departamentos</span>
                </a>
                <a href="Reporte.aspx" class="menu-item active">
                    <i class="bi bi-file-earmark-bar-graph menu-icon"></i>
                    <span>Reportes</span>
                </a>
            </div>

            <div class="sidebar-footer">
                <div><strong>Sistema de Control</strong></div>
                <div>Gestión de Empleados</div>
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-start page-header">
                <div>
                    <h1>Reporte de Empleados</h1>
                    <p>Consulta y exporta información detallada de los empleados</p>
                </div>
                <asp:LinkButton ID="btnExportar" runat="server" 
                    CssClass="btn-export" OnClick="btnExportar_Click">
                    <i class="bi bi-download"></i>
                    Exportar CSV
                </asp:LinkButton>
            </div>

            <!-- Filter Section -->
            <div class="filter-card">
                <div class="filter-header">
                    <i class="bi bi-funnel"></i>
                    <h3>Filtros</h3>
                </div>
                <p class="filter-subtitle">Filtra los empleados por diferentes criterios</p>

                <div class="filter-row">
                    <div class="filter-group">
                        <label>Fecha Ingreso Desde</label>
                        <asp:TextBox ID="txtFechaDesde" runat="server" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="filter-group">
                        <label>Fecha Ingreso Hasta</label>
                        <asp:TextBox ID="txtFechaHasta" runat="server" TextMode="Date"></asp:TextBox>
                    </div>

                    <div class="filter-group">
                        <label>Departamento</label>
                        <asp:DropDownList ID="ddlDepartamento" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="filter-actions">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
                        CssClass="btn-primary" OnClick="btnBuscar_Click" />
                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" 
                        CssClass="btn-secondary" OnClick="btnLimpiar_Click" />
                </div>
            </div>

            <!-- Results Summary -->
            <div class="results-summary">
                <i class="bi bi-people"></i>
                <span>
                    <asp:Label ID="lblTotalEmpleados" runat="server" CssClass="results-count" Text="0"></asp:Label>
                    empleado(s) encontrado(s)
                </span>
                <span class="mx-2">|</span>
                <span class="status-count active">
                    <span class="status-dot active"></span>
                    <strong><asp:Label ID="lblActivos" runat="server" Text="0"></asp:Label></strong> activo(s)
                </span>
                <span class="status-count inactive">
                    <span class="status-dot inactive"></span>
                    <strong><asp:Label ID="lblInactivos" runat="server" Text="0"></asp:Label></strong> inactivo(s)
                </span>
            </div>

            <!-- TABLA -->
            <div class="table-container">
                <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="False" CssClass="table">
                    <Columns>
                        <asp:BoundField DataField="Nombres" HeaderText="Nombre" />
                        <asp:TemplateField HeaderText="DPI">
                            <ItemTemplate>
                                <%# FormatDPI(Eval("DPI").ToString()) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Edad" HeaderText="Edad" />
                        <asp:TemplateField HeaderText="Sexo">
                            <ItemTemplate>
                                <%# Eval("Sexo").ToString() == "M" ? "Masculino" : "Femenino" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NombreDepartamento" HeaderText="Departamento" />
                        <asp:BoundField DataField="FechaIngreso" HeaderText="Fecha Ingreso" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:TemplateField HeaderText="Antigüedad">
                            <ItemTemplate>
                                <%# CalcularAntiguedad(Eval("FechaIngreso")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class='status-badge <%# Convert.ToBoolean(Eval("Activo")) ? "active" : "inactive" %>'>
                                    <%# Convert.ToBoolean(Eval("Activo")) ? "Activo" : "Inactivo" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
