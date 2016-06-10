<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Denuncia de usuario</title>
        <script>
            $(document).ready(function () {
                $(".button-collapse").sideNav();
                $('select').material_select();
                Materialize.updateTextFields();
            });
        </script>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Denuncia de usuario</span>
                    <s:form method="POST" action="doDenuncia.action">
                        <input type="hidden" name="id" value="<s:property value="id"/>"/>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">account_circle</i>
                                <input id="nombre" name="nombre" type="text" class="validate" value="<s:property value="nombre"/>" disabled>
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">security</i>
                                <s:select name="tipoDenuncia" id="tipoDenuncia" list="tiposDenuncia" listKey="id" listValue="nombre"></s:select>
                                <label for="titulacion">Tipo</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12">
                                <i class="material-icons prefix">mode_edit</i>
                                <textarea class="materialize-textarea" rows="7" id="declaracion" name="declaracion" required></textarea>
                                <label for="declaracion">Declaración</label>
                            </div>
                        </div>
                        <div class="row">
                            <div style="float: right; margin-right: 10px;">
                                <button id="submit" class="btn waves-effect waves-light" type="submit" name="action">Enviar</button>
                            </div>
                        </div>
                    </s:form>
                </div>
            </div>
        </div>
    </body>
</html>
