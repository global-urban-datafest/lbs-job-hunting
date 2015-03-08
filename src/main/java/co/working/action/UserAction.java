package co.working.action;

import com.google.common.base.Strings;
import com.opensymphony.xwork2.ActionSupport;
import co.working.model.*;
import co.working.service.impl.*;
import co.working.util.CommonUtil;
import co.working.util.EncryptUtil;
import co.working.util.convert.DateJsonValueProcessor;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.json.annotations.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller("userAction")
public class UserAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	//-----------------------------------常量部分------------------------------------
    public static final String RANDOMCODEKEY = "RANDOMVALIDATECODEKEY";//放到session中的key
    private static final String ERROR_MESS="error_message";
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

    private User user;
    @JSON(serialize = false)
    public User getUser() {
        return user;
    }
    public void setUser(User user) {
        this.user = user;
    }
    
    private Resume resume;
	@JSON(serialize = false)
    public Resume getResume() {
		return resume;
	}
	public void setResume(Resume resume) {
		this.resume = resume;
	}
    
    private ResumeDetail resumeDetail;
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
	/*
    * 用户或者公司登录
    * */
    public String login() throws Exception {
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        String loginType=request.getParameter("loginType");
        Object obj=session.getAttribute(RANDOMCODEKEY);
        Object mess=session.getAttribute(ERROR_MESS);
        if(mess!=null)
            session.removeAttribute(ERROR_MESS);
        mess=null;
        if(obj!=null&&!"".equals(obj)){
            if(loginType!=null&&!"".equals(loginType)){
            /*loginType值为1时，则表示是用户登录*/
                if("1".equals(loginType)){
                    /*首先判断当前验证码是否一致*/
                    String userCode=request.getParameter("usercode");
                    if(userCode!=null&&userCode.equalsIgnoreCase(obj.toString())){
                        /*
                         *  当验证码正确时，此时先判断当前登录名，在数据库里是否存在，
                         *  若存在再继续比较密码，若不存在，则直接返回用户不存在
                        */
                        String username=user.getName();
                        String userpass=user.getPassword();
                        if(!Strings.isNullOrEmpty(username)&&!Strings.isNullOrEmpty(userpass)){
                            User usr=new User();
                            usr.setName(username);
                          List<User> list= userService.findAllByExample(usr);
                            usr=null;
                          if(list!=null&&!list.isEmpty()&&list.size()==1){
                                User temp=list.get(0);
                                String tmppass=temp.getPassword();
                                //  获取前台传入的密码，调用加密工具类将前台传入的密码进行加密，再与数据库中查询的结果比较
                                userpass=encryptUtil.Encrypt(userpass);
                                if(!Strings.isNullOrEmpty(tmppass)&&userpass.equals(tmppass)){
                                    if(session.getAttribute("loginUser")!=null)
                                        session.removeAttribute("loginUser");
                                    session.setAttribute("loginUser",temp);
                                    if(session.getAttribute("loginType")!=null)
                                        session.removeAttribute("loginType");
                                    session.setAttribute("loginType",1);
                                    //在用户登录成功之后加载基础的reference
                                    referenceService.initBaseReference(session);
                                    //展示热门企业列表
                                    List<Company> companylist=companyService.findExampleByCriteria("cpy_hot_flag", true,0,5);
                                    session.setAttribute("companylist",companylist);
                                    //展示招聘列表
                                    Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
                                    Map<String,Object> submap=new HashMap<String,Object>();
                                    submap.put("disabledFlag", false);
                                    submap.put("hotflag", true);
                                    map.put("eq", submap);
                                    submap=null;
                                    List<HireInfo> hireinfolist=hireinfoService.findExampleByCriteriaAndMap(map,0, 5);
                                    map=null;
                                    session.setAttribute("hireinfolist",hireinfolist);
                                    
                                    //登录成功之后，更新一下登录时间
                                    temp.setLastlogindate(new Date());
                                    userService.update(temp);
                                    return "userLoginSuccess";
                                }else{
                                    request.setAttribute(ERROR_MESS, "用户名或者密码不正确！");
                                    return "loginError";
                                }
                          }else{
                        	  request.setAttribute(ERROR_MESS, "用户不存在！");
                              return "loginError";
                          }
                        }else{
                        	request.setAttribute(ERROR_MESS, "用户名或者密码为空！");
                                return "loginError";
                        }
                    }else{
                    	request.setAttribute(ERROR_MESS, "验证码为空或者验证码不正确！");
                        return "loginError";
                    }
                } else{
                    return "loginError";
                }
            }else{
            	request.setAttribute(ERROR_MESS, "请选择一种身份登录本系统！");
                return "loginError";
            }
        }else{

        	request.setAttribute(ERROR_MESS, "获取验证码失败！");
            return "loginError";
        }
    }

    /*
    *  用户注册，这里提供的快速注册
    *  */
    public String register() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        //HttpSession session=request.getSession();
        String loginType=request.getParameter("loginType");
        if(loginType!=null&&"1".equals(loginType)){
        	User u=this.getUser();
        	if(u!=null){
            	u.setRegisterdate(new Date());
            	u.setLastlogindate(new Date());
            	String pass=u.getPassword();
            	if(pass!=null)
            		pass=encryptUtil.Encrypt(pass);
            	u.setPassword(pass);
                try{
                    userService.save(u);
                }catch(Exception e){
                    return "registerError";
                }
            	return "registerLoginSuccess";
        	}else{
                request.setAttribute(ERROR_MESS,"注册信息不完整或者缺失");
        		return "registerError";
        	}
        }else{
            request.setAttribute(ERROR_MESS,"注册类型不能为空");
        	return "registerError";
        }
    }

    /*
    * 用户信息更新
    * */
    public String update() throws Exception {
        User usr=this.getUser();
        int id =usr.getId();
        String headImage=usr.getHeadImage();
        String maxim=usr.getMaxim();
        if(id!=0){
            User tmp=userService.findExampleById(id);
            if(tmp!=null){
                tmp.setHeadImage(headImage);
                tmp.setMaxim(maxim);
                userService.update(tmp);
            }
            tmp=null;
        }
        usr=null;
        headImage=null;
        maxim=null;
        data=new JSONObject();
        data.accumulate("msg",true);
        return "ajaxSuccess";
    }

    /*
    * email唯一性验证
    * */
    public String verifyEmail() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String type=request.getParameter("type");
        data=new JSONObject();
        if(!Strings.isNullOrEmpty(type)){
            if("1".equals(type)){
                User tmp=new User();
                tmp.setRegisteremail(this.user.getRegisteremail());
                List<User> list=userService.findAllByExample(tmp);
                if(list==null||(list!=null&&list.size()==0))
                {
                    data.accumulate("success","true");
                    data.accumulate("msg","");
                }else{
                    data.accumulate("success","false");
                    data.accumulate("msg","该Email不可以使用");
                }
                tmp=null;
            }
        }else{
            data.accumulate("success","false");
            data.accumulate("msg","注册类型不能为空");
        }
        return "ajaxSuccess";
    }

    /*
    * LoginName唯一性验证
    * */
    public String verifyLoginName() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String type=request.getParameter("type");
        data=new JSONObject();
        if(!Strings.isNullOrEmpty(type)){
            if("1".equals(type)){
                User tmp=new User();
                tmp.setName(this.user.getName());
                List<User> list=userService.findAllByExample(tmp);
                if(list==null||(list!=null&&list.size()==0))
                {
                    data.accumulate("success","true");
                    data.accumulate("msg","");
                }else{
                    data.accumulate("success","false");
                    data.accumulate("msg","该用户名不可以使用");
                }
                tmp=null;
            }
        }else{
            data.accumulate("success","false");
            data.accumulate("msg","注册类型不能为空");
        }
        return "ajaxNameSuccess";
    }

    /*
    * 用户注销方法
    * */
    public String loginOut() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        session.invalidate();
        return "logoutSuccess";
    }

    /*
     * 获取用户信息
     * */
    public String userProfileForward() throws Exception{
    	HttpServletRequest request=ServletActionContext.getRequest();
    	//获取参数id
    	String id=request.getParameter("id");
    	if(id!=null){
    		User tmp=userService.findExampleById(Integer.parseInt(id));
    		request.setAttribute("user", tmp);
    		tmp=null;
    		return "userProfile";
    	}else{
    		return "login";
    	}
  
    }
    /*
	 * 获取用户信息
	 * */
    public String userPassForward() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        //获取参数id
        String id=request.getParameter("id");
        if(id!=null){
            User tmp=userService.findExampleById(Integer.parseInt(id));
            request.setAttribute("user", tmp);
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
        User usr=this.getUser();
        int id =usr.getId();
        String pass=usr.getPassword();
        data=new JSONObject();
        if(id!=0){
        	User tmp=userService.findExampleById(id);
        	String repass=tmp.getPassword();
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
        	tmp=null;
        }else{
            data.accumulate("msg",false);
        }
        pass=null;
        usr=null;
    	return "ajaxSuccess";
    }
    /*
     * 修改密码
     * */
    public String updateUserPass() throws Exception{
    	  User usr=this.getUser();
          int id =usr.getId();
          String pass=usr.getPassword();
          data=new JSONObject();
          if(id!=0){
          	User tmp=userService.findExampleById(id);
          	if(!Strings.isNullOrEmpty(pass)){
          		pass=encryptUtil.Encrypt(pass);
          		tmp.setPassword(pass);
          		userService.update(tmp);
          		data.accumulate("msg",true);
          	}else{
                  data.accumulate("msg",false);
          	}	
          	tmp=null;
          }else{
              data.accumulate("msg",false);
          }
          pass=null;
          usr=null;
      	return "ajaxSuccess";
    }
    /*
     * 查找该用户的所有简历
     * */
    public String findAllResumes() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        User user =new User();
        user.setId(id);
        List<Resume> list= resumeService.findAllByCriteria("user",user);
        request.setAttribute("resumes",list);
    	return "resumeList";
    }
    /*
     * 删除简历
     * */
    public String deleteResume() throws Exception{
    	//因为两者使用的是同一个id，所以
    	resumeDetailService.detele(id);
        resumeService.delete(id);
        data=new JSONObject();
        data.accumulate("msg", true);
        return "ajaxSuccess";
    }
    /*
     * 计算简历百分比
     * */
    private Double getResumePercent(Resume resume){
    	Double pe=0.0;
    	if(resume!=null&&resume.getId()!=0){
    		ResumeDetail rd=resume.getResumeDetail();
    		if(rd!=null){
    			pe=CommonUtil.getPercent(rd);
    		}
    		resume.setCompeletepercent(pe);
    		if(pe.equals(1%1.0)){
    			resume.setCompeleteflag(true);
    		}
    	}
    	return pe;
    }
    /*
     * 跳转简历详情页面
     * */
    public String userResumeForward() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String id=request.getParameter("id");
        if(!Strings.isNullOrEmpty(id)){
            Resume resume= resumeService.findExampleById(Integer.parseInt(id));
            getResumePercent(resume);
            resumeService.update(resume);
            request.setAttribute("resume",resume);
        }
        return "resumeDetail";
    }
    /*
     * 跳转简历阅览页面
     * */
    public String viewResume() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String id=request.getParameter("id");
        if(!Strings.isNullOrEmpty(id)){
            Resume resume= resumeService.findExampleById(Integer.parseInt(id));
            request.setAttribute("resume",resume);
        }
        return "viewResumeShow";
    }
    
    /*
     * 保存简历
     * */
    public String saveResume() throws Exception{
        String name=this.getResume().getName();
        data=new JSONObject();
        if(!Strings.isNullOrEmpty(name)){
            Resume res=new Resume();
            res.setName(name);
           List<Resume> list=resumeService.findAllByExample(res);
            if(list==null||(list!=null&&list.size()==0)){
                this.getResume().setCompeleteflag(false);
                this.getResume().setUpdatedate(new Date());
                this.getResume().setCreationdate(new Date());
                this.getResume().setUser(this.getUser());
                ResumeDetail rd=new ResumeDetail();       
/*              ResumeDetail resumeDetail=new ResumeDetail();
                ResumeDetail tmp= resumeDetailService.save(resumeDetail);
                this.getResume().setResumeDetail(tmp);*/
                this.getResume().setResumeDetail(rd);
                rd.setResume(this.getResume());
                resumeService.save(this.getResume());
                data.accumulate("success", true);
                data.accumulate("msg", "");
            }else{
                data.accumulate("success", false);
                data.accumulate("msg", "该简历已经存在！");
            }
        }else{
            data.accumulate("success", false);
            data.accumulate("msg", "简历名称不能为空！");
        }
    	return "ajaxSuccess";
    }
    /*
     * 更新简历基础信息
     * */
    public String updateResumeDetail()throws Exception{
        data=new JSONObject();
        ResumeDetail rd=this.getResumeDetail();
        Integer id=rd.getId();
    	if(id!=0){
    			if(rd.getDocumenttype().equals(-1)){
        			rd.setDocumenttype(null);
        			rd.setDocumentcode(null);
    			}
        		if(rd.getPoliticstatus().equals(-1))
        			rd.setPoliticstatus(null);
        		if(rd.getWorkyear().equals(-1))
        			rd.setWorkyear(null);
        		if(rd.getSex().equals(-1))
        			rd.setSex(null);
        		if(rd.getSalary().equals(-1))
        			rd.setSalary(null);
        		if(rd.getMarriagestatus().equals(-1))
        			rd.setMarriagestatus(null);
        		if(rd.getJobstatus().equals(-1))
        			rd.setJobstatus(null);
        		if(rd.getWorktype().equals(-1))
        			rd.setWorktype(null);
        		if(rd.getPositiontype().equals(-1))
        			rd.setPositiontype(null);
        		resumeDetailService.update(rd);
                data.accumulate("success", true);
                data.accumulate("msg", "");
    	}else{
            data.accumulate("success", false);
            data.accumulate("msg", "更新简历详情失败,未找到对应的简历详情！");
    	}
    	rd=null;
    	id=null;
    	return "ajaxSuccess";
    }
    /*
     * 更新简历详情
     * */
    public String userCompanyProfile() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
  		request.removeAttribute("company");
		request.removeAttribute("HireInfolist");
    	if(id!=0){
    		   Company company=companyService.findExampleById(id);
    	       Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
    	       Map<String,Object> submap=new HashMap<String,Object>();
    	       submap.put("company", company);
    	       submap.put("disabledFlag", false);
    	       map.put("eq", submap);
    	       submap=null;
    		List<HireInfo> HireInfolist=hireinfoService.findExampleByCriteriaAndMap(map);
    		request.setAttribute("HireInfolist",HireInfolist);
    		request.setAttribute("company", company);
    	}
    	return "userCompanyProfile";
    }
    /*
     * 返回企业列表
     * */
    public String userCompanyList() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String CompanyName=request.getParameter("CompanyName");
        String address=request.getParameter("address");
        Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
        if(!Strings.isNullOrEmpty(CompanyName)){
        	Map<String,Object> submap=new HashMap<String,Object>();
        	submap.put("companyName", CompanyName);
        	map.put("like", submap);
        	submap=null;
        }
        if(!Strings.isNullOrEmpty(address)){
        	Map<String,Object> submap=new HashMap<String,Object>();
        	submap.put("companyAddress", address);
        	map.put("like", submap);
        	submap=null;
        }	
        List<Company> list=companyService.findExampleByCriteriaAndMap(map);
    	data=new JSONObject();
        if(list!=null){
        	JsonConfig cfg=new JsonConfig();
        	cfg.registerJsonValueProcessor(Date.class,new DateJsonValueProcessor("yyyy-MM-dd"));
        	cfg.setAllowNonStringKeys(true);
        	cfg.setExcludes(new String[]{"hireinfoes","lastLoginDate","cpy_loginPass","cpy_loginName"});
        	JSONArray array=JSONArray.fromObject(list,cfg);
        	cfg=null;
        	data.accumulate("rows", array);
        }else{
        	data.accumulate("rows", "");
        }
    	return "ajaxPageSuccess";
    }
    /*
     * 返回职位列表
     * */
    public String userHireinfoList() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        String positionName=request.getParameter("positionName");
        String workplace=request.getParameter("workplace");
        String worktype=request.getParameter("worktype");
        Map<String,Map<String,Object>> map=new HashMap<String,Map<String,Object>>();
        if(!Strings.isNullOrEmpty(positionName)){
        	Map<String,Object> submap=new HashMap<String,Object>();
        	submap.put("positionName", positionName);
        	map.put("like", submap);
        	submap=null;
        }
        if(!Strings.isNullOrEmpty(workplace)){
        	Map<String,Object> submap=new HashMap<String,Object>();
        	submap.put("workplace", workplace);
        	map.put("like", submap);
        	submap=null;
        }
        if(!Strings.isNullOrEmpty(worktype)&&!"-1".equals(worktype)){
        	Map<String,Object> submap=new HashMap<String,Object>();
        	submap.put("worktype", Integer.parseInt(worktype));
        	map.put("eq", submap);
        	submap=null;
        }

    	Map<String,Object> submap=new HashMap<String,Object>();
    	submap.put("disabledFlag",false);
    	map.put("eq", submap);
    	submap=null;

        List<HireInfo> list=hireinfoService.findExampleByCriteriaAndMap(map);
    	data=new JSONObject();
        if(list!=null){
        	JsonConfig cfg=new JsonConfig();
        	cfg.registerJsonValueProcessor(Date.class,new DateJsonValueProcessor("yyyy-MM-dd"));
        	cfg.setAllowNonStringKeys(true);
        	cfg.setExcludes(new String[]{"employeerelations","company","cpy_loginPass","cpy_loginName"});
        	JSONArray array=JSONArray.fromObject(list,cfg);
        	cfg=null;
        	data.accumulate("rows", array);
        }else{
        	data.accumulate("rows", "");
        }
    	return "ajaxPageSuccess";
    }
    /*
     * 返回职位详情
     * */
    public String hireinfoProfile() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
    	if(id!=0){
    		HireInfo  hr=	hireinfoService.get(id);
    		request.removeAttribute("hireinfo");
    		if(hr!=null)
    			request.setAttribute("hireinfo", hr);
    			
    	}
    	return "hireinfoProfile";
    }
    /*
     * 返回简历列表
     * */
    public String findResumeList() throws Exception{
        HttpServletRequest request=ServletActionContext.getRequest();
        data=new JSONObject();
        int total=0;
        String userId=request.getParameter("id");
        if(!Strings.isNullOrEmpty(userId)){
        	int id=Integer.parseInt(userId);
        	User u=new User();
        	u.setId(id);
        	total=resumeService.getCount("user", u);
         	int page = new Integer(request.getParameter("page"));
        	int rows = new Integer(request.getParameter("rows"));
        	List<Resume> list=resumeService.findAllByCriteria("user", u, (page-1)*rows, rows);
        	if(list!=null&&list.size()>0&&total!=0){
                data.accumulate("total", total);
        		JSONArray rowArray = new JSONArray();
       			SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
        		for(Resume resume:list){
        			JSONObject obj=new JSONObject();
        			obj.accumulate("id",resume.getId() );
        			obj.accumulate("name",resume.getName()==null?"":resume.getName());
        			obj.accumulate("compeleteflag",resume.getCompeleteflag()==null?false:resume.getCompeleteflag());
        			obj.accumulate("compeletepercent",resume.getCompeletepercent()==null?"0":resume.getCompeletepercent()+"%");
        			if(resume.getCreationdate()!=null)
        				obj.accumulate("creationdate",sf.format(resume.getCreationdate()));
        			else
        				obj.accumulate("creationdate","");
        			obj.accumulate("public_flag",resume.getPublic_flag()==null?false:resume.getPublic_flag());
        			rowArray.add(obj);
        			obj=null;
        		}
    			sf=null;
        		data.accumulate("rows", rowArray);
        	}else{
        		 data.accumulate("total", 0);
        		data.accumulate("rows", "");
        	}
        }else{
	   		 data.accumulate("total", total);
	   		data.accumulate("rows", "");
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
    /*
     * 应聘
     * */
    public String sendResume() throws Exception{
    	data=new JSONObject();
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        Object obj= session.getAttribute("loginUser");
        if(obj!=null){
        	User usr=(User)obj;
        	String hql="from Resume resume where resume.user=:user and resume.defaultResumeFlag=:flag";
        	List<Resume> list=resumeService.findByNamedParam(hql,new String[]{"user","flag"},new Object[]{usr,true});
        	if(list!=null&&list.size()==1){
        		Resume re=list.get(0);
        		List<EmployeeRelation> elist=employeeService.findExampleByCriteria("pk.resume", re);
        		if(elist!=null&&elist.size()>0){
                    data.accumulate("success", false);
                    data.accumulate("msg", "你已经申请过该职位");	
        		}else{
            		if(id!=0){
            			HireInfo hr=hireinfoService.get(id);
            			if(re!=null&&hr!=null){
            				EmployeeRelation er=new EmployeeRelation();
            				EmployeeRelationPK pk=new EmployeeRelationPK();
            				pk.setHireinfo(hr);
            				pk.setResume(re);
            				er.setPk(pk);
            				er.setSendDate(new Date());
            				er.setViewFlag(1);
            				employeeService.save(er);
                            data.accumulate("success", true);
                            data.accumulate("msg", "");	
            			}else{
                            data.accumulate("success", false);
                            data.accumulate("msg", "未查找到对应的简历或者职位记录");	
            			}
            		}
        		}
        	}else{
                data.accumulate("success", false);
                data.accumulate("msg", "查找的简历记录不存在或者太多");	
        	}
        }else{
            data.accumulate("success", false);
            data.accumulate("msg", "用户参数不能为空!");
        }
    	return "ajaxPageSuccess";
    }
    /*
     * 查找投递信息
     * */
    public String  EmployRelationHistory(){
        HttpServletRequest request=ServletActionContext.getRequest();
        HttpSession session=request.getSession();
        Object obj= session.getAttribute("loginUser");
        List<EmployeeRelation> lists=new ArrayList<EmployeeRelation>();
        if(obj!=null){
        	User usr=(User)obj;
        	if(usr!=null){
        		List<Resume> list=resumeService.findAllByCriteria("user",usr);
        		if(list!=null&&list.size()>0){
        			for(Resume resume:list){
                		List<EmployeeRelation> elist=employeeService.findExampleByCriteria("pk.resume",resume);
                		lists.addAll(elist);
        			}
        		}
        	}
        }
        request.setAttribute("employees", lists);
    	return "EmployRelationHistory";
    }
}
