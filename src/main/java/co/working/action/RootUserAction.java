package co.working.action;

import com.google.common.base.Strings;
import com.opensymphony.xwork2.ActionSupport;
import co.working.model.*;
import co.working.service.impl.*;
import co.working.util.EncryptUtil;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller("rootUser")
public class RootUserAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	 //-----------------------------------ajax返回参数-----------------------------------
    private JSONObject data;
    public void setData(JSONObject data) {
        this.data = data;
    }
	public JSONObject getData() {
        return data;
    }
	//-------------------------------------传入参数部分----------------------------------
    private int id;
    @JSON(serialize = false)
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    
    private RootUser rootUser;
    @JSON(serialize = false)
	public RootUser getRootUser() {
		return rootUser;
	}
	public void setRootUser(RootUser rootUser) {
		this.rootUser = rootUser;
	}
	
    private User user;
    @JSON(serialize = false)
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
	
    private Company company;
    @JSON(serialize = false)
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	
	private Resume resume;
    @JSON(serialize = false)
	public Resume getResume() {
		return resume;
	}
	public void setResume(Resume resume) {
		this.resume = resume;
	}
	private ResumeDetail  resumeDetail;
    @JSON(serialize = false)
	public ResumeDetail getResumeDetail() {
		return resumeDetail;
	}
	public void setResumeDetail(ResumeDetail resumeDetail) {
		this.resumeDetail = resumeDetail;
	}
	//---------------------------------注入部分-----------------------------------------
	private UserServiceImpl userService;
    @Autowired
    public void setUserService(UserServiceImpl userService) {
        this.userService = userService;
    }
	private CompanyServiceImpl companyService;
	@Autowired
	public void setCompanyService(CompanyServiceImpl companyService) {
		this.companyService = companyService;
	}
	private ResumeDetailServiceImpl resumeDetailService;
    @Autowired
	public void setResumeDetailService(ResumeDetailServiceImpl resumeDetailService) {
		this.resumeDetailService = resumeDetailService;
	}

    private ResumeServiceImpl resumeService;
    @Autowired
    public void setResumeService(ResumeServiceImpl resumeService) {
        this.resumeService = resumeService;
    }
    private HireInfoServiceImpl hireinfoService;
    @Autowired
	public void setHireinfoService(HireInfoServiceImpl hireinfoService) {
		this.hireinfoService = hireinfoService;
	}
    private ReferenceServiceImpl referenceService;
    @Autowired
    public void setReferenceService(ReferenceServiceImpl referenceService) {
        this.referenceService = referenceService;
    }

    private EncryptUtil encryptUtil;
    @Autowired
    public void setEncryptUtil(EncryptUtil encryptUtil) {
        this.encryptUtil = encryptUtil;
    }
    
    private EmployeeServiceImpl employeeService;
    @Autowired
	public void setEmployeeService(EmployeeServiceImpl employeeService) {
		this.employeeService = employeeService;
	}
    
    private RootUserServiceImpl rootUserService;
    @Autowired
	public void setRootUserService(RootUserServiceImpl rootUserService) {
		this.rootUserService = rootUserService;
	}
	public String login() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
		String loginName=rootUser.getLoginName();
		String loginPass=rootUser.getLoginPass();
		if(!Strings.isNullOrEmpty(loginName)){
			List<RootUser> list=rootUserService.findExampleByCriteria("loginName",loginName);
			if(list!=null&&list.size()==1){
				RootUser root=list.get(0);
				if(!Strings.isNullOrEmpty(loginPass)){
					if(root.getLoginPass().equals(encryptUtil.Encrypt(loginPass))){
						root.setUpdateDate(new Date());
						rootUserService.update(root);
                        referenceService.initBaseReference(session);
						session.setAttribute("loginUser", root);
						return "loginSuccess";
					}else{
						request.setAttribute("loginMess", "用户名或者密码不正确!");
						return "login";
					}
				}else{
					request.setAttribute("loginMess", "登录密码不能为空!");
					return "login";
				}
			}else{
				request.setAttribute("loginMess", "匹配的用户过多或者不存在!");
				return "login";
			}
		}else{
			request.setAttribute("loginMess", "登录名不能为空!");
			return "login";
		}
    }
	
	public String loginOut() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        session.removeAttribute("loginUser");
        session.invalidate();
		return "login";
	}
	
	public String addRootUserForward() throws Exception{	
		return "addRootUser";
	}
	
	public String addRootUser() throws Exception{
		data=new JSONObject();
		String loginName=rootUser.getLoginName();
		String loginPass=rootUser.getLoginPass();
		if(rootUser!=null){
			if(!Strings.isNullOrEmpty(loginName)&&!Strings.isNullOrEmpty(loginPass)){
				loginPass=encryptUtil.Encrypt(loginPass);
				rootUser.setLoginPass(loginPass);
				rootUser.setCreationDate(new Date());
				rootUserService.save(rootUser);
				data.accumulate("success",true);
				data.accumulate("msg", "");
			}else{
				data.accumulate("success",false);
				data.accumulate("msg", "登录名或者密码不能为空");
			}
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的参数为空或者不存在");
		}
		return "ajaxPageSuccess";
	}
	
	public String rootUserList()throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
		List<RootUser> list=rootUserService.findAllExample();
		request.setAttribute("rootUsers", list);
		return "rootUserList";
	}
	
	public String deleteRootUser() throws Exception{
		data=new JSONObject();
		if(id!=0){
			rootUserService.delete(id);
			data.accumulate("success",true);
			data.accumulate("msg", "");
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的id为空,删除管理员失败");
		}
		return "ajaxPageSuccess";
	}
	
	public String verifyLoginPass() throws Exception{
		data=new JSONObject();
        HttpServletRequest request=ServletActionContext.getRequest();
        String loginPass= request.getParameter("loginPass");
		if(id!=0&&!Strings.isNullOrEmpty(loginPass)){
			RootUser root=rootUserService.get(id);
			loginPass=encryptUtil.Encrypt(loginPass);
			if(root.getLoginPass().equals(loginPass))
				data.accumulate("success",true);
			else
				data.accumulate("success",false);
		}else{
			data.accumulate("success",false);
		}
		return "ajaxPageSuccess";
	}
	
	public String updatePass() throws Exception{
		data=new JSONObject();
		if(rootUser!=null){
			int id =rootUser.getId();
			String loginPass=rootUser.getLoginPass();
			if(!Strings.isNullOrEmpty(loginPass)){
				RootUser r=rootUserService.get(id);
				if(r!=null){
					loginPass=encryptUtil.Encrypt(loginPass);
					r.setLoginPass(loginPass);
					rootUserService.merge(r);
					data.accumulate("success",true);
					data.accumulate("msg", "");
				}else{
					data.accumulate("success",false);
					data.accumulate("msg", "未查找到对应的记录，更新密码失败！");
				}
			}else{
				data.accumulate("success",false);
				data.accumulate("msg", "更新密码不能为空，更新密码失败！");
			}
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的参数有误，更新密码失败！");
		}
		return "ajaxPageSuccess";
	}
	
	public String findAllUser() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
     	int page = new Integer(request.getParameter("page"));
    	int rows = new Integer(request.getParameter("rows"));
    	data=userService.findAllUser((page-1)*rows,rows);
		return "ajaxPageSuccess";
	}
	
	public String updateUserForward() throws Exception{
		data=new JSONObject();
		if(id!=0){
   			SimpleDateFormat sff=new SimpleDateFormat("yyyy-MM-dd");
			User u=userService.get(id);
			data.accumulate("id", u.getId());
			data.accumulate("name", u.getName());
			data.accumulate("maxim", u.getMaxim()==null?"":u.getMaxim());
			data.accumulate("checkflag", u.getCheckflag()==null?false:u.getCheckflag());
			if(u.getRegisterdate()!=null)
				data.accumulate("registerdate", sff.format(u.getRegisterdate()));
			else
				data.accumulate("registerdate","");
			if(u.getLastlogindate()!=null)
				data.accumulate("lastlogindate", sff.format(u.getLastlogindate()));
			else
				data.accumulate("lastlogindate","");
			data.accumulate("headImage", u.getHeadImage()==null?"": u.getHeadImage());
			data.accumulate("registeremail", u.getRegisteremail()==null?false:u.getRegisteremail());
		}
		return "ajaxPageSuccess";
	}
	
	public String updateUser() throws Exception{
		data=new JSONObject();
		if(user!=null){
			int id=user.getId();
			if(id!=0){
				User u=userService.get(id);
				u.setMaxim(user.getMaxim());
				u.setHeadImage(user.getHeadImage());
				userService.merger(u);
				data.accumulate("success", true);
				data.accumulate("msg", "");
			}else{
				data.accumulate("success", false);
				data.accumulate("msg", "更新User对象的id不能为空");
			}
		}else{
			data.accumulate("success", false);
			data.accumulate("msg", "更新User对象的参数不能为空");
		}
		return "ajaxPageSuccess";
	}
	
	public String addUser() throws Exception{
		data=new JSONObject();
	    User u=this.getUser();
	    if(u!=null){
	    	u.setRegisterdate(new Date());
	    	u.setLastlogindate(new Date());
	    	String pass=u.getPassword();
	    	if(pass!=null)
	    		pass=encryptUtil.Encrypt(pass);
	    	u.setPassword(pass);
	        userService.save(u);
			data.accumulate("success",true);
			data.accumulate("msg", "");
	    }else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的User参数不能为空");
	    }
		return "ajaxPageSuccess";
	}
	public String deleteUser() throws Exception{
		data=new JSONObject();
		if(id!=0){
			User u=userService.get(id);
			List<Resume> list=resumeService.findAllByCriteria("user", u);
			if(list!=null&&list.size()>0){
				for(Resume resume:list){
					List<EmployeeRelation> elist=employeeService.findExampleByCriteria("pk.resume", resume);
					if(elist!=null&&elist.size()>0)
						employeeService.deleteAll(elist);
				}
				resumeService.deleteAll(list);
			}
			userService.delete(u);
			data.accumulate("success",true);
			data.accumulate("msg", "");
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的Userid不能为空");
		}
		return "ajaxPageSuccess";
	}
	
	public String addResume() throws Exception{
		data=new JSONObject();
		if(resume!=null&&user!=null&&resumeDetail!=null){
			int userId=user.getId();
			if(userId!=0){
				User u=userService.get(userId);
				int type= resumeDetail.getDocumenttype();
				if(type==-1)
					resumeDetail.setDocumentcode(null);
				Resume re=new Resume();
				re.setDefaultResumeFlag(false);
				re.setCreationdate(new Date());
				re.setCompeleteflag(false);
				re.setUpdatedate(new Date());
				re.setCompeletepercent(null);
				re.setName(resume.getName());
				re.setPublic_flag(resume.getPublic_flag());
				re.setUser(u);
				resumeDetail.setResume(re);
				resumeDetailService.save(resumeDetail);
				data.accumulate("success", true);
				data.accumulate("msg","");
			}else{
				data.accumulate("success", false);
				data.accumulate("msg","获取用户的id失败,添加简历失败");
			}
		}else{
			data.accumulate("success", false);
			data.accumulate("msg","传入简历或者用户或者简历详情为空,添加简历失败");
		}
		resume.getCompeleteflag();
		user.getId();
		resumeDetail.getAwards();
		return "ajaxPageSuccess";
	}
	public String updateResumeForward() throws Exception{
		data=new JSONObject();
		if(id!=0){
			Resume re=resumeService.get(id);
			data.accumulate("id",re.getId());
			data.accumulate("userId",re.getUser().getId());
			data.accumulate("userName",re.getUser().getName()==null?"":re.getUser().getName());
			data.accumulate("name",re.getName()==null?"":re.getName());
			data.accumulate("public_flag",re.getPublic_flag()==null?"0":(re.getPublic_flag()==true?"1":"0"));
			ResumeDetail rd=re.getResumeDetail();
			if(rd!=null){
				data.accumulate("resumeDetailId",rd.getId());
				data.accumulate("realname",rd.getRealname()==null?"":rd.getRealname());
				data.accumulate("sex",rd.getSex()==null?"-1":rd.getSex());
				SimpleDateFormat sf=new SimpleDateFormat("MM/dd/yyyy");
				if(rd.getBirthday()==null)
					data.accumulate("birthday","");
				else
					data.accumulate("birthday",sf.format(rd.getBirthday()));
				
				data.accumulate("workyear", rd.getWorkyear()==null?"-1":rd.getWorkyear());
				data.accumulate("documenttype", rd.getDocumenttype()==null?"-1":rd.getDocumenttype());
				data.accumulate("documentcode", rd.getDocumentcode()==null?"":rd.getDocumentcode());
				data.accumulate("livingaddress",rd.getLivingaddress()==null?"":rd.getLivingaddress());
				data.accumulate("email",rd.getEmail()==null?"":rd.getEmail());
				data.accumulate("qq",rd.getQq()==null?"":rd.getQq());
				data.accumulate("wechat",rd.getWechat()==null?"":rd.getWechat());
				data.accumulate("mobile",rd.getMobile()==null?"":rd.getMobile());
				data.accumulate("companytel",rd.getCompanytel()==null?"":rd.getCompanytel());
				data.accumulate("hometel",rd.getHometel()==null?"":rd.getHometel());
				data.accumulate("salary",rd.getSalary()==null?"-1":rd.getSalary());
				data.accumulate("jobstatus",rd.getJobstatus()==null?"-1":rd.getJobstatus());
				data.accumulate("hometown",rd.getHometown()==null?"":rd.getHometown());
				data.accumulate("marriagestatus",rd.getMarriagestatus()==null?"-1":rd.getMarriagestatus());
				data.accumulate("height",rd.getHeight());
				data.accumulate("politicstatus",rd.getPoliticstatus()==null?"-1":rd.getPoliticstatus());
				data.accumulate("photo",rd.getPhoto()==null?"":rd.getPhoto());
				data.accumulate("zip",rd.getZip()==null?"":rd.getZip());
				data.accumulate("worktype",rd.getWorktype()==null?"-1":rd.getWorktype());
				data.accumulate("workspace",rd.getWorkspace()==null?"":rd.getWorkspace());
				data.accumulate("positiontype",rd.getPositiontype()==null?"-1":rd.getPositiontype());
				data.accumulate("exceptsalary",rd.getExceptsalary()==null?"":rd.getExceptsalary());
				data.accumulate("selfIntrodution",rd.getSelfIntrodution()==null?"":rd.getSelfIntrodution());
				data.accumulate("onboardingdate",rd.getOnboardingdate()==null?"":rd.getOnboardingdate());
				data.accumulate("skills",rd.getSkills()==null?"":rd.getSkills());
				data.accumulate("companys",rd.getCompanys()==null?"":rd.getCompanys());
				data.accumulate("awards",rd.getAwards()==null?"":rd.getAwards());
				data.accumulate("experiences", rd.getExperiences()==null?"":rd.getExperiences());
			}
		}
		return "ajaxPageSuccess";
	}
	public String updateResume() throws Exception{
		data=new JSONObject();
		if(user!=null){
			int userId=user.getId();
			if(userId!=0){
				User u=userService.get(userId);
				if(u!=null){
					if(resume!=null){
						int resumeId=resume.getId();
						Resume re=resumeService.get(resumeId);
						if(re!=null){
							resume.setCompeleteflag(re.getCompeleteflag());
							resume.setCompeletepercent(re.getCompeletepercent());
							resume.setCreationdate(re.getCreationdate());
							resume.setDefaultResumeFlag(re.isDefaultResumeFlag());
							if(resumeDetail.getDocumenttype()!=null&&resumeDetail.getDocumenttype()==-1)
								resumeDetail.setDocumentcode(null);
							resume.setUpdatedate(re.getUpdatedate());
							resume.setUser(u);
							resumeDetail.setResume(resume);
							resumeDetailService.merge(resumeDetail);
							resume.setResumeDetail(resumeDetail);
							resumeService.merge(resume);
							data.accumulate("success",true);
							data.accumulate("msg","");
						}else{
							data.accumulate("success",false);
							data.accumulate("msg","未查询到需要更新简历!");
						}
					}else{
						data.accumulate("success",false);
						data.accumulate("msg","更新简历不能为空!");
					}
				}else{
					data.accumulate("success",false);
					data.accumulate("msg","未查询到需要更新简历的用户!");
				}
			}else{
				data.accumulate("success",false);
				data.accumulate("msg","更新简历的用户Id不能为空!");
			}
		}else{
			data.accumulate("success",false);
			data.accumulate("msg","更新简历的用户不能为空!");
		}
		return "ajaxPageSuccess";
	}
	
    /*
     * 设置为默认简历列表
     * */
    public String setDefautResume() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
	  
	    	List<Resume> list=resumeService.findByNamedParam("from Resume resume where resume.defaultResumeFlag=:defaultResumeFlag and resume.user.id=:userId",new String[]{"defaultResumeFlag","userId"} , new Object[]{true,user.getId()});
	    	
    		if(list!=null&&list.size()>0){
                data.accumulate("success", false);
                data.accumulate("msg", "只能设置一份简历为默认简历！");
    		}else{
        		Resume re=resumeService.get(id);
        		if(re!=null){
        			re.setDefaultResumeFlag(true);
        			resumeService.update(re);
                    data.accumulate("success", true);
                    data.accumulate("msg", "");
        		}else{
                    data.accumulate("success", false);
                    data.accumulate("msg", "未找到对应的简历！");
        		}
    		}
    	}else{
            data.accumulate("success", false);
            data.accumulate("msg", "传入的id不能为空");
    	}
    	return "ajaxPageSuccess";
    }
    /*
     * 取消默认简历列表
     * */
    public String unSetDefautResume() throws Exception{
    	data=new JSONObject();
    	if(id!=0){
    		Resume re=resumeService.get(id);
    		if(re!=null){
    			re.setDefaultResumeFlag(false);
    			resumeService.update(re);
                data.accumulate("success", true);
                data.accumulate("msg", "");
    		}else{
                data.accumulate("success", false);
                data.accumulate("msg", "未找到对应的简历！");
    		}
    	}else{
            data.accumulate("success", false);
            data.accumulate("msg", "传入的id不能为空");
    	}
    	return "ajaxPageSuccess";
    }
	public String deleteResume() throws Exception{
 
		return "ajaxPageSuccess";
	}
	public String findAllResume() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
     	int page = new Integer(request.getParameter("page"));
    	int rows = new Integer(request.getParameter("rows"));
    	data=resumeService.findAllResume((page-1)*rows,rows);
		return "ajaxPageSuccess";
	}
	
	
	public String setHotFlag() throws Exception{
		data=new JSONObject();
		if(id!=0){
			Company co=companyService.get(id);
			co.setCpy_hot_flag(true);
			companyService.update(co);
			data.accumulate("success",true);
			data.accumulate("msg", "");
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的公司id不能为空");
		}
		return "ajaxPageSuccess";
	}
	public String unSetHotFlag() throws Exception{
		data=new JSONObject();
		if(id!=0){
			Company co=companyService.get(id);
			co.setCpy_hot_flag(false);
			companyService.update(co);
			data.accumulate("success",true);
			data.accumulate("msg", "");
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "传入的公司id不能为空");
		}
		return "ajaxPageSuccess";
	}
	
	public String findAllCompany() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
     	int page = new Integer(request.getParameter("page"));
    	int rows = new Integer(request.getParameter("rows"));
    	data=companyService.findAllCompany((page-1)*rows,rows);
		return "ajaxPageSuccess";
	}
	 
	public String addCompany() throws Exception{
		data=new JSONObject();
		if(company!=null){
			company.setCreationDate(new Date());
			company.setCpy_hot_flag(false);
			String loginPass=company.getCpy_loginPass();
			if(!Strings.isNullOrEmpty(loginPass))
				loginPass=encryptUtil.Encrypt(loginPass);
			company.setCpy_loginPass(loginPass);
			companyService.save(company);
			data.accumulate("success", true);
			data.accumulate("msg","");
		}else{
			data.accumulate("success", false);
			data.accumulate("msg","你传入的企业信息不能为空");
		}
		return "ajaxPageSuccess";
	}
	
	public String updateCompanyForward() throws Exception{
		data=new JSONObject();
		if(id!=0){
			Company co=	companyService.get(id);
			if(co!=null){
				  data.accumulate("id",co.getId());
				  data.accumulate("cpy_loginName",co.getCpy_loginName()==null?"":co.getCpy_loginName());
				  data.accumulate("companyName",co.getCompanyName()==null?"":co.getCompanyName());
				  data.accumulate("companySize",co.getCompanySize()==null?"-1":co.getCompanySize());
				  data.accumulate("companyType",co.getCompanyType()==null?"-1":co.getCompanyType());
				  data.accumulate("companyDesc",co.getCompanyDesc()==null?"":co.getCompanyDesc());
				  data.accumulate("legalPerson",co.getLegalPerson()==null?"":co.getLegalPerson());
				  data.accumulate("companyURL",co.getCompanyURL()==null?"":co.getCompanyURL());//公司网址
				  data.accumulate("companyTel",co.getCompanyTel()==null?"":co.getCompanyTel());//公司电话
				  data.accumulate("companyEmail",co.getCompanyEmail()==null?"":co.getCompanyEmail());//公司email
				  data.accumulate("companyAddress",co.getCompanyAddress()==null?"":co.getCompanyAddress());//公司地址
				  data.accumulate("companyLogo",co.getCompanyLogo()==null?"":co.getCompanyLogo());
			}
		}
		return "ajaxPageSuccess";
	}
	public String updateCompany() throws Exception{
		data=new JSONObject();
		if(company!=null){
			int companyId=company.getId();
			Company co=companyService.get(companyId);
			if(co!=null){
				company.setLastLoginDate(co.getLastLoginDate());
				company.setCpy_loginName(co.getCpy_loginName());
				company.setCpy_loginPass(co.getCpy_loginPass());
				company.setCpy_hot_flag(co.isCpy_hot_flag());;
				company.setCreationDate(co.getCreationDate());
				companyService.merge(company);
				data.accumulate("success",true);
				data.accumulate("msg", "");
			}else{
				data.accumulate("success",false);
				data.accumulate("msg", "获取企业信息失败");
			}
			co=null;
		}else{
			data.accumulate("success",false);
			data.accumulate("msg", "更新的企业信息不能为空");
		}
		return "ajaxPageSuccess";
	}
	
	public String deleteCompany() throws Exception{
		return null;
	}
	
	public String findAllHireinfo() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
     	int page = new Integer(request.getParameter("page"));
    	int rows = new Integer(request.getParameter("rows"));
    	data=hireinfoService.findAllHireinfo((page-1)*rows,rows);
		return "ajaxPageSuccess";
	}
	
	public String addHireInfo() throws Exception{
		return null;
	}
	
	public String updateHireInfo() throws Exception{
		return null;
	}
}
