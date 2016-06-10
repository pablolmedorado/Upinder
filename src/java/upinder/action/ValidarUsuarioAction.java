package upinder.action;

import com.opensymphony.xwork2.ActionSupport;
import upinder.dao.UpinderDAO;
import upinder.modelo.Usuario;

public class ValidarUsuarioAction extends ActionSupport {
    private String user;
    private String codigo;
    private UpinderDAO dao;
    
    public ValidarUsuarioAction() {
        dao = new UpinderDAO();
    }
    
    public String execute(){
        try{
            System.out.println(this.getUser());
            Usuario user = dao.getUsuarioByEmail(this.getUser());
            if(user.getCodAct().equalsIgnoreCase(this.getCodigo())){
                user.setActivado(true);
                dao.modifyUsuario(user);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.ERROR;
            }
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }        
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
    
    
}
