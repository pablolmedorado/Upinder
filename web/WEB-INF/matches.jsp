<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Matches</title>
        <style>
            .modal.modal-fixed-footer {
                height: 300px;
            }
        </style>
        <script>
            $(document).ready(function () {
                $(".button-collapse").sideNav();
            });
        </script>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <s:if test="%{matches.size > 0}">
                <ul class="collection">
                    <s:iterator value="matches" var="mtch">
                        <li class="collection-item avatar">
                            <img src="img/<s:property value="#mtch.usuarioByUsuario2.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                            <p><a href="goUser.action?id=<s:property value="#mtch.usuarioByUsuario2.id"/>"><s:property value="#mtch.usuarioByUsuario2.nombre"/></a></p><br>
                            <p class="grey-text text-lighten-1"><s:property value="#mtch.fecha"/></p>
                            <div class="secondary-content">
                                <a class="teal-text" title="Denunciar usuario" href="goDenuncia.action?id=<s:property value="#mtch.usuarioByUsuario2.id"/>"><i class="material-icons" style="font-size: 2rem;">report</i></a>
                                <a class="teal-text" title="Eliminar match" href="doDeleteMatch.action?id=<s:property value="#mtch.usuarioByUsuario2.id"/>"><i class="material-icons" style="font-size: 2rem;">delete_forever</i></a>
                            </div>                            
                        </li>                
                    </s:iterator>
                </ul>
            </s:if>
            <s:else>
                <div class="row">
                    <div class="col s12">
                        <div class="card-panel">
                            <p>Aún no tienes match con ningún usuario.</p>
                        </div>
                    </div>
                </div>
            </s:else>
        </div>
    </body>
</html>
