package co.working.util.convert;

import co.working.model.Resume;
import org.apache.struts2.util.StrutsTypeConverter;

import java.util.Map;

public class ResumeConverter extends StrutsTypeConverter {

	@Override
	public Object convertFromString(Map arg0, String[] values, Class toClass) { 
		String rpString=null;
		Resume resume=new Resume();
	        if (values != null && values.length > 0) {  
	            rpString = values[0];  
	            if (rpString != null) {  
	                resume.setId(Integer.parseInt(rpString)); 
	            }  
	        }  
	        return resume;  
	}

	@Override
	public String convertToString(Map context, Object o) {
		Resume resume=null;
		if(o instanceof Resume){
			resume=(Resume)o;
		}
		return resume.toString();
	}

}
