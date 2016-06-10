<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Foto</title>
        <script>
            $(document).ready(function () {
                $('.modal-trigger').leanModal();
                $(".button-collapse").sideNav();
            });
        </script>
        <style>
            .modal.modal-fixed-footer {
                height: 300px;
            }
        </style>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <div class="card">
                <div class="card-content">
                    <span class="card-title"><s:property value='foto.titulo' default='Foto'/></span>
                    <div class="row">
                        <div class="col s12 center-align">
                            <img src="img/<s:property value='foto.url' default='no_user.png'/>" alt="" class="responsive-img" style="max-height: 500px;">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 center-align" style="font-size: large;">
                            <s:if test="hasreaccion">
                                <a href="doDeleteReactionFoto.action?id=<s:property value='id'/>" class="waves-effect waves-light btn-floating btn-large blue"><i class="material-icons left">thumb_up</i></a>
                            </s:if>
                            <s:else>
                                <a href="doReactionFoto.action?id=<s:property value='id'/>" class="waves-effect waves-light btn-floating btn-large grey"><i class="material-icons left">thumb_up</i></a>
                            </s:else>                            
                            <s:if test="reacciones.size() > 0">
                                <a class="modal-trigger" href="#modal1"><s:property value='reacciones.size()' default="0"/>&nbsp;personas</a>
                            </s:if>
                            <s:else>
                                <span>Sin reacciones</span>
                            </s:else>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Comentarios</span>
                    <s:form id="comentario" action="newComentarioFoto.action" method="POST">
                        <input type="hidden" name="id" value="<s:property value="foto.id"/>"/>
                        <div class="row">
                            <div class="col s12">
                                <div class="input-field col s12">
                                    <i class="material-icons prefix">mode_edit</i>
                                    <textarea id="icon_prefix2" class="materialize-textarea" rows="7" name="texto" required></textarea>
                                    <label for="icon_prefix2">Comentario</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12">
                                <div style="float: right;">
                                    <button class="btn waves-effect waves-light" type="submit" name="action">Enviar
                                        <i class="material-icons right">send</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </s:form>                    
                    <s:if test="%{comentarios.size() > 0}">
                        <ul class="collection">
                            <s:iterator value="comentarios" var="com">
                                <s:if test="%{(#session.user.id eq #com.usuario.id) or (#session.user.id eq foto.usuario.id)}">
                                    <li class="collection-item avatar">
                                        <img src="img/<s:property value="#com.usuario.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                                        <p><s:property value="#com.texto"/></p>
                                        <p class="grey-text text-lighten-1"><s:property value="#com.fechaPublicacion"/></p>
                                        <a href="doDeleteComentario.action?id=<s:property value="#com.id"/>" title="Eliminar comentario" class="secondary-content"><i class="material-icons">delete_forever</i></a>
                                    </li>
                                </s:if>
                                <s:else>
                                    <li class="collection-item avatar">
                                        <img src="img/<s:property value="#com.usuario.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                                        <p><s:property value="#com.texto"/></p>
                                        <p class="grey-text text-lighten-1"><s:property value="#com.fechaPublicacion"/></p>                              
                                    </li>
                                </s:else>                                
                            </s:iterator>
                        </ul>
                    </s:if>
                </div>
            </div>
        </div>
        <div id="modal1" class="modal bottom-sheet">
            <div class="modal-content">
                <h4>Gusta a</h4>
                <ul class="collection">
                    <s:iterator value="reacciones" var="reac">
                        <li class="collection-item avatar valign-wrapper">
                            <img src="img/<s:property value="#reac.usuario.fotoPerfil" default="no_user.png"/>" alt="" class="circle">
                            <span class="title"><s:property value="#reac.usuario.nombre" default="Usuario"/></span>
                        </li>
                    </s:iterator>
                </ul>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    </body>
</html>
