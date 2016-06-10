<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Error</title>
        <script>
            $(document).ready(function () {
                $('.volver').click(function () {
                    event.preventDefault();
                    history.back();
                });
            });
        </script>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper indigo darken-4">
                <a href="goDashboard.action" class="brand-logo center"><div class="valign-wrapper"><img src="img/upinderlogo.png" style="max-height: 40px;">Upinder</div></a>
            </div>
        </nav>
        <div class="container">
            <div class="row">
                <div class="col s12 center-align">
                    <h3>Oops! Ocurrió un error inesperado</h3>
                </div>
            </div>
            <div class="row">
                <div class="col s12 center-align">
                    <a class="waves-effect waves-light btn volver"><i class="material-icons left">replay</i>Volver</a>
                </div>
            </div>
            <div class="row">
                <div class="col s12 center-align">
                    <img class="responsive-img" src="img/trollface.jpg">
                </div>
            </div>
        </div>
    </body>
</html>
