package upinder.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import java.util.List;
import java.util.Map;
import org.apache.struts2.interceptor.SessionAware;
import upinder.dao.UpinderDAO;
import upinder.modelo.Comentario;
import upinder.modelo.Foto;
import upinder.modelo.Notificacion;
import upinder.modelo.Usuario;
import upinder.util.Mailer;

public class NewComentarioAction extends ActionSupport implements SessionAware{
    
    private UpinderDAO dao;
    private Map<String, Object> session;
    private Mailer m;
    
    private Integer id;
    private Foto foto;
    private String texto;
    private List<Comentario> comentarios;
    
    public NewComentarioAction() {
        dao = new UpinderDAO();
        session = ActionContext.getContext().getSession();
        m = new Mailer();
    }
    
    public String execute() throws Exception {
        try{
            if(session.containsKey("user")){
                Foto f = dao.getFoto(this.getId());
                Usuario u = (Usuario)session.get("user");
                
                dao.newComentarioFoto(f, u, this.getTexto());
                
                if(u.getId() != f.getUsuario().getId()){
                    Notificacion n = dao.newNotificacion(f.getUsuario(), u, f, "ComentarioFoto");
                    if(f.getUsuario().isEmailNot()){
                        m.sendNotificationMail(f.getUsuario().getEmail(), f.getUsuario().getNombre(), n.getTexto());
                    }
                }
                
                this.setFoto(f);
                this.setComentarios(dao.getComentariosFoto(f));
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

    public Foto getFoto() {
        return foto;
    }

    public void setFoto(Foto foto) {
        this.foto = foto;
    }

    public String getTexto() {
        return texto;
    }
    
    @RequiredStringValidator(message="Texto del comentario obligatorio")
    public void setTexto(String texto) {
        this.texto = texto;
    }

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    public Map<String, Object> getSession() {
        return session;
    }

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
    
}
