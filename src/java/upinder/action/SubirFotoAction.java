package upinder.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.io.File;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import upinder.dao.UpinderDAO;
import upinder.modelo.Foto;
import upinder.modelo.Usuario;

public class SubirFotoAction extends ActionSupport implements SessionAware, ServletRequestAware {

    private File file;
    private String contentType;
    private String filename;
    private String dePerfil;
    private String titulo;
    
    private HttpServletRequest servletRequest;

    private UpinderDAO dao;
    private Map<String, Object> session;

    public SubirFotoAction(){
        dao = new UpinderDAO();
        session = ActionContext.getContext().getSession();
    }

    public String execute() {
        try {
            if(session.containsKey("user")){
                if(file == null){
                    return ActionSupport.SUCCESS;
                }
                String path = servletRequest.getSession().getServletContext().getRealPath("/img");
                File destFile = new File(path, String.valueOf(System.currentTimeMillis())+filename);
                FileUtils.copyFile(file, destFile);

                Foto f = new Foto();
                f.setUrl(destFile.getName());
                f.setDePerfil(this.getDePerfil().equalsIgnoreCase("true"));
                f.setTitulo(this.getTitulo());

                Usuario u = (Usuario)session.get("user");
                if(f.isDePerfil()){
                    u.setFotoPerfil(f.getUrl());
                    dao.modifyUsuario(u);
                }            
                f.setUsuario(u);
                dao.newFoto(f);

                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }

    public void setFoto(File file) {
        this.file = file;
    }

    public void setFotoContentType(String contentType) {
        this.contentType = contentType;
    }

    public void setFotoFileName(String filename) {
        this.filename = filename;
    }

    @Override
    public void setSession(Map<String, Object> map) {
        this.session = map;
    }

    public String getDePerfil() {
        return dePerfil;
    }

    public void setDePerfil(String dePerfil) {
        this.dePerfil = dePerfil;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    @Override
    public void setServletRequest(HttpServletRequest servletRequest) {
        this.servletRequest = servletRequest;
 
    }
    
    
}
