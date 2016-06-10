/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package upinder.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import java.util.List;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;
import upinder.dao.UpinderDAO;
import upinder.modelo.Mensaje;
import upinder.modelo.Notificacion;
import upinder.modelo.Usuario;
import upinder.util.Mailer;

public class NewMsgAction extends ActionSupport implements SessionAware{
    
    private UpinderDAO dao;
    private Map<String, Object> session;
    private Mailer m;
    
    private Integer id;
    private String mensaje;
    private String receptor;
    private List<Usuario> usuarios;
    private List<Mensaje> mensajes;
    
    public NewMsgAction() {
        dao = new UpinderDAO();
        session = ActionContext.getContext().getSession();
        m = new Mailer();
    }
    
    public String execute() throws Exception {
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Usuario receptor_aux = dao.getUsuario(Integer.parseInt(this.getReceptor()));
                
                dao.newMsg(user, receptor_aux, this.getMensaje());
                Notificacion n = dao.newNotificacion(receptor_aux, user, null, "Mensaje");
                if(receptor_aux.isEmailNot()){
                    m.sendNotificationMail(receptor_aux.getEmail(), receptor_aux.getNombre(), n.getTexto());
                }
                
                this.setUsuarios(dao.getUsuariosMatch(user.getId()));
                this.setMensajes(dao.getConversation(user.getId(), receptor_aux.getId()));
                this.setId(receptor_aux.getId());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMensaje() {
        return mensaje;
    }
    
    @RequiredStringValidator(message="Texto del mensaje obligatorio")
    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public List<Mensaje> getMensajes() {
        return mensajes;
    }

    public void setMensajes(List<Mensaje> mensajes) {
        this.mensajes = mensajes;
    }

    public Map<String, Object> getSession() {
        return session;
    }

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    public String getReceptor() {
        return receptor;
    }

    public void setReceptor(String receptor) {
        this.receptor = receptor;
    }

    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<Usuario> usuarios) {
        this.usuarios = usuarios;
    }
    
    
}
