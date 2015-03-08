package co.working.action;

import com.google.common.base.Strings;
import com.opensymphony.xwork2.ActionSupport;
import co.working.model.Company;
import co.working.model.EmployeeRelation;
import co.working.model.HireInfo;
import co.working.model.Resume;
import co.working.service.impl.*;
import co.working.util.EncryptUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("companyAction")
@Scope("prototype")
public class CompanyAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	//-----------------------------------常量部分------------------------------------
    public static final String RANDOMCODEKEY = "RANDOMVALIDATECODEKEY";//放到session中的key
    private static final String ERROR_MESS="error_message";
	//-------------------接收参数部分------------------
    private int id;
    @JSON(serialize = false)
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	private Company company;
    @JSON(serialize = false)
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	private HireInfo hr;
    @JSON(serialize = false)
	public HireInfo getHr() {
		return hr;
	}
	public void setHr(HireInfo hr) {
		this.hr = hr;
	}
	//------------------输出部分---------------------
	private JSONObject data;
	public JSONObject getData() {
		return data;
	}
	public void setData(JSONObject data) {
		this.data = data;
	}
	//---------------------注入部分-------------------
	private CompanyServiceImpl companyService;
	@Autowired
	public void setCompanyService(CompanyServiceImpl companyService) {
		this.companyService = companyService;
	}
    private EncryptUtil encryptUtil;
    @Autowired
    public void setEncryptUtil(EncryptUtil encryptUtil) {
        this.encryptUtil = encryptUtil;
    }
    private ReferenceServiceImpl referenceService;
    @Autowired
    public void setReferenceService(ReferenceServiceImpl referenceService) {
        this.referenceService = referenceService;
    }
    private HireInfoServiceImpl hireinfoService;
    @Autowired
	public void setHireinfoService(HireInfoServiceImpl hireinfoService) {
		this.hireinfoService = hireinfoService;
	}
    private ResumeServiceImpl resumeService;
    @Autowired
    public void setResumeService(ResumeServiceImpl resumeService) {
        this.resumeService = resumeService;
    }
    private EmployeeServiceImpl employeeService;
    @Autowired
	public void setEmployeeService(EmployeeServiceImpl employeeService) {
		this.employeeService = employeeService;
	}
    /*
     * 验证企业注册名
     * */
	public  String verifyLoginName() throws Exception{
	        data=new JSONObject();
	        List<Company> list =companyService.findExampleByCriteria("cpy_loginName",company.getCpy_loginName());
	        if(list==null||(list!=null&&list.size()==0))
	        {
	             data.accumulate("success",true);
	             data.accumulate("msg","");
	        }else{
	             data.accumulate("success",false);
	             data.accumulate("msg","该Email不可以使用");
	       }
		return "ajaxSuccess";
	}
	/*
	 * 企业快速注册
	 * */
	public String saveCompany() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
		if(company!=null){
			String pass=company.getCpy_loginPass();
			if(!Strings.isNullOrEmpty(pass)){
				pass=encryptUtil.Encrypt(pass);
			}
			company.setCpy_loginPass(pass);
			try{
				companyService.save(company);
	        }catch(Exception e){
	            return "registerError";
	        }
			return "registerLoginSuccess";
		}else{
            request.setAttribute(ERROR_MESS,"注册信息不完整或者缺失");
    		return "registerError";
    	}
	}
	/*
	 * 企业用户登录
	 * */
	public String login() throws Exception{
		 HttpServletRequest request=ServletActionContext.getRequest();
	     HttpSession session=request.getSession();
	     Object obj=session.getAttribute(RANDOMCODEKEY);
	     Object mess=session.getAttribute(ERROR_MESS);
	     if(mess!=null)
	          session.removeAttribute(ERROR_MESS);
	     mess=null;
	     if(obj!=null&&!"".equals(obj)){
	    	 /*首先判断当前验证码是否一致*/
             String userCode=request.getParameter("companyCode");
             if(userCode!=null&&userCode.equalsIgnoreCase(obj.toString())){
                 /*
                  *  当验证码正确时，此时先判断当前登录名，在数据库里是否存在，
                  *  若存在再继续比较密码，若不存在，则直接返回用户不存在
                 */
            	 String username=company.getCpy_loginName();
                 String userpass=company.getCpy_loginPass();
                 if(!Strings.isNullOrEmpty(username)&&!Strings.isNullOrEmpty(userpass)){
                	 List<Company> list =companyService.findExampleByCriteria("cpy_loginName",username);
                	 if(list!=null&&!list.isEmpty()&&list.size()==1){
                		 Company c=list.get(0);
                		 String c_pass=c.getCpy_loginPass();
                		 userpass=encryptUtil.Encrypt(userpass);
                		 if(!Strings.isNullOrEmpty(c_pass)&&userpass.equals(c_pass)){
                             if(session.getAttribute("loginUser")!=null)
                                 session.removeAttribute("loginUser");
                             session.setAttribute("loginUser",c);
                             if(session.getAttribute("loginType")!=null)
                                 session.removeAttribute("loginType");
                             session.setAttribute("loginType",2);
                             //在用户登录成功之后加载基础的reference
                             referenceService.initBaseReference(session);
                             //更新登录时间状态
                             c.setLastLoginDate(new Date());
                             companyService.update(c);
                             return "userLoginSuccess";
                		 }else{
                             request.setAttribute(ERROR_MESS, "用户名或者密码不正确！");
                			 return "loginError";
                		 } 
                	 }else{
                   	  request.setAttribute(ERROR_MESS, "用户不存在或者符合用户太多！");
                      return "loginError";
                	 }
                 }else{
                 	request.setAttribute(ERROR_MESS, "会员名或者会员密码为空！");
                    return "loginError";
                 }
             }else{
             	request.setAttribute(ERROR_MESS, "验证码为空或者验证码不正确！");
                return "loginError";
             }
	     }else{
	          request.setAttribute(ERROR_MESS, "获取验证码失败！");
	          return "loginError";
	    }
	}
    /*
    * 企业用户注销方法
    * */
    public String loginOut() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        session.invalidate();
        return "logoutSuccess";
    }
    /*
     * 跳转企业信息页面
     * */
    public String userProfileForward() throws Exception{
    	HttpServletRequest request=ServletActionContext.getRequest();
    	//获取参数id
    	String id=request.getParameter("id");
    	if(id!=null){
    		request.removeAttribute("company");
    		Company co=companyService.findExampleById(Integer.parseInt(id));
    		request.setAttribute("company", co);
    		co=null;
    		return "userProfile";
    	}else{
    		return "login";
    	}
    }
    /*
     * 更新企业信息
     * */
    public String updateCompany() throws Exception{
        data=new JSONObject();
		if(company!=null){
			int id=this.company.getId();
			if(id!=0){
				   	 Company co=companyService.get(id);
				   	 if(co!=null)
				   	 {
				   		boolean flag=co.isCpy_hot_flag();
				   		String loginName=co.getCpy_loginName();
				   		String pass=co.getCpy_loginPass();
				   		Date create =co.getCreationDate();
				   		Date last=co.getLastLoginDate();
				   		 company.setCpy_hot_flag(flag);
				   		 company.setCpy_loginName(loginName);
				   		 company.setCpy_loginPass(pass);
				   		 company.setCreationDate(create);
				   		 company.setLastLoginDate(last);
				   		loginName=null;
				   		pass=null;
				   		create=null;
				   		last=null;
				   	 }
				   	 co=null;
				     Integer companySize=company.getCompanySize();
				     if(companySize.equals(-1))
				    	 company.setCompanySize(null);
				     
				     Integer companyType=company.getCompanyType();
				     if(companyType.equals(-1))
				    	 company.setCompanyType(null);
				     
				     companyService.update(company);

			         data.accumulate("success",true);
			         data.accumulate("msg","");
			}else{
	            data.accumulate("success",false);
	            data.accumulate("msg","公司id不能为空!");
			}
		}else{
            data.accumulate("success",false);
            data.accumulate("msg","传入的公司信息不能为空!");
		}
		return "ajaxSuccess";
	}
    /*
     * 跳转企业密码修改页面
     * */
    public String userPassForward() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        //获取参数id
        String id=request.getParameter("id");
        if(id!=null){
            Company tmp=companyService.findExampleById(Integer.parseInt(id));
            request.setAttribute("company", tmp);
            tmp=null;
            return "userPass";
        }else{
            return "login";
        }
	}
    /*
     * 验原密码是否正确
     * */
    public String checkPass() throws Exception{
    	if(company!=null){
    		int id =company.getId();
            String pass=company.getCpy_loginPass();
            data=new JSONObject();
            if(id!=0){
            	Company co=companyService.findExampleById(id);
            	String repass=co.getCpy_loginPass();
            	if(!Strings.isNullOrEmpty(pass)){
            		pass=encryptUtil.Encrypt(pass);
            		if(pass.equals(repass)){
            	        data.accumulate("msg",true);
            		}else{
            	        data.accumulate("msg",false);
            		}
            	}else{
                    data.accumulate("msg",false);
            	}	
            	repass=null;
            	co=null;
            }else{
                data.accumulate("msg",false);
            }
            pass=null;
    	}else{
            data.accumulate("msg",false);
    	}
    	return "ajaxSuccess";
    }
    /*
     * 修改密码
     * */
    public String updateUserPass() throws Exception{
    	if(company!=null){
            int id =company.getId();
            String pass=company.getCpy_loginPass();
            data=new JSONObject();
            if(id!=0){
            	Company tmp=companyService.findExampleById(id);
            	if(!Strings.isNullOrEmpty(pass)){
            		pass=encryptUtil.Encrypt(pass);
            		tmp.setCpy_loginPass(pass);;
            		companyService.update(tmp);
            		data.accumulate("msg",true);
            	}else{
                    data.accumulate("msg",false);
            	}	
            	tmp=null;
            }else{
                data.accumulate("msg",false);
            }
            pass=null;
    	}else{
    		data.accumulate("msg",false);
    	}	
      	return "ajaxSuccess";
    }
    /*
     * 跳转职位列表页面
     * */
    public String hireinfoListForward() throws Exception{
    	return "hireinfoList";
    }
    /*
     * 获取职位列表
     * */    
    public String findHireInfoList() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        //因为rows定死了为每页5条记录,所以在这里先计算总页数集pageCount
        int total=0;
        data=new JSONObject();
        if(company!=null){
            total=hireinfoService.getCount("company", company);
         	int page = new Integer(request.getParameter("page"));
        	int rows = new Integer(request.getParameter("rows"));
        	List<HireInfo> list=hireinfoService.findAllByCriteria("company", company, (page-1)*rows, rows);
        	if(list!=null&&list.size()>0&&total!=0){
                data.accumulate("total", total);
        		JSONArray rowArray = new JSONArray();
        		for(HireInfo hr:list){
        			JSONObject obj=new JSONObject();
        			obj.accumulate("id", hr.getId());
        			obj.accumulate("positionName", hr.getPositionName()==null?"":hr.getPositionName());
        			obj.accumulate("hireDesc", hr.getHireDesc()==null?"":hr.getHireDesc());
        			obj.accumulate("workplace", hr.getWorkplace()==null?"":hr.getWorkplace());
        			obj.accumulate("salary", hr.getSalary()==null?"":hr.getSalary());
        			obj.accumulate("jobpeopleNum", hr.getJobpeopleNum());
        			obj.accumulate("jobRequried", hr.getJobRequried()==null?"":hr.getJobRequried());
        			obj.accumulate("jobTreatment", hr.getJobTreatment()==null?"":hr.getJobTreatment());
        			obj.accumulate("disabledFlag", hr.isDisabledFlag());
        			obj.accumulate("disabledDate", hr.getDisabledDate()==null?"":hr.getDisabledDate());
        			rowArray.add(obj);
        			obj=null;
        		}
        		data.accumulate("rows", rowArray);
        	}else{
        		 data.accumulate("total", 0);
        		data.accumulate("rows", "");
        	}

        }else{
   		 data.accumulate("total", 0);
   		data.accumulate("rows", "");
   	}
        return "ajaxPageSuccess";
    }
    /*
     * 新增职位信息
     * */
    public String saveHireInfo() throws Exception{
    	data=new JSONObject();
    	Company co=this.hr.getCompany();
    	if(co!=null&&co.getId()!=0){
    		if(hr.getWorktype()!=null&&hr.getWorktype().equals(-1))
    			hr.setWorktype(null);
    		if(hr.getWorkyear()!=null&&hr.getWorkyear().equals(-1))
    			hr.setWorkyear(null);
    		hr.setDisabledDate(null);
    		hr.setDisabledFlag(false);
    		hireinfoService.save(hr);
    		data.accumulate("success", true);
    		data.accumulate("msg", "");
    	}else{
    		data.accumulate("success", false);
    		data.accumulate("msg", "未发现对应的公司，发布招聘信息失败");
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 查找对应职位信息并跳转职位更新页面
     * */
    public String findHireInfoById() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
    	if(id!=0){
    		HireInfo h=hireinfoService.findExampleById(id);
    		if(h!=null){
            	request.setAttribute("hireinfo", h);
    		}else{
    			request.setAttribute("hireinfo", null);
    		}
    	}else{
    		request.setAttribute("hireinfo", null);
    	}
    	return "updateHireinfo";
    }
    /*
     * 更新职位
     * */
    public String updateHireInfo() throws Exception{
    	Company co=hr.getCompany();
    	data=new JSONObject();
    	if(co!=null&&co.getId()!=0){
    		int hrId=hr.getId();
    		if(hrId!=0){
    			HireInfo h=hireinfoService.get(hrId);
    			hr.setDisabledDate(h.getDisabledDate());
    			hr.setDisabledFlag(h.isDisabledFlag());
    			h=null;
       			Integer worktype=hr.getWorktype();
			    if(worktype.equals(-1))
			    	 hr.setWorktype(null);;
       			hireinfoService.update(hr);
        		data.accumulate("success", true);
        		data.accumulate("msg", "");	
        		
    		}else{
        		data.accumulate("success", false);
        		data.accumulate("msg", "招聘信息id不能为空");	
    		}
    	}else{
    		data.accumulate("success", false);
    		data.accumulate("msg", "发布招聘信息公司信息不能为空");
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 恢复该条职位
     * */
    public String enabledHireInfo() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
    		HireInfo ho=hireinfoService.findExampleById(id);
    		if(ho!=null){
    			ho.setDisabledDate(null);
    			ho.setDisabledFlag(false);
    			hireinfoService.update(ho);
        		data.accumulate("success", true);
        		data.accumulate("msg", "");
    		}else{
        		data.accumulate("success", false);
        		data.accumulate("msg", "未找到对应的招聘信息");
    		}
    	}else{
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 取消该条职位
     * */
    public String disabledHireInfo() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
    		HireInfo ho=hireinfoService.findExampleById(id);
    		if(ho!=null){
    			ho.setDisabledDate(new Date());
    			ho.setDisabledFlag(true);
    			hireinfoService.update(ho);
        		data.accumulate("success", true);
        		data.accumulate("msg", "");
    		}else{
        		data.accumulate("success", false);
        		data.accumulate("msg", "未找到对应的招聘信息");
    		}
    	}else{
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 删除该条职位
     * */
    public String deleteHireinfo() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
    		HireInfo h=hireinfoService.get(id);
    		if(h!=null){
    			List<EmployeeRelation> elist=employeeService.findExampleByCriteria("pk.hireinfo", h);
    			if(elist!=null&&elist.size()>0){
            		employeeService.deleteAll(elist);
            		hireinfoService.delete(h);
            		data.accumulate("success", true);
            		data.accumulate("msg", "");
    			}else{
               		data.accumulate("success", false);
            		data.accumulate("msg", "为查找到要删除的信息");
        		}
    		}else{
           		data.accumulate("success", false);
        		data.accumulate("msg", "为查找到要删除的信息");
    		}
    	}else{
       		data.accumulate("success", false);
    		data.accumulate("msg", "传入的招聘信息id不能为空");
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 获取企业职位所获简历列表信息
     * */
	public String employReLationList() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
	    	data=new JSONObject();
	    	if(id!=0){
	    		Company co=	companyService.get(id);
	    		if(co!=null){
	    			StringBuffer sql=new StringBuffer();
	    			 sql.append("select thr.isViewFlag as viewFlag ,thr.sendDate as sendDate,th.positionName as positionName,th.workplace as workplace ,tcr.ref_tableDesc as refdesc,th.hotflag as hotflag,trd.realname as realname,thr.resumeId as resumeId,thr.hireinfoId as hireinfoId ,tc.id as companyId from  t_hireinfo_resume thr ");
	    			 
	    			 sql.append(" inner join t_hireinfo th on thr.hireinfoId =th.id ");
	    			 
		    		 String workplace=request.getParameter("workplace");
		    		 if(!Strings.isNullOrEmpty(workplace))
		    				sql.append(" and th.workplace like '%"+workplace+"%' ");
		    		 
		    		 String hotflag=request.getParameter("hotflag");
		    		 if(!Strings.isNullOrEmpty(hotflag))
		    			 	sql.append(" and th.hotflag = "+hotflag);
		    		 
		    		 String positionName=request.getParameter("positionName");
		    		 if(!Strings.isNullOrEmpty(positionName))
		    			 	sql.append(" and th.positionName like '%"+positionName+"%' ");
		    		 
	    			 sql.append(" inner join  t_resume tr on thr.resumeId=tr.id ");
	    			 
	    			 sql.append(" inner join t_resumedetail trd on trd.id=tr.id ");
	    			 
		    		 String workyear =request.getParameter("workyear");
		    		 if(!Strings.isNullOrEmpty(workyear)&&!"-1".equals(workyear))
		    			 sql.append(" and trd.workyear="+workyear);
	    			 
	    			 sql.append(" inner join t_company tc on tc.id=th.companyId and tc.id = "+co.getId());
	    			
	    			 sql.append(" left join t_commonref tcr on tcr.id=trd.workyear and tcr.ref_tableName='WorkYear' ");

	             	int page = new Integer(request.getParameter("page"));
	            	int rows = new Integer(request.getParameter("rows"));
	    			List<Object> list=employeeService.findExampleByNativeSql(sql.toString(),(rows*(page-1)),rows);
	    			int count=employeeService.getCountByNativeSql(sql.toString());
	    	        if(list!=null&&list.size()>0){
	    	        	JSONArray arr=new JSONArray();
	    	        	SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
	    	        	for(Object obj:list){
	    	        		if(obj instanceof Object[]){
	    	        			Object[] o=(Object[])obj;
	    	        			JSONObject t=new JSONObject();
				    	        t.accumulate("viewFlag",o[0]);   
								t.accumulate("sendDate",o[1]==null?"":sf.format(o[1]));
								t.accumulate("positionName",o[2]==null?"":o[2]);
								t.accumulate("workplace",o[3]==null?"":o[3]);
								t.accumulate("refdesc",o[4]==null?"":o[4]);
								t.accumulate("hotflag",o[5]);
								t.accumulate("realname",o[6]==null?"":o[6]);
								t.accumulate("resumeId",o[7]);
								t.accumulate("hireinfoId",o[8]);
								t.accumulate("companyId",o[9]);
								arr.add(t);
								t=null;
	    	        		}else{
	    	        			break;
	    	        		}
	    	        	}
	    	        	sf=null;
	    	        	data.accumulate("rows", arr);
	    	        	data.accumulate("total", count);
	    	        }else{
	    	        	data.accumulate("rows", "");
	    	        	data.accumulate("total", 0);
	    	        }
	    		}
	    	}else{
	    		data.accumulate("total", 0);
	    		data.accumulate("rows", "");
	    	}
	    	return "ajaxPageSuccess";
	}
	/*
	 * 取消录取
	 * */
	public String deApplyJob() throws Exception{	
        HttpServletRequest request=ServletActionContext.getRequest();
    	data=new JSONObject();
    	String o1=request.getParameter("hireinfoId");
    	String o2=request.getParameter("resumeId");
    	int hireinfoId=Integer.parseInt(o1);
    	int resumeId=Integer.parseInt(o2);
    	if(hireinfoId!=0&&resumeId!=0){
    		HireInfo h=hireinfoService.get(hireinfoId);
    		Resume r=resumeService.get(resumeId);
    		if(h!=null&&r!=null){
    	        Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
    	        
    	    	Map<String,Object> submap=new HashMap<String,Object>();
    	    	submap.put("pk.resume",r);
    	    	map.put("eq", submap);
    	    	submap=null;
    	    	
    	    	submap=new HashMap<String,Object>();
    	    	submap.put("pk.hireinfo",h);
    	    	map.put("eq", submap);
    	    	submap=null;
    	    	
    			List<EmployeeRelation> elist=employeeService.findExampleByCriteriaAndMap(map);
    			
    			map=null;
    			
    			if(elist!=null&&elist.size()==1){

    				EmployeeRelation er=elist.get(0);
    				
    				er.setViewFlag(2);
    				
    				employeeService.update(er);
    				
            		data.accumulate("success", true);
            		data.accumulate("msg", "");
            		
    			}else{
               		data.accumulate("success", false);
               		data.accumulate("msg", "查询的投递信息过多或者不存在，取消录取失败");
        		}
    		}else{
           		data.accumulate("success", false);
        		data.accumulate("msg", "获取该条投递信息失败");
    		}
    	}else{
       		data.accumulate("success", false);
    		data.accumulate("msg", "获取该条投递信息失败");
    	}
    	return "ajaxPageSuccess";
    }
	/*
	 * 录取
	 * */
    public String applyJob() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
    	data=new JSONObject();
    	String o1=request.getParameter("hireinfoId");
    	String o2=request.getParameter("resumeId");
    	int hireinfoId=Integer.parseInt(o1);
    	int resumeId=Integer.parseInt(o2);
    	if(hireinfoId!=0&&resumeId!=0){
    		HireInfo h=hireinfoService.get(hireinfoId);
    		Resume r=resumeService.get(resumeId);
    		if(h!=null&&r!=null){
    	        Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
    	        
    	    	Map<String,Object> submap=new HashMap<String,Object>();
    	    	submap.put("pk.resume",r);
    	    	map.put("eq", submap);
    	    	submap=null;
    	    	
    	    	submap=new HashMap<String,Object>();
    	    	submap.put("pk.hireinfo",h);
    	    	map.put("eq", submap);
    	    	submap=null;
    	    	
    			List<EmployeeRelation> elist=employeeService.findExampleByCriteriaAndMap(map);
    			
    			map=null;
    			
    			if(elist!=null&&elist.size()==1){

    				EmployeeRelation er=elist.get(0);
    				
    				er.setViewFlag(3);
    				
    				employeeService.update(er);
    				
            		data.accumulate("success", true);
            		data.accumulate("msg", "");
            		
    			}else{
               		data.accumulate("success", false);
            		data.accumulate("msg", "查询的投递信息过多或者不存在，录取失败");
        		}
    		}else{
           		data.accumulate("success", false);
        		data.accumulate("msg", "获取该条投递信息失败");
    		}
    	}else{
       		data.accumulate("success", false);
    		data.accumulate("msg", "获取该条投递信息失败");
    	}
    	return "ajaxPageSuccess";
    }
    public String companyAnalytics() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
    		Company	co=companyService.get(id);
    		List<HireInfo> list=hireinfoService.findAllByCriteria("company", co);
    		if(list!=null&&list.size()>0){
				StringBuffer s1=new StringBuffer();
				StringBuffer s2=new StringBuffer();
				for(HireInfo h:list){
					s1.append("\""+h.getPositionName()+"\",");
					List<EmployeeRelation> ll=employeeService.findExampleByCriteria("pk.hireinfo", h);
					s2.append(""+list==null?0:ll.size()+",");
				}
				if(s1.lastIndexOf(",")>0){
					s1.deleteCharAt(s1.lastIndexOf(","));
				}
				if(s2.lastIndexOf(",")>0){
					s2.deleteCharAt(s2.lastIndexOf(","));
				}

    			StringBuffer sb=new StringBuffer();
    			sb.append("{");
		    			sb.append("labels : [");
		    				sb.append(s1);
		    		    sb.append("],");
		    			sb.append("datasets : [");
			    			sb.append("{");
			    			sb.append("fillColor : \"rgba(220,220,220,0.5)\",");
			    			sb.append("strokeColor :\"rgba(220,220,220,1)\",");
				    			sb.append("data : [");
				    				sb.append(s2);
				    			sb.append("]");
			    			sb.append("}");
		    			sb.append("]");
    			sb.append("}");
    			System.out.println(sb.toString());
    			data.accumulate("data", sb.toString());
    			}
    		else{
        		data.accumulate("data", "");
    		}
    	}else{
    		data.accumulate("data", "");
    	}
    	return "ajaxPageSuccess";
    }
}
