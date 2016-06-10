<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Mensajes</title>
        <style>
            .modal.modal-fixed-footer {
                height: 300px;
            }
            .collection .collection-item.avatar.user .circle {
                right: 15px;
                left: auto;
            }
            .collection .collection-item.avatar.user {
                padding-right: 72px;
                padding-left: 20px;
            }
        </style>
        <script>
            $(document).ready(function () {
                <s:if test="!mensajes">
                    $('#modal1').openModal();
                </s:if>                
                
                $('#listusers').click(function(){
                    $('#modal1').openModal();
                });
                $('#newmsg').click(function(){
                    $('#modal2').openModal();
                });
                
                $("#enviar").click(function(){
                    $("#formulario").submit();
                });
                
                $(".button-collapse").sideNav();
            });
        </script>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <s:if test="%{mensajes.size > 0}">
                <ul class="collection with-header">
                    <li class="collection-header"><h4>Conversación con <s:property value="nombre"/></h4></li>
                    <s:iterator value="mensajes" var="msg">
                        <s:if test="%{#session.user.id eq #msg.usuarioByEmisor.id}">
                            <li class="collection-item avatar">
                                <img src="img/<s:property value="#msg.usuarioByEmisor.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                                <p><s:property value="#msg.texto"/></p><br>
                                <p class="grey-text text-lighten-1"><s:property value="#msg.fechaEnvio"/></p>
                                <a href="doDeleteMsg.action?id=<s:property value="#msg.id"/>" title="Eliminar mensaje" class="secondary-content"><i class="material-icons">delete_forever</i></a>
                            </li>
                        </s:if>
                        <s:else>
                            <li class="collection-item avatar">
                                <a href="goUser.action?id=<s:property value="#msg.usuarioByEmisor.id"/>"><img src="img/<s:property value="#msg.usuarioByEmisor.fotoPerfil" default="no_user.png"/>" alt="" class="circle"></a>
                                <p><s:property value="#msg.texto"/></p><br>
                                <p class="grey-text text-lighten-1"><s:property value="#msg.fechaEnvio"/></p>
                            </li>
                        </s:else>                        
                    </s:iterator>
                </ul>
            </s:if>
            <s:elseif test="id != null">
                <div class="row">
                    <div class="col s12">
                        <div class="card-panel">
                            <p>Aún no tienes ningun mensaje con <s:property value="nombre" default="este usuario"/>. ¿Por qué no le escribes tu?</p>
                        </div>
                    </div>
                </div>
            </s:elseif>
        </div>
        <div id="modal1" class="modal bottom-sheet">
            <div class="modal-content">
                <h4>Mensajes</h4>
                <s:if test="%{usuarios.size > 0}">
                    <ul class="collection">
                        <s:iterator value="usuarios" var="user">
                            <li class="collection-item avatar valign-wrapper">
                                <img src="img/<s:property value="#user.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                                <span class="title"><s:property value="#user.nombre" default="Usuario"/></span>
                                <a href="goMensajes.action?id=<s:property value="#user.id"/>" class="secondary-content"><i class="material-icons" style="font-size: 2rem;">inbox</i></a>
                            </li>
                        </s:iterator>
                    </ul>
                </s:if>
                <s:else>
                    <p>Aún no tienes match con ningún usuario.</p>
                </s:else>
            </div>
            <div class="modal-footer">
            </div>
        </div>
        <div id="modal2" class="modal modal-fixed-footer">
            <s:form id="formulario" action="newMsg.action" method="POST">
                <input type="hidden" name="receptor" value="<s:property value="id"/>"/>
                <div class="modal-content">
                  <h4>Nuevo Mensaje</h4>
                  <div class="row">
                        <div class="input-field col s12">
                          <i class="material-icons prefix">mode_edit</i>
                          <textarea class="materialize-textarea" rows="7" id="icon_prefix2" name="mensaje" required></textarea>
                          <label for="icon_prefix2">Mensaje</label>
                        </div>
                  </div>
                </div>
                <div class="modal-footer">
                    <a id="enviar" href="#!" class="modal-action modal-close waves-effect btn-flat waves-light">Enviar
                        <i class="material-icons right">send</i>
                    </a>
                    <a href="#!" class="modal-action modal-close waves-effect btn-flat waves-light">Cancelar</a>
                </div>
            </s:form>
        </div>
        <s:if test="id != null">
            <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
                <a id="newmsg" class="btn-floating btn-large teal">
                  <i class="large material-icons">mode_edit</i>
                </a>
                <ul>
                    <li><a id="listusers" class="btn-floating indigo darken-4"><i class="material-icons">list</i></a></li>
                </ul>
            </div>
        </s:if>
        <s:else>
            <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
                <a id="listusers" class="btn-floating btn-large teal">
                    <i class="material-icons">list</i>
                </a>
            </div>
        </s:else>
    </body>
</html>
