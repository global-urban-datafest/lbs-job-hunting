package co.working.action;

import com.opensymphony.xwork2.ActionSupport;
import net.sf.json.JSONArray;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.*;

@Controller("uploadAction")
@Scope("prototype")
public class UploadAction extends ActionSupport {
    /**
     *
     */
    private static final long serialVersionUID = 1L;

    private File myFile;

    private String myFileContentType;

    private String myFileFileName;

    private JSONArray obj;

    public JSONArray getObj() {
        return obj;
    }

    public void setObj(JSONArray obj) {
        this.obj = obj;
    }

    public File getMyFile() {
        return myFile;
    }

    public void setMyFile(File myFile) {
        this.myFile = myFile;
    }

    public String getMyFileContentType() {
        return myFileContentType;
    }

    public void setMyFileContentType(String myFileContentType) {
        this.myFileContentType = myFileContentType;
    }

    public String getMyFileFileName() {
        return myFileFileName;
    }

    public void setMyFileFileName(String myFileFileName) {
        this.myFileFileName = myFileFileName;
    }

    public  String userHeadUpload() throws Exception{
        InputStream is = new FileInputStream(myFile);

        String uploadPath="";

        OutputStream os=null;

        uploadPath= ServletActionContext.getServletContext().getRealPath("/images/userPhoto");

        os = Upload(is, uploadPath);

        is.close();

        os.close();

        obj=JSONArray.fromObject("['"+myFileFileName+"']");

        return "userHeadUpload_success";
    }
    public  String userPhotoUpload() throws Exception{
        InputStream is = new FileInputStream(myFile);

        String uploadPath="";

        //File toFile=null;

        OutputStream os=null;

        uploadPath= ServletActionContext.getServletContext().getRealPath("/images/photo");

        os = Upload(is, uploadPath);

        is.close();

        os.close();

        obj=JSONArray.fromObject("['"+myFileFileName+"']");

        return "userPhotoUpload_success";
    }
    public  String companyLogoUpload() throws Exception{
        InputStream is = new FileInputStream(myFile);

        String uploadPath="";

        //File toFile=null;

        OutputStream os=null;

        uploadPath= ServletActionContext.getServletContext().getRealPath("/images/logo");

        os = Upload(is, uploadPath);

        is.close();

        os.close();

        obj=JSONArray.fromObject("['"+myFileFileName+"']");

        return "companyLogoUpload_success";
    }
    private OutputStream Upload(InputStream is, String uploadPath)
            throws FileNotFoundException, IOException {
        File toFile;
        OutputStream os;
        toFile = new File(uploadPath, this.getMyFileFileName());

        os = new FileOutputStream(toFile);

        byte[] buffer = new byte[1024];

        int length = 0;

        while ((length = is.read(buffer)) > 0) {
            os.write(buffer, 0, length);
        }
        return os;
    }

}
