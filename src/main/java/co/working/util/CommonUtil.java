package co.working.util;

import co.working.model.ResumeDetail;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/**
 * 工具类，由多组静态方法组成
 */
public class CommonUtil {
	public static List<String> getField(String className){
		List<String> list=new ArrayList<String>();
		 try {
			Class<?> clazz=Class.forName(className,true,CommonUtil.class.getClassLoader());
			Field[] fields= clazz.getDeclaredFields();
			for(Field f:fields){
				String fieldName=f.getName();
				String affix=fieldName.substring(0,1).toUpperCase()+fieldName.substring(1,fieldName.length());
				String getMethodName="get"+affix;
				list.add(getMethodName);
			}
		} catch (Exception e) {
			list=null;
		}
		return list;
	}
	public static Double getPercent(ResumeDetail rd){
		double count=32.0;
		int num=0;
		if(rd.getRealname()!=null)
			num++;
		if(rd.getSex()!=null)
			num++;
		if(rd.getBirthday()!=null)
			num++;
		if(rd.getWorkyear()!=null)
			num++;
		if(rd.getDocumenttype()!=null)
			num++;
		if(rd.getDocumentcode()!=null)
			num++;
		if(rd.getLivingaddress()!=null)
			num++;
		if(rd.getEmail()!=null)
			num++;
		if(rd.getMobile()!=null)
			num++;
		if(rd.getCompanytel()!=null)
			num++;
		if(rd.getHometel()!=null)
			num++;
		if(rd.getSalary()!=null)
			num++;
		if(rd.getJobstatus()!=null)
			num++;
		if(rd.getHometown()!=null)
			num++;
		if(rd.getMarriagestatus()!=null)
			num++;
		if(rd.getHeight()!=null)
			num++;
		if(rd.getPoliticstatus()!=null)
			num++;
		if(rd.getPhoto()!=null)
			num++;
		if(rd.getZip()!=null)
			num++;
		if(rd.getWorktype()!=null)
			num++;
		if(rd.getWorkspace()!=null)
			num++;
		if(rd.getPositiontype()!=null)
			num++;
		if(rd.getExceptsalary()!=null)
			num++;
		if(rd.getSelfIntrodution()!=null)
			num++;
		if(rd.getOnboardingdate()!=null)
			num++;
		if(rd.getQq()!=null)
			num++;
		if(rd.getWechat()!=null)
			num++;
		if(rd.getResume()!=null)
			num++;
		if(rd.getSkills()!=null)
			num++;
		if(rd.getCompanys()!=null)
			num++;
		if(rd.getAwards()!=null)
			num++;
		if(rd.getExperiences()!=null)
			num++;
		
		return num/count*100;
	} 
}
