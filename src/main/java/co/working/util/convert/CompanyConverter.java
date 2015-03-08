package co.working.util.convert;

import co.working.model.Company;
import org.apache.struts2.util.StrutsTypeConverter;

import java.util.Map;

public class CompanyConverter extends StrutsTypeConverter {

	@Override
	public Object convertFromString(Map arg0, String[] values, Class toClass) { 
		String rpString=null;
		Company co=new Company();
	        if (values != null && values.length > 0) {  
	            rpString = values[0];  
	            if (rpString != null) {  
	                co.setId(Integer.parseInt(rpString)); 
	            }  
	        }  
	        return co;  
	}

	@Override
	public String convertToString(Map context, Object o) {
		Company co=null;
		if(o instanceof Company){
			co=(Company)o;
		}
		return co.toString();
	}

}
