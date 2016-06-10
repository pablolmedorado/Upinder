<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Notificaciones</title>
        <script>
            $(document).ready(function () {
                $(".button-collapse").sideNav();
            });
        </script>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <s:if test="%{notificaciones.size() > 0 }">
                <ul class="collection with-header">
                    <li class="collection-header"><h4>Notificaciones<a href="doEliminarNotificaciones.action" title="Eliminar notificaciones"><i class="material-icons right" style="font-size: 3rem; color: black;">clear_all</i></a></h4></li>
                    <s:iterator value="notificaciones" var="noti">
                        <s:if test="#noti.fechaLectura">
                            <li class="collection-item">
                        </s:if>
                        <s:else>
                            <li class="collection-item" style="background-color: #F5F5F5; font-weight: bold;">
                        </s:else>        
                                <div>
                                    <s:property value="#noti.texto"/>
                                    <s:if test="%{#noti.tipo eq \"Mensaje\"}">
                                        <a href="goMensajes.action?id=<s:property value="#noti.usuarioByUsuarioAux.id"/>" title="Ver mensajes" class="secondary-content"><i class="material-icons">drafts</i></a>
                                    </s:if>
                                    <s:elseif test="%{#noti.tipo eq \"Match\"}">
                                        <a href="goUser.action?id=<s:property value="#noti.usuarioByUsuarioAux.id"/>" title="Ver perfil" class="secondary-content"><i class="material-icons">whatshot</i></a>
                                    </s:elseif>
                                    <s:elseif test="%{#noti.tipo eq \"Superlike\"}">
                                        <a href="goUser.action?id=<s:property value="#noti.usuarioByUsuarioAux.id"/>" title="Ver perfil" class="secondary-content"><i class="material-icons">grade</i></a>
                                    </s:elseif>
                                    <s:elseif test="%{#noti.tipo eq \"ReaccionFoto\"}">
                                        <a href="goFoto.action?id=<s:property value="#noti.foto.id"/>" title="Ver foto" class="secondary-content"><i class="material-icons">thumb_up</i></a>
                                    </s:elseif>
                                    <s:elseif test="%{#noti.tipo eq \"ComentarioFoto\"}">
                                        <a href="goFoto.action?id=<s:property value="#noti.foto.id"/>" title="Ver foto" class="secondary-content"><i class="material-icons">comment</i></a>
                                    </s:elseif>
                                    <s:else>
                                        <a href="goMensajes.action" class="secondary-content"><i class="material-icons">arrow_forward</i></a>
                                    </s:else>
                                </div>
                            </li>                                             
                    </s:iterator>
                </ul>
            </s:if>
            <s:else>
                <div class="row">
                    <div class="col s12">
                        <div class="card-panel">
                            <p>No tienes notificaciones.</p>
                        </div>
                    </div>
                </div>
            </s:else>
        </div>
    </body>
</html>
